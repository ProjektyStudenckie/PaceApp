part of 'registration_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class RegistrationState extends Equatable {
  const RegistrationState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, confirmedPassword, status];

  RegistrationState copyWith({
    Email email,
    Password password,
    ConfirmedPassword confirmedPassword,
    FormzStatus status,
  }) {
    return RegistrationState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
    );
  }
}