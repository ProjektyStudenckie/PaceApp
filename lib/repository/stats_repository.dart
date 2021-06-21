import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/repository/models/stats.dart';

import 'authentication_repository.dart';

@lazySingleton
class StatsRepository {
  CollectionReference get usersReference =>
      FirebaseFirestore.instance.collection('stats');

  String get user => getIt.get<AuthenticationRepository>().currentUser.id;

  void addNewStat(int time, int mistakes) {
    usersReference.add({
      'time': time,
      'mistakes': mistakes,
      'owner': user,
    }).catchError((error) {
      print('Failed to add new item: $error');
    });
  }

  Future<double> getUserAverageWPM() async {
    List<double> wpms = [];

    await usersReference
        .where("owner", isEqualTo: user)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        try {
          final textLength = int.parse(doc["textLength"].toString());
          final mistakes = int.parse(doc["mistakes"].toString());
          final time = int.parse(doc["time"].toString());

          final netWPM = calculateNetWPM(textLength, mistakes, time);

          wpms.add(netWPM);
        } catch (e) {
          print(e);
        }
      });
    });

    double sum = 0;

    if (wpms.length > 1)
      sum = wpms.reduce((a, b) => a + b);
    else if (wpms.length == 1)
      sum = wpms[0];
    else
      return 0;

    return sum / wpms.length;
  }

  Future<double> getUserAverageAccuracy() async {
    List<double> accuracyList = [];

    await usersReference
        .where("owner", isEqualTo: user)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        try {
          final textLength = int.parse(doc["textLength"].toString());
          final mistakes = int.parse(doc["mistakes"].toString());

          final accuracy = calculateAccuracy(textLength, mistakes);

          accuracyList.add(accuracy);
        } catch (e) {
          print(e);
        }
      });
    });

    double sum = 0;

    if (accuracyList.length > 1)
      sum = accuracyList.reduce((a, b) => a + b);
    else if (accuracyList.length == 1)
      sum = accuracyList[0];
    else
      return 0;

    return sum / accuracyList.length;
  }

  double calculateNetWPM(int textLength, int mistakes, int seconds) {
    final grossWPM = (textLength / 5.0) / (seconds / 60.0);

    return grossWPM - (mistakes / (seconds / 60));
  }

  double calculateAccuracy(int textLength, int mistakes) {
    return (textLength - mistakes) / textLength;
  }

  Future<List<Stats>> getAllUserStats() async {
    List<Stats> userStats = [];

    await usersReference
        .where("owner", isEqualTo: user)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        try {
          final textLength = int.parse(doc["textLength"].toString());
          final mistakes = int.parse(doc["mistakes"].toString());
          final time = int.parse(doc["time"].toString());

          final wpm = calculateNetWPM(textLength, mistakes, time);
          final accuracy = calculateAccuracy(textLength, mistakes);

          userStats.add(Stats(wpm: wpm, accuracy: accuracy));
        } catch (e) {
          print(e);
        }
      });
    });

    // TODO: Testing remove later
    userStats.add(Stats(accuracy: 0.99, wpm: 40));
    userStats.add(Stats(accuracy: 0.94, wpm: 140));
    userStats.add(Stats(accuracy: 0.95, wpm: 69));
    userStats.add(Stats(accuracy: 0.91, wpm: 83));
    userStats.add(Stats(accuracy: 0.91, wpm: 70));
    userStats.add(Stats(accuracy: 0.95, wpm: 69));
    userStats.add(Stats(accuracy: 0.91, wpm: 83));
    userStats.add(Stats(accuracy: 0.91, wpm: 70));

    if(userStats.length > 30)
      return userStats.sublist(userStats.length-30);
      else
      return userStats;
  }
}
