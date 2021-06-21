import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pace_app/injection/injection.dart';
import 'package:pace_app/repository/stats_repository.dart';

part 'stats_state.dart';
part 'stats_cubit.freezed.dart';

class StatsCubit extends Cubit<StatsState> {
  StatsCubit() : super(StatsState.initial()) {
    getWPM();
  }

  void getWPM() async {
    print("ok");
    var wpm = await getIt.get<StatsRepository>().getUserAverageWPM();
    getIt.get<StatsRepository>().getUserAverageAccuracy();
  }
}
