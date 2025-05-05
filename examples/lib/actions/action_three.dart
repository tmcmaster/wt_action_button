import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_action_button/model/action_info.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionThree extends ActionButtonDefinition {
  static final log = logger(ActionThree, level: Level.debug);

  static final provider = Provider(
    name: 'Action Three',
    (ref) => ActionThree(ref),
  );

  ActionThree(super.ref)
      : super(
          actionInfo: ActionInfo(
            label: 'Action Three',
            icon: Icons.upload,
            tooltip: 'Action Three',
          ),
        );

  @override
  Future<void> execute() async {
    const numberOfSteps = 10;
    final notifier = ref.read(progress.notifier);
    notifier.runWithFeedback(
      numberOfSteps: numberOfSteps,
      action: (feedback) async {
        log.d('Doing Action Three......');
        for (final i in List.generate(numberOfSteps, (i) => i)) {
          feedback('Current item: ${i + 1}');
          await Future.delayed(const Duration(seconds: 1));
        }
        log.d('Action Three Completed.');
      },
    );
  }
}
