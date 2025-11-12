part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, unauthenticated, authenticated, error }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default('') String verificationCode,
    @Default(AuthStatus.initial) AuthStatus authStatus,
    String? errorMessage,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
