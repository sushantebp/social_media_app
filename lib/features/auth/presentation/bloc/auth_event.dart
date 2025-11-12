part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class NameChanged extends AuthEvent {
  final String name;
  const NameChanged(this.name);
}

final class EmailChanged extends AuthEvent {
  final String email;
  const EmailChanged(this.email);
}

final class PasswordChanged extends AuthEvent {
  final String password;
  const PasswordChanged(this.password);
}

final class RegisterSubmitted extends AuthEvent {
  const RegisterSubmitted();
}

final class VerifyUserEmail extends AuthEvent {
  const VerifyUserEmail();
}

final class LoginSubmitted extends AuthEvent {
  const LoginSubmitted();
}
