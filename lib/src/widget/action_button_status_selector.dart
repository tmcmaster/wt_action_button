import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';

class ActionStatusSelector extends ConsumerStatefulWidget {
  final ActionInfo actionInfo;
  final StateNotifierProvider<ActionStateNotifier, ActionState> stateProvider;

  const ActionStatusSelector({
    super.key,
    required this.actionInfo,
    required this.stateProvider,
  });

  @override
  ConsumerState<ActionStatusSelector> createState() => _PopupMenuStatusSelectorState();
}

class _PopupMenuStatusSelectorState extends ConsumerState<ActionStatusSelector> {
  final _popupKey = GlobalKey<PopupMenuButtonState<ActionStatus>>();

  @override
  void initState() {
    super.initState();
  }

  void _resetStatus() {
    ref.read(widget.stateProvider.notifier).resetAction();
  }

  void _showPopupMenu() {
    _popupKey.currentState?.showButtonMenu();
  }

  void _handleStatusSelected(ActionStatus status) {
    ref.read(widget.stateProvider.notifier).setStatus(status);
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(widget.stateProvider);
    return InkWell(
      onTap: actionState.active ? null : _resetStatus,
      onLongPress: actionState.active ? null : _showPopupMenu,
      child: PopupMenuButton<ActionStatus>(
        key: _popupKey,
        onSelected: _handleStatusSelected,
        itemBuilder: (BuildContext context) {
          return ActionStatus.values.map((status) {
            return PopupMenuItem<ActionStatus>(
              value: status,
              child: Row(
                children: [
                  Icon(status.icon, color: status.color),
                  const SizedBox(width: 8),
                  Text(status.label),
                ],
              ),
            );
          }).toList();
        },
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
                    widget.actionInfo.icon,
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
      ),
    );
  }
}
