import 'dart:async';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/router/app_router.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/logger.dart';
import 'package:vpn/core/shared/utils/IAPConnectionPurchase.dart';
import 'package:vpn/core/shared/utils/consumable_store.dart';
import 'package:vpn/features/home/presentation/logic/main_cubit/main_cubit.dart';
import 'package:vpn/features/tarif/domain/usecases/traif_usecases.dart';
import 'package:vpn/locator.dart';
part 'purchases_state.dart';

class PurchasesCubit extends Cubit<PurchasesStatus> {
  PurchasesCubit(this.traifUsecases, this._systemInfoService)
      : super(PurchasesInitial()) {
    initStoreInfo();
  }

  TraifUsecases traifUsecases;
  final SystemInfoService _systemInfoService;
  CacheHelper cacheHelper = locator<CacheHelper>();
  MainCubit mainCubit = locator<MainCubit>();

  Stream<List<PurchaseDetails>>? purchaseUpdated;
  static PurchasesCubit get(context) => BlocProvider.of(context);
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? subscription;
  List<String> notFoundIds = <String>[];
  List<ProductDetails> tarifs = <ProductDetails>[];
  List<PurchaseDetails> purchases = <PurchaseDetails>[];
  List<String> consumables = <String>[];
  bool isAvailable = false;
  bool purchasePending = false;
  bool loading = true;
  String? queryProductError;
  bool isButtonPulsing = false;
  final iapConnection = IAPConnection.instance;
  Future closeSubscription() async {
    if (!isAndroid) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    if (subscription != null) await subscription!.cancel();
    subscription = null;
    if (purchaseUpdated != null) purchaseUpdated!.distinct();
    emit(EndPendingPurchaseState());
  }

  int indexTariff = 1;
  void changeIndexTariff(int index) {
    emit(ChangePurchaseState());
    indexTariff = index;
    emit(StopChangePurchaseState());
  }

  void goToHome(BuildContext context) async {
    await closeSubscription();
    AutoRouter.of(context)
        .pushAndPopUntil(const PrivacyPolicyRoute(), predicate: (_) => false);

    MainCubit.get(context).getDataServiceAcc();
  }

  final isAndroid = Platform.isAndroid;

  String get currentProductId =>
      _systemInfoService.vpnInfo?.userInfo?.tarifInfo?.productId ?? "";

  set currentProductId(String value) => value;
  void subscriptionInit() {
    print(_systemInfoService.vpnInfo?.userInfo?.tarifInfo?.productId ?? "");
    purchaseUpdated = inAppPurchase.purchaseStream;
    subscription = purchaseUpdated!.listen(
        (List<PurchaseDetails> purchaseDetailsList) async {
      print("subscription listen");
      await _listenToPurchaseUpdated(purchaseDetailsList
          .where((element) => element.productID != currentProductId)
          .toList());
      return;
    }, onDone: () {
      // if (subscription != null) subscription!.cancel();
    }, onError: (Object error) {
      // dispose();
    });
  }

  Future<void> initStoreInfo() async {
    emit(LoadingInitStoreInfoState());
    bool isAvailable = await inAppPurchase.isAvailable();
    if (!isAvailable) {
      isAvailable = isAvailable;
      tarifs = <ProductDetails>[];
      purchases = <PurchaseDetails>[];
      notFoundIds = <String>[];
      consumables = <String>[];
      purchasePending = false;
      loading = false;
      return;
    }

    if (!isAndroid) {
      var paymentWrapper = SKPaymentQueueWrapper();
      var transactions = await paymentWrapper.transactions();
      transactions.forEach((transaction) async {
        await paymentWrapper.finishTransaction(transaction);
      });
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await inAppPurchase.queryProductDetails(kProductIds.toSet());
    print("productDetailResponse.productDetails");
    print(productDetailResponse.productDetails);
    if (productDetailResponse.error != null) {
      queryProductError = productDetailResponse.error!.message;
      isAvailable = isAvailable;
      tarifs = productDetailResponse.productDetails;
      purchases = <PurchaseDetails>[];
      notFoundIds = productDetailResponse.notFoundIDs;
      consumables = <String>[];
      purchasePending = false;
      loading = false;
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      queryProductError = null;
      isAvailable = isAvailable;
      tarifs = productDetailResponse.productDetails;
      purchases = <PurchaseDetails>[];
      notFoundIds = productDetailResponse.notFoundIDs;
      consumables = <String>[];
      purchasePending = false;
      loading = false;
      return;
    }

    List<String> consumableStore = await ConsumableStore.load();
    isAvailable = isAvailable;
    tarifs = productDetailResponse.productDetails;
    print(productDetailResponse.productDetails);
    notFoundIds = productDetailResponse.notFoundIDs;
    consumables = consumableStore;
    purchasePending = false;
    loading = false;
    print("purchaseDetailsList1111 $purchases");
    emit(EndInitStoreInfoState());
  }

  PurchaseDetails? currentPurchaseDetails;
  endSubscriptionLoading() async {
    emit(EndPendingPurchaseState());
  }

  final emptyProductDetails = ProductDetails(
      currencyCode: '',
      description: '',
      id: '',
      price: '',
      rawPrice: 0,
      title: '');

  //buy tarif with receipt or server(api) verification
  String productIdToBuy = "";

  Future buyTarif(productId) async {
    print("productId$productId");
    emit(LoadingPendingPurchaseState());
    late PurchaseParam purchaseParam;
    productIdToBuy = productId;
    if (tarifs.isEmpty) return;
    ProductDetails productDetail =
        tarifs.firstWhere((element) => element.id == productId);

    if (isAndroid) {
      purchaseParam = GooglePlayPurchaseParam(
        productDetails: productDetail,
        applicationUserName: null,
      );
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetail,
        applicationUserName: null,
      );
    }
    inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    subscriptionInit();
  }

