import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/forms/models/models.dart';
import 'package:pace_app/repository/authentication_repository.dart';

part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authenticationRepository;
  LoginCubit(this._authenticationRepository) : super(LoginState.init());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    print(Formz.validate([state.email, password]));
    print(password);
    print("State " + state.password.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception catch (e) {}
    // } on Exception {
    //   //print(e.)
    //   emit(state.copyWith(status: FormzStatus.submissionFailure));
    // }
  }
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required Email email,
    required Password password,
    required FormzStatus status,
  }) = _LoginState;

  const LoginState._();

  factory LoginState.init() => LoginState(
      email: Email.pure(), password: Password.pure(), status: FormzStatus.pure);
}
