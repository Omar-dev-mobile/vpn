import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:google_sign_in/google_sign_in.dart';
=======
>>>>>>> new_version
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:vpn/core/shared/components/system_info_service.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/utils/generate_keys.dart';
import 'package:vpn/features/auth/data/models/auth_model.dart';
import 'package:vpn/features/auth/domain/usecases/auth_usecases.dart';
import 'package:vpn/translations/locate_keys.g.dart';
<<<<<<< HEAD
=======

>>>>>>> new_version
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
<<<<<<< HEAD
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

=======
  final AuthUseCase authUseCase;
  final CacheHelper cacheHelper;
  final SystemInfoService systemInfoService = SystemInfoService();

  AuthBloc({required this.authUseCase, required this.cacheHelper})
      : super(AuthInitial()) {
    on<LoginWithAppleAuthEvent>(_onLoginWithApple);
    on<LoginWithGoogleAuthEvent>(_onLoginWithGoogle);
  }

  static AuthBloc get(context) => BlocProvider.of(context);

>>>>>>> new_version
  Future<void> _onLoginWithGoogle(
    LoginWithGoogleAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
<<<<<<< HEAD
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
=======
    emit(AuthLoadingGoogleState());

    try {
      // Uncomment and implement signInWithGoogle when available
      // GoogleSignInAccount? google = await signInWithGoogle();

      // if (google?.id != null) {
      //   await _authenticateUser(
      //     emit,
      //     AuthModel(
      //       login: google?.id ?? "",
      //       email: google?.email ?? "",
      //       isGoogleLogin: true,
      //     ),
      //   );
      // } else {
      //   emit(StopAuthState());
      // }
>>>>>>> new_version
    } catch (e) {
      emit(AuthErrorState(error: LocaleKeys.anUnexpectedErrorOccurred.tr()));
    }
  }

  Future<void> _onLoginWithApple(
    LoginWithAppleAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
<<<<<<< HEAD
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
=======
    emit(AuthLoadingAppleState());

    try {
      final apple = await signInWithApple();

      if (apple.userIdentifier != null) {
        await _authenticateUser(
          emit,
          AuthModel(
            login: apple.userIdentifier ?? "",
            email: apple.email ?? "",
            isGoogleLogin: false,
>>>>>>> new_version
          ),
        );
      } else {
        emit(StopAuthState());
      }
    } catch (e) {
      emit(AuthErrorState(error: LocaleKeys.anUnexpectedErrorOccurred.tr()));
    }
  }

<<<<<<< HEAD
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    return googleUser;
=======
  Future<void> _authenticateUser(
    Emitter<AuthState> emit,
    AuthModel authModel,
  ) async {
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
>>>>>>> new_version
  }

  Future<AuthorizationCredentialAppleID> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = RsaKeyHelper.sha256ofString(rawNonce);
<<<<<<< HEAD
    final credential = await SignInWithApple.getAppleIDCredential(
=======
    return await SignInWithApple.getAppleIDCredential(
>>>>>>> new_version
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
<<<<<<< HEAD
    return credential;
  }
=======
  }

  // Uncomment and implement Google sign-in when needed
  // Future<GoogleSignInAccount?> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   return googleUser;
  // }
>>>>>>> new_version
}
