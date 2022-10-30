import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'action_button_state.dart';
import 'action_button_state_notifier.dart';

class ActionButtonProviders {
  final StateNotifierProvider<ActionButtonStateNotifier, ActionButtonState> progress;
  final StateNotifierProvider<StateNotifier<bool>, bool> dependencies;

  ActionButtonProviders({
    required this.progress,
    required this.dependencies,
  });
}
