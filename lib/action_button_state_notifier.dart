import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/model/action_button_state.dart';
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
        super(ActionButtonState.empty);

  void start({
    int total = 1,
    String currentItem = '',
  }) {
    if (state.active) {
      throw Exception('There is already an active action');
    }
    state = ActionButtonState.empty.copyWith(
      active: true,
      total: total,
      currentItem: currentItem,
    );
    log.d('Start State: $state');
  }

  Future<void> runWithFeedback({
    required int numberOfSteps,
    required Future<void> Function(Function(String currentItem) feedback) action,
  }) async {
    start(total: numberOfSteps);
    try {
      await action((currentItem) {
        next(currentItem: currentItem);
      });
    } catch (err, stacktrace) {
      error(err.toString(), stacktrace: stacktrace);
    } finally {
      finished();
    }
  }

  Future<void> run(Function() action) async {
    start();
    try {
      await action();
    } catch (err, stacktrace) {
      error(err.toString(), stacktrace: stacktrace);
    } finally {
      finished();
    }
  }

  void next({String currentItem = ''}) {
    if (state.completed + 1 <= state.total) {
      log.d('Completed a step: $currentItem');
      final newCompleted = state.completed + 1;
      final newActive = newCompleted < state.total;
      state = state.copyWith(
        completed: newCompleted,
        currentItem: currentItem,
        active: newActive,
      );
    } else {
      log.w('next was called when all of the steps had been completed: $currentItem');
      finished();
    }
  }

  void error(String message, {StackTrace? stacktrace}) {
    if (userLog) {
      _ref.read(UserLog.provider).error(message, showSnackBar: snackBar, log: log.e);
    } else {
      if (stacktrace != null) {
        log.e('$message : $stacktrace');
      } else {
        log.e(message);
      }
    }
    state = state.copyWith(
      active: false,
      errors: [
        ...state.errors,
        if (stacktrace == null)
          '${state.currentItem} : $message'
        else
          '${state.currentItem} : $message : $stacktrace',
      ],
    );
  }

  void finished() {
    state = state.copyWith(
      completed: state.total,
      active: false,
    );
  }
}
