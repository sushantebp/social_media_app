import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';
part 'auth_bloc.g.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
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

  void _onNameChanged(NameChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(name: event.name));

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(email: event.email));

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(password: event.password));

  void _onCodeChanged(CodeChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(verificationCode: event.verificationCode));

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final registerRequest = UserAuthRequestModel(
        name: state.name,
        email: state.email,
        password: state.password,
      );

      final result = await _authRepository.registerUser(registerRequest);

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
            errorMessage: "",
            successMessage: response.message,
          ),
        ),
      );
    } catch (e) {
      throw UnknownException();
    }
  }

  Future<void> _onVerifyUserEmail(
    VerifyUserEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));

      final request = VerifyEmailRequestModel(
        email: state.email,
        // verificationCode: state.verificationCode,
        // static default value is used here,since it is still being maintained
        verificationCode: "123456",
      );

      final result = await _authRepository.verifyEmail(request);
      result.fold(
        (failure) => emit(
          state.copyWith(
            authStatus: AuthStatus.error,
            errorMessage: failure.message,
          ),
        ),
        (message) => emit(
          state.copyWith(
            authStatus: AuthStatus.authenticated,
            errorMessage: "",
            successMessage: message,
          ),
        ),
      );
    } catch (e) {
      throw UnknownException();
    }
  }

  Future<void> _onUserLogin(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));

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
            errorMessage: null,
            successMessage: response.message,
          ),
        ),
      );
    } catch (e) {
      throw UnknownException();
    }
  }

  Future<void> _onLogout(
    LogoutSubmitted event,
    Emitter<AuthState> emit,
  ) async => await _authRepository.logoutUser();
}
