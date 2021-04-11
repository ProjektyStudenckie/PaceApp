import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_user_state.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit() : super(CurrentUserInitial());

  void setCurrentUser(String userName) {
    try {
      emit(CurrentUserLoggedIn(userName: userName));
    } catch (e) {
      print(e);
    }
  }

  Future<void> enableLoading() async {
    try {
      emit(CurrentUserLoading());
    } catch (e) {
      print(e);
    }
  }
}
