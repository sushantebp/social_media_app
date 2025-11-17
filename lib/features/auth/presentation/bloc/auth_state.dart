part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, unauthenticated, authenticated, error }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    // Basic Auth
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default('') String verificationCode,

    // Status
    @Default(AuthStatus.initial) AuthStatus authStatus,

    // Profile
    DateTime? dateOfBirth,
    @Default([]) List<String> hobbies,

    // Academic List
    @Default([]) List<UserAcademiceQModel> academiceQ,

    // Feedback
    String? errorMessage,
    String? successMessage,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
