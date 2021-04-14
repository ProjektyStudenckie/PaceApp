import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pace_app/utils/firebase_exceptions_utils.dart';
import 'package:pace_app/utils/login_validation_utils.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit() : super(CurrentUserInitial());

  Future<void> loginUser(String email, String password) async {
    if (email == null || password == null) {
      emit(CurrentUserError(message: "Fill all the fields!"));
      return;
    }

    if (!isEmailValid(email)) {
      emit(CurrentUserError(message: "Email is invalid!"));
      return;
    }

    try {
      emit(CurrentUserLoading());
      final _auth = FirebaseAuth.instance;
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(CurrentUserLoggedIn(userUID: userCredential.user.uid));
    } on FirebaseAuthException catch (e) {
      emit(CurrentUserError(message: getMessageWithExceptionCode(e.code)));
    }
  }

  Future<void> registerUser(
      String email, String password, String passwordConfirm) async {
    if (email == null || password == null) {
      emit(CurrentUserError(message: "Fill all the fields!"));
      return;
    }

    if (!isEmailValid(email)) {
      emit(CurrentUserError(message: "Email is invalid!"));
      return;
    }

    if (passwordConfirm != password) {
      emit(CurrentUserError(message: "Passwords are not equal!"));
      return;
    }

    if (!isPasswordValid(password)) {
      emit(CurrentUserError(message: "Password is invalid!"));
      return;
    }

    try {
      emit(CurrentUserLoading());
      final _auth = FirebaseAuth.instance;
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(CurrentUserLoggedIn(userUID: userCredential.user.uid));
    } on FirebaseAuthException catch (e) {
      emit(CurrentUserError(message: getMessageWithExceptionCode(e.code)));
    }
  }
}
