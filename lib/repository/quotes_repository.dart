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
    "Let the future tell the truth, and evaluate each one according to his work and accomplishments. The present is theirs; the future, for which I have really worked, is mine.",
    "Moral excellence comes about as a result of habit. We become just by doing just acts, temperate by doing temperate acts, brave by doing brave acts.",
    "It is with words as with sunbeams. The more they are condensed, the deeper they burn.",
    "Sincerity is the way of Heaven. The attainment of sincerity is the way of men.",
    "To be fully alive, fully human, and completely awake is to be continually thrown out of the nest.",
    "Giving up doesn't always mean you are weak; sometimes it means that you are strong enough to let go.",
    "An idea that is developed and put into action is more important than an idea that exists only as an idea.",
    "And as we let our own light shine, we unconsciously give other people permission to do the same.",
    "Many people have gone further than they thought they could because someone else thought they could.",
    "I am glad that I paid so little attention to good advice; had I abided by it I might have been saved from some of my most valuable mistakes.",
    "The person who makes a success of living is the one who see his goal steadily and aims for it unswervingly. That is dedication.",
    "However many holy words you read, however many you speak, what good will they do you if you do not act on upon them?",
    "If you are going to achieve excellence in big things, you develop the habit in little matters. Excellence is not an exception, it is a prevailing attitude.",
    "If you're in a bad situation, don't worry it'll change. If you're in a good situation, don't worry it'll change.",
    "Instead of saying that man is the creature of circumstance, it would be nearer the mark to say that man is the architect of circumstance.",
    "Love vanquishes time. To lovers, a moment can be eternity, eternity can be the tick of a clock.",
    "A leader is best when people barely know he exists, when his work is done, his aim fulfilled, they will say: we did it ourselves."
  ];
}
