import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';

export 'action_button_providers.dart';
export 'action_button_state.dart';
export 'action_button_state_notifier.dart';
export 'dependencies_notifier.dart';
export 'dependency_checker.dart';

class ActionButton extends HookConsumerWidget {
  final VoidCallback? onPressed;
  final Icon icon;
  final bool startStop;
  final ActionButtonDefinition jobState;
  final String? label;
  final Color? color;
  final Color? background;
  final bool floating;
  final bool noLabel;
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.startStop = false,
    required this.jobState,
    this.label,
    this.color,
    this.background,
    this.floating = true,
    this.noLabel = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(jobState.progress);
    final bool dependencies = ref.watch(jobState.dependencies);
    final notifier = ref.read(jobState.progress.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    final action = progress.done && onPressed != null && dependencies
        ? () {
            try {
              if (startStop) notifier.finished();
              onPressed!.call();
            } catch (error) {
              // TODO: need to review what to doo with error
              rethrow;
            } finally {
              if (startStop) notifier.start(total: 1);
            }
          }
        : null;
    return label != null && !noLabel
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: color ?? colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
              backgroundColor: background ?? colorScheme.primary,
            ),
            onPressed: action,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  size: 15,
                  icon.icon,
                  color: color ?? colorScheme.onPrimary,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  label ?? '',
                  style: TextStyle(color: color ?? colorScheme.onPrimary),
                ),
              ],
            ),
          )
        : floating
            ? FloatingActionButton(
                enableFeedback: true,
                backgroundColor: action == null ? Colors.grey.shade300 : background ?? colorScheme.primary,
                foregroundColor: action == null ? Colors.grey.shade700 : color ?? colorScheme.onPrimary,
                onPressed: action,
                child: Icon(icon.icon),
              )
            : IconButton(
                color: color ?? colorScheme.onPrimary,
                icon: icon,
                enableFeedback: true,
                onPressed: action,
              );
  }
}
