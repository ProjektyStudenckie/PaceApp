// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'navbar_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NavBarStateTearOff {
  const _$NavBarStateTearOff();

  _NavbarState call({required NavItem navItem}) {
    return _NavbarState(
      navItem: navItem,
    );
  }
}

/// @nodoc
const $NavBarState = _$NavBarStateTearOff();

/// @nodoc
mixin _$NavBarState {
  NavItem get navItem => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NavBarStateCopyWith<NavBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavBarStateCopyWith<$Res> {
  factory $NavBarStateCopyWith(
          NavBarState value, $Res Function(NavBarState) then) =
      _$NavBarStateCopyWithImpl<$Res>;
  $Res call({NavItem navItem});
}

/// @nodoc
class _$NavBarStateCopyWithImpl<$Res> implements $NavBarStateCopyWith<$Res> {
  _$NavBarStateCopyWithImpl(this._value, this._then);

  final NavBarState _value;
  // ignore: unused_field
  final $Res Function(NavBarState) _then;

  @override
  $Res call({
    Object? navItem = freezed,
  }) {
    return _then(_value.copyWith(
      navItem: navItem == freezed
          ? _value.navItem
          : navItem // ignore: cast_nullable_to_non_nullable
              as NavItem,
    ));
  }
}

/// @nodoc
abstract class _$NavbarStateCopyWith<$Res>
    implements $NavBarStateCopyWith<$Res> {
  factory _$NavbarStateCopyWith(
          _NavbarState value, $Res Function(_NavbarState) then) =
      __$NavbarStateCopyWithImpl<$Res>;
  @override
  $Res call({NavItem navItem});
}

/// @nodoc
class __$NavbarStateCopyWithImpl<$Res> extends _$NavBarStateCopyWithImpl<$Res>
    implements _$NavbarStateCopyWith<$Res> {
  __$NavbarStateCopyWithImpl(
      _NavbarState _value, $Res Function(_NavbarState) _then)
      : super(_value, (v) => _then(v as _NavbarState));

  @override
  _NavbarState get _value => super._value as _NavbarState;

  @override
  $Res call({
    Object? navItem = freezed,
  }) {
    return _then(_NavbarState(
      navItem: navItem == freezed
          ? _value.navItem
          : navItem // ignore: cast_nullable_to_non_nullable
              as NavItem,
    ));
  }
}

/// @nodoc
class _$_NavbarState extends _NavbarState {
  const _$_NavbarState({required this.navItem}) : super._();

  @override
  final NavItem navItem;

  @override
  String toString() {
    return 'NavBarState(navItem: $navItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NavbarState &&
            (identical(other.navItem, navItem) ||
                const DeepCollectionEquality().equals(other.navItem, navItem)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(navItem);

  @JsonKey(ignore: true)
  @override
  _$NavbarStateCopyWith<_NavbarState> get copyWith =>
      __$NavbarStateCopyWithImpl<_NavbarState>(this, _$identity);
}

abstract class _NavbarState extends NavBarState {
  const factory _NavbarState({required NavItem navItem}) = _$_NavbarState;
  const _NavbarState._() : super._();

  @override
  NavItem get navItem => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$NavbarStateCopyWith<_NavbarState> get copyWith =>
      throw _privateConstructorUsedError;
}
