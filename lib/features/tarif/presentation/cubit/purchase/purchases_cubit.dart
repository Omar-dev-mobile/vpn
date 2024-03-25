import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:vpn/core/constants.dart';
import 'package:vpn/core/shared/usecases/IAPConnectionPurchase.dart';
import 'package:vpn/core/shared/usecases/consumable_store.dart';
part 'purchases_state.dart';

class PurchasesCubit extends Cubit<PurchasesStatus> {
  PurchasesCubit() : super(PurchasesInitial()) {
    print("objectobjectobjectobjectobjectobject");
    Stream<List<PurchaseDetails>>? purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
      return;
    }, onDone: () {
      subscription.cancel();
    }, onError: (Object error) {});
    initStoreInfo();
  }
  static PurchasesCubit get(context) => BlocProvider.of(context);
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> subscription;
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

  @override
  Future<void> close() {
    if (!isAndroid) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    subscription.cancel();
    return super.close();
  }

  final isAndroid = Platform.isAndroid;

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
    emit(EndInitStoreInfoState());
  }

  final emptyProductDetails = ProductDetails(
      currencyCode: '',
      description: '',
      id: '',
      price: '',
      rawPrice: 0,
      title: '');

  Future buyTarif() async {
    late PurchaseParam purchaseParam;
    ProductDetails productDetail = first(tarifs) ?? emptyProductDetails;
    if (tarifs.isEmpty) return;
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

    inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

//buy tarif with receipt or server(api) verification
  Future purchaseTarif(String receipt) async {}

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      var purchaseID = purchaseDetails.purchaseID;
      print(purchaseDetails.status);
      if (purchaseDetails is AppStorePurchaseDetails) {
        final originalTransaction =
            purchaseDetails.skPaymentTransaction.originalTransaction;
        if (originalTransaction != null) {
          purchaseID = originalTransaction.transactionIdentifier;
          print("purchaseDetails$purchaseID");
          print("purchaseDetails${originalTransaction.toFinishMap()}");
        }
      }
      // print("purchaseDetails${purchaseDetails.status}");
      // final originalTransaction =
      //     purchaseDetails.skPaymentTransaction.originalTransaction;

      // print("purchaseDetails${purchaseDetails.transactionDate}");
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else if (purchaseDetails.status == PurchaseStatus.canceled) {
        checkCompletePurchase(purchaseDetails);
        emit(EndPendingPurchaseState());
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          checkCompletePurchase(purchaseDetails);
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          if (isAndroid) {
            purchaseTarif(purchaseDetails.purchaseID ?? "");
          } else {
            print(
                "Succ${purchaseDetails.verificationData.localVerificationData}");
            print(
                "Succ${purchaseDetails.verificationData.serverVerificationData}");
            print("Succ${purchaseDetails.verificationData.source}");
            purchaseTarif(
                purchaseDetails.verificationData.serverVerificationData);
          }
          final bool valid = await verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          }
          checkCompletePurchase(purchaseDetails);
          subscription.cancel();
        }
      }
      checkCompletePurchase(purchaseDetails);
    }
  }

  Future checkCompletePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.pendingCompletePurchase) {
      await inAppPurchase.completePurchase(purchaseDetails);
    }
  }

  void handleError(IAPError error) {
    purchasePending = false;
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
