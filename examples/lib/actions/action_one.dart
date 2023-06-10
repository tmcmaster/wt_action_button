import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionOne extends ActionButtonDefinition {
  static final log = logger(ActionOne, level: Level.debug);

  static final provider = Provider(
    name: 'Action One',
    (ref) => ActionOne._(ref),
  );

  ActionOne._(super.ref)
      : super(
          label: 'Action One',
          icon: Icons.menu,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start();
    log.d('Doing Action One......');
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (i % 5 == 0) {
        log.d('Action one Completed.');
        notifier.finished();
        break;
      }
    }
  }
}
