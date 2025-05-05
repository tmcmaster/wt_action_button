import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_action_button/model/action_button_status.dart';

part 'action_button_state.freezed.dart';
part 'action_button_state.g.dart';

@freezed
class ActionButtonState with _$ActionButtonState {
  const factory ActionButtonState({
    @Default(1) int total,
    @Default(0) int completed,
    @Default('') String currentItem,
    @Default(false) bool active,
    @Default([]) List<String> errors,
  }) = _ActionButtonState;

  const ActionButtonState._();

  static const empty = ActionButtonState();

  double get percentage => total == 0 ? 100 : (completed / total) * 100;
  bool get done => total == completed && !active;
  bool get hasErrors => errors.isNotEmpty;

  ActionButtonStatus get status {
    if (hasErrors) {
      return ActionButtonStatus.failed;
    } else if (done) {
      return ActionButtonStatus.completed;
    } else if (active) {
      return ActionButtonStatus.inProgress;
    } else if (completed == 0) {
      return ActionButtonStatus.notStarted;
    } else if (completed < total) {
      return ActionButtonStatus.skipped;
    } else {
      return ActionButtonStatus.blocked;
    }
  }

  factory ActionButtonState.fromJson(Map<String, dynamic> json) =>
      _$ActionButtonStateFromJson(json);
}
