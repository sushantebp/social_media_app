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
    on<VerifyUserEmail>(_onVerifyUserEmail);
    on<LoginSubmitted>(_onUserLogin);
  }

  void _onNameChanged(NameChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(name: event.name));

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(email: event.email));

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(password: event.password));

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final registerRequest = UserRegisterRequestModel(
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
        (_) => emit(
          state.copyWith(
            authStatus: AuthStatus.unauthenticated,
            errorMessage: "",
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
        (_) => emit(
          state.copyWith(
            authStatus: AuthStatus.authenticated,
            errorMessage: "",
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

      final request = UserLoginRequestModel(
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
}
