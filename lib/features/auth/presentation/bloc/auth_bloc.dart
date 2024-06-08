import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/utils/generate_keys.dart';
import 'package:vpn/features/auth/data/models/auth_model.dart';
import 'package:vpn/features/auth/domain/usecases/auth_usecases.dart';
import 'package:vpn/translations/locate_keys.g.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthUseCase authUseCase;
  CacheHelper cacheHelper;
  static AuthBloc get(context) => BlocProvider.of(context);

  SystemInfoService systemInfoService = SystemInfoService();

  AuthBloc({required this.authUseCase, required this.cacheHelper})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      switch (event.runtimeType) {
        case LoginWithAppleAuthEvent:
          await _onLoginWithApple(event as LoginWithAppleAuthEvent, emit);
          break;
        case LoginWithGoogleAuthEvent:
          await _onLoginWithGoogle(event as LoginWithGoogleAuthEvent, emit);
          break;
      }
    });
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogleAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingGoogleState());
      GoogleSignInAccount? google = await signInWithGoogle();

      if (google?.id != null) {
        AuthModel authModel = AuthModel(
          login: google?.id ?? "",
          email: google?.email ?? "",
          isGoogleLogin: true,
        );
        final res = await authUseCase.call(authModel);
        emit(
          res.fold(
            (failure) => AuthErrorState(error: failure),
            (data) {
              systemInfoService.isLogin = true;
              return AuthSuccessState();
            },
          ),
        );
      } else {
        emit(StopAuthState());
      }
    } catch (e) {
      emit(AuthErrorState(error: LocaleKeys.anUnexpectedErrorOccurred.tr()));
    }
  }

  Future<void> _onLoginWithApple(
    LoginWithAppleAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingAppleState());
      final apple = await signInWithApple();
      if (apple.userIdentifier != null) {
        AuthModel authModel = AuthModel(
          login: apple.userIdentifier ?? '',
          email: apple.email ?? "",
          isGoogleLogin: false,
        );
        final res = await authUseCase.call(authModel);
        emit(
          res.fold(
            (failure) => AuthErrorState(error: failure),
            (data) {
              systemInfoService.isLogin = true;
              return AuthSuccessState();
            },
          ),
        );
      } else {
        emit(StopAuthState());
      }
    } catch (e) {
      emit(AuthErrorState(error: LocaleKeys.anUnexpectedErrorOccurred.tr()));
    }
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    return googleUser;
  }

  Future<AuthorizationCredentialAppleID> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = RsaKeyHelper.sha256ofString(rawNonce);
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    return credential;
  }
}
