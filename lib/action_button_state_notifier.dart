import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_state.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionButtonStateNotifier extends StateNotifier<ActionButtonState> {
  static final _logger = logger(ActionButtonStateNotifier, level: Level.debug);

  final Ref _ref;
  final bool snackBar;
  final bool userLog;
  late final Logger log;
  ActionButtonStateNotifier(
    this._ref, {
    this.snackBar = false,
    this.userLog = false,
    Logger? log,
  })  : log = log ?? _logger,
        super(
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
    state = ActionButtonState(total: total, completed: 0, currentItem: currentItem);
  }

  Future<void> runWithFeedback({
    required int numberOfSteps,
    required Future<void> Function(Function(String currentItem) feedback) action,
  }) async {
    try {
      start(total: numberOfSteps);
      await action((currentItem) {
        next(currentItem: currentItem);
      });
    } catch (err) {
      error(err.toString());
    } finally {
      finished();
    }
  }

  Future<void> run(Function() action) async {
    try {
      start();
      await action();
    } catch (err) {
      error(err.toString());
    } finally {
      finished();
    }
  }

  void next({String? currentItem}) {
    if (state.completed + 1 <= state.total) {
      log.d('Completed a step: $currentItem');
      state = ActionButtonState(
        total: state.total,
        completed: state.completed + 1,
        currentItem: currentItem ?? '',
        errors: state.errors,
      );
    } else {
      log.w('next was called when all of the steps ad been completed: $currentItem');
    }
  }

  void error(String message) {
    if (userLog) {
      _ref.read(UserLog.provider).error(message, showSnackBar: snackBar, log: log.e);
    } else {
      log.e(message);
    }
    state = ActionButtonState(
      total: state.total,
      completed: state.completed + 1,
      currentItem: state.currentItem,
      errors: [...state.errors, '${state.currentItem} : $message'],
    );
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
