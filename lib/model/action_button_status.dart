import 'package:flutter/material.dart';

enum ActionButtonStatus {
  notStarted(
    label: 'Not Started',
    icon: Icons.check_box_outline_blank,
    color: Colors.grey,
  ),
  inProgress(
    label: 'In Progress',
    icon: Icons.timelapse,
    color: Colors.blue,
  ),
  blocked(
    label: 'Blocked',
    icon: Icons.block,
    color: Colors.orange,
  ),
  completed(
    label: 'Completed',
    icon: Icons.check,
    color: Colors.green,
  ),
  skipped(
    label: 'Skipped',
    icon: Icons.skip_next,
    color: Colors.purple,
  ),
  failed(
    label: 'Failed',
    icon: Icons.error,
    color: Colors.red,
  );

  final String label;
  final IconData icon;
  final Color color;

  const ActionButtonStatus({
    required this.label,
    required this.icon,
    required this.color,
  });
}
