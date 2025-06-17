import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button.dart';
import 'package:wt_app_definition/app_definition.dart';

// enum IndicatorType { circular, linear, icon }

class ActionProgressIndicator extends ConsumerWidget {
  final ActionButtonDefinition definition;
  final ActionIndicatorType type;

  const ActionProgressIndicator({
    super.key,
    required this.definition,
    this.type = ActionIndicatorType.circular,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentage = ref.watch(definition.progress).percentage;
    return type == ActionIndicatorType.linear
        ? LinearProgressIndicator(
            value: percentage / 100,
          )
        : AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(
              value: percentage / 100,
            ),
          );
  }
}
