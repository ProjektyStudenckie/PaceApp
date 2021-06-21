import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pace_app/repository/models/stats.dart';
import 'package:pace_app/repository/stats_repository.dart';

part 'stats_state.dart';

class StatsCubit extends Cubit<StatsState> {
  StatsRepository statsRepository;

  StatsCubit({required this.statsRepository})
      : super(StatsState(averageAccuracy: 0, averageWPM: 0)) {
    loadStats();
  }

  void changeAverageWPM(double newValue) {
    emit(state.copyWith(averageWPM: newValue));
  }

  void changeAverageAccuracy(double newValue) {
    emit(state.copyWith(averageAccuracy: newValue));
  }

  void changeLoading(bool loaded) {
    emit(state.copyWith(loaded: loaded));
  }

  void loadStats() async {
    final avgWPM = await statsRepository.getUserAverageWPM();
    final avgAccuracy = await statsRepository.getUserAverageAccuracy();

    final allStats = await statsRepository.getAllUserStats();

    emit(state.copyWith(
        averageWPM: avgWPM,
        averageAccuracy: avgAccuracy,
        allStats: allStats,
        loaded: true));
  }
}
