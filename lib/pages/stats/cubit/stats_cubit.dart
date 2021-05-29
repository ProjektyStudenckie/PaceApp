import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_state.dart';
part 'stats_cubit.freezed.dart';

class StatsCubit extends Cubit<StatsState> {
  StatsCubit() : super(StatsState.initial());
}
