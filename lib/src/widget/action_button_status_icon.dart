import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';

class ActionButtonStatusIcon extends ConsumerWidget {
  final ActionInfo actionInfo;
  final StateNotifierProvider<ActionStateNotifier, ActionState> stateProvider;
  final VoidCallback onTap;

  const ActionButtonStatusIcon({
    super.key,
    required this.actionInfo,
    required this.stateProvider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionState = ref.watch(stateProvider);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Container(
          padding: const EdgeInsets.only(left: 4),
          width: 40,
          height: 40,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  actionInfo.icon,
                  size: 24,
                ),
              ),
              if (actionState.status != ActionStatus.notStarted)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                    child: Icon(
                      actionState.status.icon,
                      color: actionState.status.color,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
