import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:vpn/core/shared/datasources/local/cache_helper.dart';
import 'package:vpn/core/shared/usecases/generate_keys.dart';
import 'package:vpn/features/auth/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthUseCase authUseCase;
  CacheHelper cacheHelper;
  static AuthBloc get(context) => BlocProvider.of(context);

  AuthBloc({required this.authUseCase, required this.cacheHelper})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      switch (event.runtimeType) {
        case LoginWithGoogleAndAppleAuthEvent:
          await _onLoginWithGoogleAndApple(
              event as LoginWithGoogleAndAppleAuthEvent, emit);
          break;
      }
    });
  }

  Future<void> _onLoginWithGoogleAndApple(
    LoginWithGoogleAndAppleAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());
      String id = '';
      if (event.type == 'google') {
        id = await signInWithGoogle();
      } else {
        final apple = await signInWithApple();
        id = apple.userIdentifier ?? '';
      }
      final res = await authUseCase.call(id);
      emit(
        res.fold(
          (failure) => AuthErrorState(error: failure),
          (data) {
            return AuthSuccessState();
          },
        ),
      );
    } catch (e) {
      emit(const AuthErrorState(error: 'An unexpected error occurred'));
    }
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    return googleUser?.email ?? '';
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
