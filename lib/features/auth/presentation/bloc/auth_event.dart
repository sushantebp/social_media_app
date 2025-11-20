part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class NameChanged extends AuthEvent {
  final String name;
  const NameChanged(this.name);
}

class EmailChanged extends AuthEvent {
  final String email;
  const EmailChanged(this.email);
}

class PasswordChanged extends AuthEvent {
  final String password;
  const PasswordChanged(this.password);
}

class RegisterSubmitted extends AuthEvent {
  const RegisterSubmitted();
}

class CodeChanged extends AuthEvent {
  final String verificationCode;
  const CodeChanged(this.verificationCode);
}

class VerifyUserEmail extends AuthEvent {
  const VerifyUserEmail();
}

class LoginSubmitted extends AuthEvent {
  const LoginSubmitted();
}

class LogoutSubmitted extends AuthEvent {
  const LogoutSubmitted();
}

class UserBirthdayChanged extends AuthEvent {
  final DateTime? dateTime;
  const UserBirthdayChanged(this.dateTime);
}

class UserHobbiesChanged extends AuthEvent {
  final List<String> hobbies;
  const UserHobbiesChanged(this.hobbies);
}

class LocationChanged extends AuthEvent {
  const LocationChanged();
}

class UserCourseChanged extends AuthEvent {
  final String course;
  const UserCourseChanged(this.course);
}

class UserGraduationYearChanged extends AuthEvent {
  final String graduationYear;
  const UserGraduationYearChanged(this.graduationYear);
}

class UserRegisterFormSubmitted extends AuthEvent {
  const UserRegisterFormSubmitted();
}
