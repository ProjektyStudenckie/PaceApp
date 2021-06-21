part of 'stats_cubit.dart';

class StatsState extends Equatable {
  final double averageWPM;
  final double averageAccuracy;
  final List<Stats> allStats;
  final bool loaded;

  const StatsState(
      {required this.averageWPM,
      required this.averageAccuracy,
      this.allStats = const [],
      this.loaded = false});

  @override
  List<Object> get props => [averageWPM, averageAccuracy, allStats, loaded];

  StatsState copyWith(
      {String? email,
      double? averageWPM,
      double? averageAccuracy,
      List<Stats>? allStats,
      bool? loaded}) {
    return StatsState(
        averageWPM: averageWPM ?? this.averageWPM,
        averageAccuracy: averageAccuracy ?? this.averageAccuracy,
        allStats: allStats ?? this.allStats,
        loaded: loaded ?? this.loaded);
  }
}