  //buy tarif with receipt or server(api) verification
  Future purchaseTarifIos(
      String transactionIdentifier, String productID) async {
    var bay = await cacheHelper.getBaySubscription();
    logger.info('init purchase tarif ios');
    logger.info('locale $bay');
    logger.info('sub $productID');
    if (bay != productID) {
      final res =
          await traifUsecases.buyTarif(transactionIdentifier, productID);
      emit(await res.fold((failure) => ErrorPurchaseState(error: failure),
          (r) async {
        currentProductId = r.workStatus?.userInfo?.tarifInfo?.productId ?? "";
        if (r.inProgress) {
          return await checkTrans(transactionIdentifier, productID);
        } else {
          await closeSubscription();
          await cacheHelper.saveBaySubscription(productID);
          return SuccessPurchaseState();
        }
      }));
    }
  }

  Future<PurchasesStatus> checkTrans(
      String transactionIdentifier, productID) async {
    final res = await traifUsecases.checkTrans(transactionIdentifier);
    return res.fold((l) => ErrorPurchaseState(error: l), (r) async {
      print("r $r");
      if (r == '1') {
        await closeSubscription();
        await cacheHelper.saveBaySubscription(productID);
        return SuccessPurchaseState();
      } else {
        await Future.delayed(const Duration(seconds: 2));
        return await checkTrans(transactionIdentifier, productID);
      }
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    try {
      for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
        logger.info('listenToPurchaseUpdated   ${purchaseDetails.status}');
        if (purchaseDetails.status == PurchaseStatus.pending) {
          showPendingUI();
          currentPurchaseDetails = purchaseDetails;
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          checkCompletePurchase(purchaseDetails);
          emit(EndPendingPurchaseState());
        } else {
          if (purchaseDetails.status == PurchaseStatus.error) {
            checkCompletePurchase(purchaseDetails);
            handleError(purchaseDetails.error!);
          } else if (purchaseDetails.status == PurchaseStatus.purchased) {
            if (isAndroid) {
            } else {
              if (purchaseDetails is AppStorePurchaseDetails) {
                final originalTransaction =
                    purchaseDetails.skPaymentTransaction.originalTransaction;
                if (currentProductId != purchaseDetails.productID &&
                    productIdToBuy == purchaseDetails.productID) {
                  // print(
                  //     purchaseDetails.verificationData.serverVerificationData);
                  await purchaseTarifIos(
                      originalTransaction?.transactionIdentifier ?? "",
                      purchaseDetails.productID);
                }
              }
            }
          }
          checkCompletePurchase(purchaseDetails);
        }
      }
    } catch (e) {}
  }

  Future checkCompletePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.pendingCompletePurchase) {
      await inAppPurchase.completePurchase(purchaseDetails);
    }
  }

  // void dispose() {
  //   if (subscription != null) subscription!.cancel();
  // }

  void handleError(IAPError error) {
    purchasePending = false;
    // dispose();
    emit(ErrorPurchaseState(error: error.details.toString()));
  }

  void showPendingUI() {
    purchasePending = true;
    emit(LoadingPendingPurchaseState());
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    purchases.add(purchaseDetails);
    purchasePending = false;
    emit(EndPendingPurchaseState());
  }

  Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
