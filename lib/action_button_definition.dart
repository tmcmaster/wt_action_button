import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button.dart';
import 'package:wt_action_button/action_process_indicator.dart';
import 'package:wt_action_button/model/action_info.dart';
import 'package:wt_action_button/widget/action_button_status_icon.dart';
import 'package:wt_logging/wt_logging.dart';

abstract class ActionButtonDefinition<T> {
  static final log = logger(ActionButtonDefinition, level: Level.warning);

  late StateNotifierProvider<ActionButtonStateNotifier, ActionButtonState> progress;
  late StateNotifierProvider<StateNotifier<bool>, bool> dependencies;

  final Ref ref;

  final ActionInfo actionInfo;

  ActionButtonDefinition(
    this.ref, {
    required this.actionInfo,
    bool snackBar = false,
    bool userLog = false,
    Logger? log,
    List<DependencyChecker> dependencyCheckers = const [],
  }) {
    progress = StateNotifierProvider<ActionButtonStateNotifier, ActionButtonState>(
      name: 'actionOneProviders',
      (ref) => ActionButtonStateNotifier(
        ref,
        snackBar: snackBar,
        userLog: userLog,
        log: log,
      ),
    );
    dependencies = StateNotifierProvider<StateNotifier<bool>, bool>(
      name: 'Action One Progress',
      (ref) => DependenciesNotifier(
        ref: ref,
        dependencies: dependencyCheckers,
      ),
    );
  }

  Widget indicator({
    IndicatorType type = IndicatorType.circular,
  }) {
    return ActionProgressIndicator(
      definition: this,
      type: type,
    );
  }

  Widget statusIcon() {
    return ActionButtonStatusIcon(
      actionInfo: actionInfo,
      stateProvider: progress,
      onTap: () {
        ref.read(progress.notifier).resetAction();
      },
    );
  }

  Widget component({
    String? label,
    String? tooltip,
    IconData? icon,
    Color? color,
    Color? background,
    bool floating = false,
    bool noLabel = false,
    double? iconSize,
    T? state,
    bool disabled = false,
    VoidCallback? onComplete,
    void Function(String error)? onError,
  }) {
    log.d('Creating button component: $state');
    return ActionButton(
      actionInfo: actionInfo.copyWith(
        label: label,
        tooltip: tooltip,
        icon: icon,
        iconSize: iconSize,
      ),
      floating: floating,
      noLabel: noLabel,
      color: color,
      background: background,
      definition: this,
      onPressed: disabled ? null : () => state == null ? execute() : executeWithState(state),
      onComplete: onComplete,
      onError: (error) {
        ref.read(UserLog.provider).error(error);
        onError?.call(error);
      },
    );
  }

  Future<void> execute() {
    throw Exception('execute() needs to be overridden if it is to be used.');
  }

  Future<void> executeWithState(T state) {
    throw Exception('executeWithState(state) needs to be overridden if it is to be used.');
  }

  Future<void> simulate(
    String message, {
    Logger? logger,
    Duration duration = const Duration(seconds: 2),
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(progress.notifier).run(() {
        (logger ?? log).i(message);
        return Future.delayed(duration, () {
          (logger ?? log).i('Completed($message)');
        });
      });
    });
  }
}
