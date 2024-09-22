import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';

export 'action_button_providers.dart';
export 'action_button_state.dart';
export 'action_button_state_notifier.dart';
export 'dependencies_notifier.dart';
export 'dependency_checker.dart';

class ActionButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final void Function(String error)? onError;
  final Icon icon;
  final bool startStop;
  final ActionButtonDefinition definition;
  final String? label;
  final String? tooltip;
  final Color? color;
  final Color? background;
  final bool floating;
  final bool noLabel;
  final double? iconSize;
  const ActionButton({
    super.key,
    required this.onPressed,
    this.onError,
    required this.icon,
    this.startStop = false,
    required this.definition,
    this.label,
    this.tooltip,
    this.color,
    this.background,
    this.floating = true,
    this.noLabel = false,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(definition.progress);
    final bool dependencies = ref.watch(definition.dependencies);
    final notifier = ref.read(definition.progress.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final action = progress.done && onPressed != null && dependencies
        ? () {
            try {
              if (startStop) notifier.finished();
              onPressed!.call();
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
                backgroundColor: action == null
                    ? Colors.grey.shade300
                    : background ?? colorScheme.primary,
                foregroundColor: action == null
                    ? Colors.grey.shade700
                    : color ?? colorScheme.onPrimary,
                onPressed: action,
                child: Icon(icon.icon),
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
                  size: 15,
                  icon.icon,
                  color: color ?? colorScheme.onPrimary,
                ),
                label: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    label ?? '',
                    style: TextStyle(color: color ?? colorScheme.onPrimary),
                  ),
                ),
                onPressed: action,
              )
        : label == null || noLabel
            ? IconButton(
                color: color ?? colorScheme.onPrimary,
                icon: icon,
                enableFeedback: true,
                onPressed: action,
              )
            : ElevatedButton.icon(
                onPressed: action,
                icon: icon,
                label: Text(label!),
              );
    return tooltip == null
        ? buttonWidget
        : Tooltip(
            message: tooltip,
            child: buttonWidget,
          );
  }
}
