import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/src/store/action_button_state_notifier.dart';
import 'package:wt_action_button/src/widget/action_button_widget.dart';
import 'package:wt_action_button/src/widget/action_process_indicator.dart';
import 'package:wt_action_button/src/store/dependencies_notifier.dart';
import 'package:wt_action_button/src/dependency_checker.dart';
import 'package:wt_action_button/src/widget/action_button_status_icon.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionButtonDefinition<T> with ActionDefinition<T> {
  static final log = logger(ActionButtonDefinition, level: Level.warning);

  late final ActionStateNotifier _notifier;
  @override
  late final StateNotifierProvider<ActionStateNotifier, ActionState> progress;
  late final StateNotifierProvider<StateNotifier<bool>, bool> dependencies;

  final Ref ref;

  @override
  final ActionInfo actionInfo;
  late final Future<void> Function(Ref ref, ActionStateNotifier notifier, T? state) _execute;

  ActionButtonDefinition(
    this.ref, {
    required this.actionInfo,
    required Future<void> Function(Ref ref, ActionStateNotifier notifier, T? state) execute,
    bool snackBar = false,
    bool userLog = false,
    Logger? log,
    List<DependencyChecker> dependencyCheckers = const [],
  }) {
    _execute = execute;
    _notifier = ActionButtonStateNotifier(
      ref,
      snackBar: snackBar,
      userLog: userLog,
      log: log,
    );
    progress = StateNotifierProvider<ActionStateNotifier, ActionState>(
      name: 'actionOneProviders',
      (ref) => _notifier,
    );
    dependencies = StateNotifierProvider<StateNotifier<bool>, bool>(
      name: 'Action One Progress',
      (ref) => DependenciesNotifier(
        ref: ref,
        dependencies: dependencyCheckers,
      ),
    );
  }

  @override
  Widget indicator({
    ActionIndicatorType type = ActionIndicatorType.circular,
  }) {
    return ActionProgressIndicator(
      definition: this,
      type: type,
    );
  }

  @override
  Widget statusIcon() {
    return ActionButtonStatusIcon(
      actionInfo: actionInfo,
      stateProvider: progress,
      onTap: () {
        ref.read(progress.notifier).resetAction();
      },
    );
  }

  @override
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
    return ActionButtonWidget(
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
      onPressed: disabled ? null : () => _execute(ref, _notifier, state),
      onComplete: onComplete,
      onError: (error) {
        ref.read(UserLog.provider).error(error);
        onError?.call(error);
      },
    );
  }

  @override
  Future<void> execute([T? state]) => _execute(ref, _notifier, state);

  Future<void> simulate(
    String message, {
    Logger? logger,
    bool throwError = false,
    Duration duration = const Duration(seconds: 2),
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(progress.notifier).run(() {
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

  static ProviderBase<ActionButtonDefinition> confirmation({
    required ActionInfo actionInfo,
    bool snackBar = false,
    bool userLog = false,
    Logger? log,
    List<DependencyChecker> dependencyCheckers = const [],
  }) {
    return Provider.autoDispose((ref) => _ConfirmationOnlyActionDefinition(ref,
        actionInfo: actionInfo,
        snackBar: snackBar,
        userLog: userLog,
        log: log,
        dependencyCheckers: dependencyCheckers));
  }
}

class _ConfirmationOnlyActionDefinition extends ActionButtonDefinition {
  _ConfirmationOnlyActionDefinition(
    super.ref, {
    required super.actionInfo,
    super.snackBar,
    super.userLog,
    super.log,
    super.dependencyCheckers,
  }) : super(
          execute: (ref, notifier, _) async => notifier.finished(),
        );
}
