import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_action_button/model/action_info.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionOne extends ActionButtonDefinition<int> {
  static final log = logger(ActionOne, level: Level.debug);

  static final provider = Provider(
    name: 'Action One',
    (ref) => ActionOne._(ref),
  );

  ActionOne._(super.ref)
      : super(
          actionInfo: ActionInfo(
            label: 'Action One',
            icon: Icons.menu,
            tooltip: 'Action One',
          ),
        );

  @override
  Future<void> executeWithState(int state) async {
    final notifier = ref.read(progress.notifier);
    notifier.start();
    log.d('Doing Action One......$state');
    for (int i = 1; i <= state; i++) {
      await Future.delayed(const Duration(seconds: 2));
      log.d('Tick....$i');
      if (i % 5 == 0) {
        break;
      }
    }
    log.d('Action one Completed.');
    notifier.finished();
  }
}
