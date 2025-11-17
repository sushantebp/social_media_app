import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/dashboard.dart';

part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// [AuthBloc] manages all authentication flows:
/// - Registration
/// - Email verification
/// - Login
/// - Logout
///
class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<CodeChanged>(_onCodeChanged);
    on<VerifyUserEmail>(_onVerifyUserEmail);
    on<LoginSubmitted>(_onUserLogin);
    on<LogoutSubmitted>(_onLogout);
  }

  // Form field changes
  void _onNameChanged(NameChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(name: event.name));

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(email: event.email));

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(password: event.password));

  void _onCodeChanged(CodeChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(verificationCode: event.verificationCode));

  // Register
  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    final request = UserAuthRequestModel(
      name: state.name,
      email: state.email,
      password: state.password,
    );

    final result = await _authRepository.registerUser(request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          successMessage: response.message,
          errorMessage: "",
        ),
      ),
    );
  }

  // user email verify
  Future<void> _onVerifyUserEmail(
    VerifyUserEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    final request = VerifyEmailRequestModel(
      email: state.email,
      verificationCode: state.verificationCode,
    );

    final result = await _authRepository.verifyEmail(request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          successMessage: response,
        ),
      ),
    );
  }

  // login
  Future<void> _onUserLogin(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    final request = UserAuthRequestModel(
      email: state.email,
      password: state.password,
    );

    final result = await _authRepository.loginUser(request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          authStatus: AuthStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (response) => emit(
        state.copyWith(
          authStatus: AuthStatus.authenticated,
          successMessage: response.message,
        ),
      ),
    );
  }

  // logout
  Future<void> _onLogout(LogoutSubmitted event, Emitter<AuthState> emit) async {
    await _authRepository.logoutUser();
  }
}
