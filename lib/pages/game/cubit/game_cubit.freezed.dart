// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'game_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GameStateTearOff {
  const _$GameStateTearOff();

  _GameState call(
      {required bool playGame,
      required String gameText,
      required int currentIndex,
      required int savedIndex}) {
    return _GameState(
      playGame: playGame,
      gameText: gameText,
      currentIndex: currentIndex,
      savedIndex: savedIndex,
    );
  }
}

/// @nodoc
const $GameState = _$GameStateTearOff();

/// @nodoc
mixin _$GameState {
  bool get playGame => throw _privateConstructorUsedError;
  String get gameText => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  int get savedIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res>;
  $Res call({bool playGame, String gameText, int currentIndex, int savedIndex});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res> implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  final GameState _value;
  // ignore: unused_field
  final $Res Function(GameState) _then;

  @override
  $Res call({
    Object? playGame = freezed,
    Object? gameText = freezed,
    Object? currentIndex = freezed,
    Object? savedIndex = freezed,
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
      savedIndex: savedIndex == freezed
          ? _value.savedIndex
          : savedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(
          _GameState value, $Res Function(_GameState) then) =
      __$GameStateCopyWithImpl<$Res>;
  @override
  $Res call({bool playGame, String gameText, int currentIndex, int savedIndex});
}

/// @nodoc
class __$GameStateCopyWithImpl<$Res> extends _$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(_GameState _value, $Res Function(_GameState) _then)
      : super(_value, (v) => _then(v as _GameState));

  @override
  _GameState get _value => super._value as _GameState;

  @override
  $Res call({
    Object? playGame = freezed,
    Object? gameText = freezed,
    Object? currentIndex = freezed,
    Object? savedIndex = freezed,
  }) {
    return _then(_GameState(
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
      savedIndex: savedIndex == freezed
          ? _value.savedIndex
          : savedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GameState extends _GameState {
  const _$_GameState(
      {required this.playGame,
      required this.gameText,
      required this.currentIndex,
      required this.savedIndex})
      : super._();

  @override
  final bool playGame;
  @override
  final String gameText;
  @override
  final int currentIndex;
  @override
  final int savedIndex;

  @override
  String toString() {
    return 'GameState(playGame: $playGame, gameText: $gameText, currentIndex: $currentIndex, savedIndex: $savedIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GameState &&
            (identical(other.playGame, playGame) ||
                const DeepCollectionEquality()
                    .equals(other.playGame, playGame)) &&
            (identical(other.gameText, gameText) ||
                const DeepCollectionEquality()
                    .equals(other.gameText, gameText)) &&
            (identical(other.currentIndex, currentIndex) ||
                const DeepCollectionEquality()
                    .equals(other.currentIndex, currentIndex)) &&
            (identical(other.savedIndex, savedIndex) ||
                const DeepCollectionEquality()
                    .equals(other.savedIndex, savedIndex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(playGame) ^
      const DeepCollectionEquality().hash(gameText) ^
      const DeepCollectionEquality().hash(currentIndex) ^
      const DeepCollectionEquality().hash(savedIndex);

  @JsonKey(ignore: true)
  @override
  _$GameStateCopyWith<_GameState> get copyWith =>
      __$GameStateCopyWithImpl<_GameState>(this, _$identity);
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {required bool playGame,
      required String gameText,
      required int currentIndex,
      required int savedIndex}) = _$_GameState;
  const _GameState._() : super._();

  @override
  bool get playGame => throw _privateConstructorUsedError;
  @override
  String get gameText => throw _privateConstructorUsedError;
  @override
  int get currentIndex => throw _privateConstructorUsedError;
  @override
  int get savedIndex => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GameStateCopyWith<_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}
