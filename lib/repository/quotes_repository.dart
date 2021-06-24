import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:pace_app/repository/models/quote.dart';

class QuotesRepository {
  static const apiUri = "https://type.fit/api/quotes";

  static Future<List<dynamic>> fetchQuotes() async {
    var result = await http.get(Uri.parse(apiUri));

    return json.decode(result.body);
  }

  static Future<Quote> fetchRandomQuote() async {
    try {
      var result = await http.get(Uri.parse(apiUri));
      var length = json.decode(result.body).length;

      return Quote.fromJson(
          json.decode(result.body)[Random().nextInt(length - 1)]);
    } catch (e) {
      print(e);
      var randomBackupQuote =
          backupQuotes[Random().nextInt(backupQuotes.length)];

      return Quote(content: randomBackupQuote, author: "");
    }
  }

  static List<String> backupQuotes = [
    "Sincerity is the way of Heaven.",
    "Giving up doesn't always mean you are weak",
    "The attainment of sincerity is the way of men.",
    "It is with words as with sunbeams.",
    "If you're in a bad situation, don't worry it'll change.",
  ];
}
