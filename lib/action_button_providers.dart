import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_state_notifier.dart';
import 'package:wt_action_button/model/action_button_state.dart';

class ActionButtonProviders {
  final StateNotifierProvider<ActionButtonStateNotifier, ActionButtonState> progress;
  final StateNotifierProvider<StateNotifier<bool>, bool> dependencies;

  ActionButtonProviders({
    required this.progress,
    required this.dependencies,
  });
}
