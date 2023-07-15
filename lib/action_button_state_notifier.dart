import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_state.dart';
import 'package:wt_logging/wt_logging.dart';

typedef LogMethod = void Function(
  dynamic message, [
  dynamic error,
  StackTrace? stackTrace,
]);

class ActionButtonStateNotifier extends StateNotifier<ActionButtonState> {
  final Ref _ref;
  final bool snackBar;
  final bool userLog;
  final LogMethod? log;
  ActionButtonStateNotifier(
    this._ref, {
    this.snackBar = false,
    this.userLog = false,
    this.log,
  }) : super(
          ActionButtonState(
            total: 0,
            completed: 0,
            currentItem: '',
          ),
        );

  void start({
    int total = 1,
    String currentItem = '',
  }) {
    state =
        ActionButtonState(total: total, completed: 0, currentItem: currentItem);
  }

  Future<void> runWithFeedback({
    required int numberOfSteps,
    required Future<void> Function(Function(String currentItem) feedback)
        action,
  }) async {
    try {
      start(total: numberOfSteps);
      await action((currentItem) {
        next(currentItem: currentItem);
      });
      finished();
    } catch (err) {
      error(err.toString());
    }
  }

  Future<void> run(Function() action) async {
    try {
      start();
      await action();
      finished();
    } catch (err) {
      error(err.toString());
    }
  }

  void next({String? currentItem}) {
    if (state.completed + 1 <= state.total) {
      state = ActionButtonState(
        total: state.total,
        completed: state.completed + 1,
        currentItem: currentItem ?? '',
        errors: state.errors,
      );
    }
  }

  void error(String message) {
    state = ActionButtonState(
      total: state.total,
      completed: state.completed + 1,
      currentItem: state.currentItem,
      errors: [...state.errors, '${state.currentItem} : $message'],
    );
    if (userLog) {
      _ref.read(UserLog.provider).error(message, snackBar: snackBar, log: log);
    } else {
      log?.call(message);
    }
  }

  void finished() {
    state = ActionButtonState(
      total: state.total,
      completed: state.total,
      currentItem: '',
      errors: state.errors,
    );
  }
}
