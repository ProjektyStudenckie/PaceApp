// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:pace_app/forms/models/models.dart';
// import 'package:pace_app/repository/stats_repository.dart';
//
// part 'home_cubit.freezed.dart';
//
// class HomeCubit extends Cubit<HomeState> {
//   final StatsRepository _statsRepository;
//   HomeCubit(this._statsRepository) : super(HomeState.init());
// }
//
// @freezed
// class HomeState with _$HomeState {
//   const factory HomeState({
//     required Page page,
//   }) = _HomeState;
//
//   const HomeState._();
//
//   factory HomeState.init() => HomeState(page: Page.main);
// }
//
// enum Page { main, stats, settings }
