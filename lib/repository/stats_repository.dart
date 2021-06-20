import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:pace_app/injection/injection.dart';

import 'authentication_repository.dart';

@lazySingleton
class StatsRepository {
  CollectionReference get usersReference =>
      FirebaseFirestore.instance.collection('stats');

  String get user => getIt.get<AuthenticationRepository>().currentUser.id;

  void addNewStat(int time, int mistakes, int textLength) {
    usersReference.add({
      'time': time,
      'mistakes': mistakes,
      'textLength': textLength,
      'owner': user,
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print('Failed to add new item: $error'));
  }
}
