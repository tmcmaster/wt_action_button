import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionTwo extends ActionButtonDefinition {
  static final log = logger(ActionTwo, level: Level.debug);

  static final provider = Provider(
    name: 'Action Two',
    (ref) => ActionTwo(ref),
  );

  ActionTwo(super.ref)
      : super(
          label: 'Action Two',
          icon: Icons.start,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.run(() async {
      log.d('Doing Action Two......');
      await Future.delayed(const Duration(seconds: 1));
      log.d('Action Two Completed.');
    });
  }
}
