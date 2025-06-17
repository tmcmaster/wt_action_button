import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';

class ActionButtonProviders {
  final StateNotifierProvider<ActionStateNotifier, ActionState> progress;
  final StateNotifierProvider<StateNotifier<bool>, bool> dependencies;

  ActionButtonProviders({
    required this.progress,
    required this.dependencies,
  });
}
