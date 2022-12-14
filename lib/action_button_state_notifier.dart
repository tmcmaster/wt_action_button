import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'action_button_state.dart';

class ActionButtonStateNotifier extends StateNotifier<ActionButtonState> {
  ActionButtonStateNotifier()
      : super(ActionButtonState(
          total: 0,
          completed: 0,
          currentItem: '',
        ));

  start({
    required int total,
    String currentItem = '',
  }) {
    state = ActionButtonState(total: total, completed: 0, currentItem: currentItem);
  }

  void runWithFeedback({
    required int numberOfSteps,
    required Future<void> Function(Function(String currentItem) feedback) action,
  }) async {
    try {
      start(total: numberOfSteps);
      await action((currentItem) {
        next(currentItem: currentItem);
      });
      finished();
    } catch (err) {
      error(error.toString());
    }
  }

  Future<void> run(Function() action) async {
    try {
      start(total: 1);
      await action();
      finished();
    } catch (err) {
      error(error.toString());
    }
  }

  next({String? currentItem}) {
    if (state.completed + 1 <= state.total) {
      state = ActionButtonState(
        total: state.total,
        completed: state.completed + 1,
        currentItem: currentItem ?? '',
        errors: state.errors,
      );
    }
  }

  error(String message) {
    state = ActionButtonState(
      total: state.total,
      completed: state.completed + 1,
      currentItem: state.currentItem,
      errors: [...state.errors, '${state.currentItem} : $message'],
    );
  }

  finished() {
    state = ActionButtonState(
      total: state.total,
      completed: state.total,
      currentItem: '',
      errors: state.errors,
    );
  }
}
