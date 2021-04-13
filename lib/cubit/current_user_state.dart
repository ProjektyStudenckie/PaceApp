part of 'current_user_cubit.dart';

@immutable
abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState {}

class CurrentUserLoggedIn extends CurrentUserState {
  final String userUID;
  CurrentUserLoggedIn({this.userUID});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CurrentUserLoggedIn && o.userUID == userUID;
  }

  @override
  int get hashCode => userUID.hashCode;
}

class CurrentUserError extends CurrentUserState {
  final String message;

  CurrentUserError({this.message});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CurrentUserError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
