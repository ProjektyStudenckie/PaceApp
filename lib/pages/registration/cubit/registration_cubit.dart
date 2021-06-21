import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/forms/forms.dart';
import 'package:pace_app/repository/authentication_repository.dart';

part 'registration_cubit.freezed.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final AuthenticationRepository _authenticationRepository;
  RegistrationCubit(this._authenticationRepository)
      : super(RegistrationState.init());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        state.confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );

    print(state.status);

    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  Future<void> registrationFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpFailure {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    required Email email,
    required Password password,
    required ConfirmedPassword confirmedPassword,
    required FormzStatus status,
  }) = _RegistrationState;

  const RegistrationState._();

  factory RegistrationState.init() => RegistrationState(
      email: Email.pure(),
      password: Password.pure(),
      confirmedPassword: ConfirmedPassword.pure(),
      status: FormzStatus.pure);
}
