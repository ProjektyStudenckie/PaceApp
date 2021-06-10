import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pace_app/app/app.dart';
import 'package:pace_app/repository/authentication_repository.dart';
import 'package:pace_app/repository/models/user.dart';


class MockLoggedInAuthenticationRepository extends Mock
    implements AuthenticationRepository {
  @override
  User get currentUser {
    return User(id: "1", email: "test@ok.pl", name: 'test', photo: '');
  }

  @override
  Stream<User> get user {
    return Stream.fromIterable(
        [User(id: "1", email: "test@ok.pl", name: 'test', photo: '')]);
  }
}

class MockLoggedOutAuthenticationRepository extends Mock
    implements AuthenticationRepository {
  @override
  User get currentUser {
    return User.anonymous;
  }

  @override
  Stream<User> get user {
    return Stream.fromIterable([User.anonymous]);
  }
}

void main() {
  var mockLoggedInAuthenticationRepository =
      MockLoggedInAuthenticationRepository();

  var mockLoggedOutAuthenticationRepository =
      MockLoggedOutAuthenticationRepository();

  group('test user authentication', () {
    test('user authenticated', () async {
      final bloc = AppBloc(
          authenticationRepository: mockLoggedInAuthenticationRepository);

      expect(bloc.state.status, AppStatus.authenticated);
    });

    test('user not authenticated', () async {
      final bloc = AppBloc(
          authenticationRepository: mockLoggedOutAuthenticationRepository);

      expect(bloc.state.status, AppStatus.unauthenticated);
    });
  });
}
