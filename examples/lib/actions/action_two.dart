import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utils/logging.dart';
import 'package:wt_action_button/action_definition.dart';

class ActionTwo extends ActionDefinition {
  static final log = logger(ActionTwo, level: Level.debug);

  static final provider = Provider(
    name: 'HarvestListGenerationAction',
    (ref) => ActionTwo(ref),
  );

  ActionTwo(super.ref) : super(label: 'Action Two', icon: Icons.start);

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start(total: 1);
    log.d('Doing Action......');
    await Future.delayed(const Duration(seconds: 1));
    log.d('Action Completed.');
    notifier.finished();
  }
}
