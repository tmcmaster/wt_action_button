import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionButtonStateNotifier extends ActionStateNotifier {
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
        super(ActionState.empty);

  @override
  void start({
    int total = 1,
    String currentItem = '',
  }) {
    if (state.active) {
      throw Exception('There is already an active action');
    }
    state = ActionState.empty.copyWith(
      active: true,
      total: total,
      currentItem: currentItem,
      status: ActionStatus.inProgress,
    );
    log.d('Start State: $state');
  }

  @override
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

  @override
  Future<void> run(Function() action) async {
    start();
    try {
      await action();
      state = state.copyWith(
        status: ActionStatus.completed,
      );
    } catch (err, stacktrace) {
      error(err.toString(), stacktrace: stacktrace);
    } finally {
      finished();
    }
  }

  @override
  void next({String currentItem = ''}) {
    if (state.completed + 1 <= state.total) {
      log.d('Completed a step: $currentItem');
      final newCompleted = state.completed + 1;
      final newActive = newCompleted < state.total;
      state = state.copyWith(
        completed: newCompleted,
        currentItem: currentItem,
        active: newActive,
        status: newActive == true ? ActionStatus.inProgress : state.status,
      );
    } else {
      log.w('next was called when all of the steps had been completed: $currentItem');
      finished();
    }
  }

  @override
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

  @override
  void finished() {
    state = state.copyWith(
        completed: state.total,
        active: false,
        status: state.hasErrors ? ActionStatus.failed : ActionStatus.completed);
  }

  @override
  void setStatus(ActionStatus status) {
    state = state = state.copyWith(
      completed: 0,
      active: false,
      errors: [],
      currentItem: '',
      status: status,
    );
  }

  @override
  void resetAction() {
    if (!state.active) {
      state = state.copyWith(
        completed: 0,
        active: false,
        errors: [],
        currentItem: '',
        status: ActionStatus.notStarted,
      );
    }
  }

  @override
  Future<void> simulate(
    String message, {
    Logger? logger,
    bool throwError = false,
    Duration duration = const Duration(seconds: 2),
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      run(() {
        (logger ?? log).i('Simulating($message)');
        return Future.delayed(duration, () {
          if (throwError) {
            throw Exception('Error($message)');
          } else {
            (logger ?? log).i('Completed($message)');
          }
        });
      });
    });
  }
}
