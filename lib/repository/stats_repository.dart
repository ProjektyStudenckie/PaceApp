import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/repository/models/stats.dart';
import 'package:sortedmap/sortedmap.dart';
import 'authentication_repository.dart';

@lazySingleton
class StatsRepository {
  CollectionReference get usersReference =>
      FirebaseFirestore.instance.collection('stats');

  String get currentUser =>
      getIt.get<AuthenticationRepository>().currentUser.id;

  void addNewStat(
      {required int time, required int mistakes, required int textLength}) {
    if (time == 0 || textLength == 0) return;

    usersReference.add({
      'time': time,
      'mistakes': mistakes,
      'textLength': textLength,
      'owner': currentUser,
    }).catchError((error) {
      print('Failed to add new item: $error');
    });
  }

  Future<double> getUserAverageWPM() async {
    List<double> wpms = [];

    await usersReference
        .where("owner", isEqualTo: currentUser)
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
        .where("owner", isEqualTo: currentUser)
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
    final netWPM = grossWPM - (mistakes / (seconds / 60));

    if (netWPM < 0) return 0;

    return netWPM.roundToDouble();
  }

  double calculateAccuracy(int textLength, int mistakes) {
    return (textLength - mistakes) / textLength;
  }

  int calculateAccuracyPercent(int textLength, int mistakes) {
    return (((textLength - mistakes) / textLength) * 100).toInt();
  }

  Future<List<Stats>> getAllUserStats() async {
    List<Stats> userStats = [];

    await usersReference
        .where("owner", isEqualTo: currentUser)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        try {
          final textLength = int.parse(doc["textLength"].toString());
          final mistakes = int.parse(doc["mistakes"].toString());
          final time = int.parse(doc["time"].toString());

          final wpm = calculateNetWPM(textLength, mistakes, time);
          final accuracy = calculateAccuracyPercent(textLength, mistakes);

          userStats.add(Stats(wpm: wpm, accuracy: accuracy));
        } catch (e) {
          print(e);
        }
      });
    });

    if (userStats.length > 30)
      return userStats.sublist(userStats.length - 30);
    else
      return userStats;
  }

  Future<int> getAccuracyRanking() async {
    Set<String> users = {};
    var sortedScores = new FilteredMap(new Filter(reversed: true));

    await usersReference.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) => users.add(f["owner"]));
    });

    for (var user in users) {
      sortedScores[user] = await _getAverageAccuracy(user);
    }

    var place = 1;
    bool found = false;

    sortedScores.forEach((key, value) {
      if (key == currentUser) found = true;
      if (!found) place += 1;
    });

    return place;
  }

  Future<int> getWPMRanking() async {
    Set<String> users = {};
    var sortedScores = new FilteredMap(new Filter(reversed: true));

    await usersReference.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) => users.add(f["owner"]));
    });

    for (var user in users) {
      sortedScores[user] = await _getAverageWPM(user);
    }

    var place = 1;
    bool found = false;

    sortedScores.forEach((key, value) {
      if (key == currentUser) found = true;
      if (!found) place += 1;
    });

    return place;
  }

  Future<double> _getAverageAccuracy(String user) async {
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

  Future<double> _getAverageWPM(String user) async {
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

  Future<void> removeUserStats() async {
    await usersReference
        .where("owner", isEqualTo: currentUser)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        try {
          doc.reference.delete();
        } catch (e) {
          print(e);
        }
      });
    });
  }
}
