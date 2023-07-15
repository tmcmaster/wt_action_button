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
  final Color? color;
  final Color? background;
  final bool floating;
  final bool noLabel;
  const ActionButton({
    super.key,
    required this.onPressed,
    this.onError,
    required this.icon,
    this.startStop = false,
    required this.definition,
    this.label,
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

    return noLabel && !floating
        ? _IconButton(
            color: color,
            colorScheme: colorScheme,
            icon: icon,
            action: action,
          )
        : floating
            ? _FloatingActionButton(
                action: action,
                background: background,
                colorScheme: colorScheme,
                color: color,
                icon: icon,
              )
            : _ElevatedButton(
                color: color,
                colorScheme: colorScheme,
                background: background,
                action: action,
                icon: icon,
                label: label,
              );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.color,
    required this.colorScheme,
    required this.icon,
    required this.action,
  });

  final Color? color;
  final ColorScheme colorScheme;
  final Icon icon;
  final Null Function()? action;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color ?? colorScheme.onPrimary,
      icon: icon,
      enableFeedback: true,
      onPressed: action,
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({
    required this.action,
    required this.background,
    required this.colorScheme,
    required this.color,
    required this.icon,
  });

  final Null Function()? action;
  final Color? background;
  final ColorScheme colorScheme;
  final Color? color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      enableFeedback: true,
      backgroundColor: action == null
          ? Colors.grey.shade300
          : background ?? colorScheme.primary,
      foregroundColor: action == null
          ? Colors.grey.shade700
          : color ?? colorScheme.onPrimary,
      onPressed: action,
      child: Icon(icon.icon),
    );
  }
}

class _ElevatedButton extends StatelessWidget {
  const _ElevatedButton({
    required this.color,
    required this.colorScheme,
    required this.background,
    required this.action,
    required this.icon,
    required this.label,
  });

  final Color? color;
  final ColorScheme colorScheme;
  final Color? background;
  final Null Function()? action;
  final Icon icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text(
              label ?? '',
              style: TextStyle(color: color ?? colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
