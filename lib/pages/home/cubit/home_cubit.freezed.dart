// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HomeStateTearOff {
  const _$HomeStateTearOff();

  _HomeState call(
      {required bool playGame,
      required String gameText,
      required int currentIndex}) {
    return _HomeState(
      playGame: playGame,
      gameText: gameText,
      currentIndex: currentIndex,
    );
  }
}

/// @nodoc
const $HomeState = _$HomeStateTearOff();

/// @nodoc
mixin _$HomeState {
  bool get playGame => throw _privateConstructorUsedError;
  String get gameText => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res>;
  $Res call({bool playGame, String gameText, int currentIndex});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res> implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  final HomeState _value;
  // ignore: unused_field
  final $Res Function(HomeState) _then;

  @override
  $Res call({
    Object? playGame = freezed,
    Object? gameText = freezed,
    Object? currentIndex = freezed,
  }) {
    return _then(_value.copyWith(
      playGame: playGame == freezed
          ? _value.playGame
          : playGame // ignore: cast_nullable_to_non_nullable
              as bool,
      gameText: gameText == freezed
          ? _value.gameText
          : gameText // ignore: cast_nullable_to_non_nullable
              as String,
      currentIndex: currentIndex == freezed
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(
          _HomeState value, $Res Function(_HomeState) then) =
      __$HomeStateCopyWithImpl<$Res>;
  @override
  $Res call({bool playGame, String gameText, int currentIndex});
}

/// @nodoc
class __$HomeStateCopyWithImpl<$Res> extends _$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(_HomeState _value, $Res Function(_HomeState) _then)
      : super(_value, (v) => _then(v as _HomeState));

  @override
  _HomeState get _value => super._value as _HomeState;

  @override
  $Res call({
    Object? playGame = freezed,
    Object? gameText = freezed,
    Object? currentIndex = freezed,
  }) {
    return _then(_HomeState(
      playGame: playGame == freezed
          ? _value.playGame
          : playGame // ignore: cast_nullable_to_non_nullable
              as bool,
      gameText: gameText == freezed
          ? _value.gameText
          : gameText // ignore: cast_nullable_to_non_nullable
              as String,
      currentIndex: currentIndex == freezed
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
class _$_HomeState extends _HomeState {
  const _$_HomeState(
      {required this.playGame,
      required this.gameText,
      required this.currentIndex})
      : super._();

  @override
  final bool playGame;
  @override
  final String gameText;
  @override
  final int currentIndex;

  @override
  String toString() {
    return 'HomeState(playGame: $playGame, gameText: $gameText, currentIndex: $currentIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HomeState &&
            (identical(other.playGame, playGame) ||
                const DeepCollectionEquality()
                    .equals(other.playGame, playGame)) &&
            (identical(other.gameText, gameText) ||
                const DeepCollectionEquality()
                    .equals(other.gameText, gameText)) &&
            (identical(other.currentIndex, currentIndex) ||
                const DeepCollectionEquality()
                    .equals(other.currentIndex, currentIndex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(playGame) ^
      const DeepCollectionEquality().hash(gameText) ^
      const DeepCollectionEquality().hash(currentIndex);

  @JsonKey(ignore: true)
  @override
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);
}

abstract class _HomeState extends HomeState {
  const factory _HomeState(
      {required bool playGame,
      required String gameText,
      required int currentIndex}) = _$_HomeState;
  const _HomeState._() : super._();

  @override
  bool get playGame => throw _privateConstructorUsedError;
  @override
  String get gameText => throw _privateConstructorUsedError;
  @override
  int get currentIndex => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HomeStateCopyWith<_HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}
