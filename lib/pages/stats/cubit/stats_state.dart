part of 'stats_cubit.dart';

class StatsState extends Equatable {
  final double averageWPM;
  final double averageAccuracy;
  final int accuracyRanking;
  final int wpmRanking;
  final List<Stats> allStats;
  final bool loaded;

  const StatsState(
      {required this.averageWPM,
      required this.averageAccuracy,
      this.wpmRanking = 0,
      this.accuracyRanking = 0,
      this.allStats = const [],
      this.loaded = false});

  @override
  List<Object> get props => [
        averageWPM,
        averageAccuracy,
        wpmRanking,
        accuracyRanking,
        allStats,
        loaded
      ];

  StatsState copyWith(
      {double? averageWPM,
      double? averageAccuracy,
      int? wpmRanking,
      int? accuracyRanking,
      List<Stats>? allStats,
      bool? loaded}) {
    return StatsState(
        averageWPM: averageWPM ?? this.averageWPM,
        averageAccuracy: averageAccuracy ?? this.averageAccuracy,
        wpmRanking: wpmRanking ?? this.wpmRanking,
        accuracyRanking: accuracyRanking ?? this.accuracyRanking,
        allStats: allStats ?? this.allStats,
        loaded: loaded ?? this.loaded);
  }
}
