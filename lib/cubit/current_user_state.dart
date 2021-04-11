part of 'current_user_cubit.dart';

@immutable
abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState {}

class CurrentUserLoggedIn extends CurrentUserState {
  final String userName;
  CurrentUserLoggedIn({this.userName});
}
