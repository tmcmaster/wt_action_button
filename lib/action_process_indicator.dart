import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/wt_action_button.dart';

enum IndicatorType { circular, linear }

class ActionProgressIndicator extends ConsumerWidget {
  final ActionButtonDefinition definition;
  final IndicatorType type;

  const ActionProgressIndicator({
    super.key,
    required this.definition,
    this.type = IndicatorType.circular,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentage = ref.watch(definition.progress).percentage;
    return type == IndicatorType.linear
        ? LinearProgressIndicator(
            value: percentage,
          )
        : AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(
              value: percentage,
            ),
          );
  }
}
