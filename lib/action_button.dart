import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_action_button/model/action_info.dart';

export 'action_button_providers.dart';
export 'action_button_state_notifier.dart';
export 'dependencies_notifier.dart';
export 'dependency_checker.dart';
export 'model/action_button_state.dart';

class ActionButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final void Function(String error)? onError;
  final void Function()? onComplete;
  final ActionInfo actionInfo;
  final bool startStop;
  final ActionButtonDefinition definition;
  final Color? color;
  final Color? background;
  final bool floating;
  final bool noLabel;
  final double iconSize;
  const ActionButton({
    super.key,
    required this.actionInfo,
    required this.onPressed,
    this.onError,
    this.onComplete,
    this.startStop = false,
    required this.definition,
    this.iconSize = 15,
    this.color,
    this.background,
    this.floating = true,
    this.noLabel = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(definition.progress);
    final bool dependencies = ref.watch(definition.dependencies);
    final notifier = ref.read(definition.progress.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final action = !progress.active && onPressed != null && dependencies
        ? () {
            try {
              if (startStop) notifier.finished();
              onPressed!.call();
              onComplete?.call();
            } catch (error) {
              onError?.call(error.toString());
            } finally {
              if (startStop) notifier.start(total: 1);
            }
          }
        : null;

    final buttonWidget = floating
        ? noLabel
            ? FloatingActionButton(
                enableFeedback: true,
                backgroundColor:
                    action == null ? Colors.grey.shade300 : background ?? colorScheme.primary,
                foregroundColor:
                    action == null ? Colors.grey.shade700 : color ?? colorScheme.onPrimary,
                onPressed: action,
                child: Icon(actionInfo.icon),
              )
            : ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: color ?? colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                  backgroundColor: background ?? colorScheme.primary,
                ),
                icon: Icon(
                  size: iconSize,
                  actionInfo.icon,
                  color: color ?? colorScheme.onPrimary,
                ),
                label: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    actionInfo.label,
                    style: TextStyle(color: color ?? colorScheme.onPrimary),
                  ),
                ),
                onPressed: action,
              )
        : noLabel
            ? IconButton(
                color: color ?? colorScheme.onPrimary,
                icon: Icon(actionInfo.icon),
                enableFeedback: true,
                onPressed: action,
              )
            : ElevatedButton.icon(
                onPressed: action,
                icon: Icon(actionInfo.icon),
                label: Text(actionInfo.label),
              );
    return actionInfo.tooltip == null
        ? buttonWidget
        : Tooltip(
            message: actionInfo.tooltip,
            child: buttonWidget,
          );
  }
}
