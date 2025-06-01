import 'package:flutter/cupertino.dart';

class ActionInfo {
  final String label;
  final IconData icon;
  final String? tooltip;
  final bool isConfirmationOnly;

  ActionInfo({
    required this.label,
    required this.icon,
    this.tooltip,
    this.isConfirmationOnly = false,
  });

  ActionInfo copyWith({
    String? label,
    IconData? icon,
    double? iconSize,
    String? tooltip,
  }) {
    return ActionInfo(
      label: label ?? this.label,
      icon: icon ?? this.icon,
      tooltip: tooltip ?? this.tooltip,
    );
  }
}
