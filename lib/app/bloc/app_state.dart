part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._(
      {required this.status, this.user = User.anonymous, this.email = ""});

  AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user, email: user.email);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;
  final String email;

  @override
  List<Object> get props => [status, user, email];
}
