// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_button_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActionButtonStateImpl _$$ActionButtonStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ActionButtonStateImpl(
      total: (json['total'] as num?)?.toInt() ?? 1,
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      currentItem: json['currentItem'] as String? ?? '',
      active: json['active'] as bool? ?? false,
      status:
          $enumDecodeNullable(_$ActionButtonStatusEnumMap, json['status']) ??
              ActionButtonStatus.notStarted,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ActionButtonStateImplToJson(
        _$ActionButtonStateImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'completed': instance.completed,
      'currentItem': instance.currentItem,
      'active': instance.active,
      'status': _$ActionButtonStatusEnumMap[instance.status]!,
      'errors': instance.errors,
    };

const _$ActionButtonStatusEnumMap = {
  ActionButtonStatus.notStarted: 'notStarted',
  ActionButtonStatus.inProgress: 'inProgress',
  ActionButtonStatus.blocked: 'blocked',
  ActionButtonStatus.completed: 'completed',
  ActionButtonStatus.skipped: 'skipped',
  ActionButtonStatus.failed: 'failed',
};
