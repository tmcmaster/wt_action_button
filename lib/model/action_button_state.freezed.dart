// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_button_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActionButtonState _$ActionButtonStateFromJson(Map<String, dynamic> json) {
  return _ActionButtonState.fromJson(json);
}

/// @nodoc
mixin _$ActionButtonState {
  int get total => throw _privateConstructorUsedError;
  int get completed => throw _privateConstructorUsedError;
  String get currentItem => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  ActionButtonStatus get status => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  /// Serializes this ActionButtonState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionButtonState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionButtonStateCopyWith<ActionButtonState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionButtonStateCopyWith<$Res> {
  factory $ActionButtonStateCopyWith(
          ActionButtonState value, $Res Function(ActionButtonState) then) =
      _$ActionButtonStateCopyWithImpl<$Res, ActionButtonState>;
  @useResult
  $Res call(
      {int total,
      int completed,
      String currentItem,
      bool active,
      ActionButtonStatus status,
      List<String> errors});
}

/// @nodoc
class _$ActionButtonStateCopyWithImpl<$Res, $Val extends ActionButtonState>
    implements $ActionButtonStateCopyWith<$Res> {
  _$ActionButtonStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionButtonState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? completed = null,
    Object? currentItem = null,
    Object? active = null,
    Object? status = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      currentItem: null == currentItem
          ? _value.currentItem
          : currentItem // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActionButtonStatus,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActionButtonStateImplCopyWith<$Res>
    implements $ActionButtonStateCopyWith<$Res> {
  factory _$$ActionButtonStateImplCopyWith(_$ActionButtonStateImpl value,
          $Res Function(_$ActionButtonStateImpl) then) =
      __$$ActionButtonStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int total,
      int completed,
      String currentItem,
      bool active,
      ActionButtonStatus status,
      List<String> errors});
}

/// @nodoc
class __$$ActionButtonStateImplCopyWithImpl<$Res>
    extends _$ActionButtonStateCopyWithImpl<$Res, _$ActionButtonStateImpl>
    implements _$$ActionButtonStateImplCopyWith<$Res> {
  __$$ActionButtonStateImplCopyWithImpl(_$ActionButtonStateImpl _value,
      $Res Function(_$ActionButtonStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionButtonState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? completed = null,
    Object? currentItem = null,
    Object? active = null,
    Object? status = null,
    Object? errors = null,
  }) {
    return _then(_$ActionButtonStateImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      currentItem: null == currentItem
          ? _value.currentItem
          : currentItem // ignore: cast_nullable_to_non_nullable
              as String,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActionButtonStatus,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActionButtonStateImpl extends _ActionButtonState {
  const _$ActionButtonStateImpl(
      {this.total = 1,
      this.completed = 0,
      this.currentItem = '',
      this.active = false,
      this.status = ActionButtonStatus.notStarted,
      final List<String> errors = const []})
      : _errors = errors,
        super._();

  factory _$ActionButtonStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionButtonStateImplFromJson(json);

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int completed;
  @override
  @JsonKey()
  final String currentItem;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey()
  final ActionButtonStatus status;
  final List<String> _errors;
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'ActionButtonState(total: $total, completed: $completed, currentItem: $currentItem, active: $active, status: $status, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionButtonStateImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.currentItem, currentItem) ||
                other.currentItem == currentItem) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, completed, currentItem,
      active, status, const DeepCollectionEquality().hash(_errors));

  /// Create a copy of ActionButtonState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionButtonStateImplCopyWith<_$ActionButtonStateImpl> get copyWith =>
      __$$ActionButtonStateImplCopyWithImpl<_$ActionButtonStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionButtonStateImplToJson(
      this,
    );
  }
}

abstract class _ActionButtonState extends ActionButtonState {
  const factory _ActionButtonState(
      {final int total,
      final int completed,
      final String currentItem,
      final bool active,
      final ActionButtonStatus status,
      final List<String> errors}) = _$ActionButtonStateImpl;
  const _ActionButtonState._() : super._();

  factory _ActionButtonState.fromJson(Map<String, dynamic> json) =
      _$ActionButtonStateImpl.fromJson;

  @override
  int get total;
  @override
  int get completed;
  @override
  String get currentItem;
  @override
  bool get active;
  @override
  ActionButtonStatus get status;
  @override
  List<String> get errors;

  /// Create a copy of ActionButtonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionButtonStateImplCopyWith<_$ActionButtonStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
