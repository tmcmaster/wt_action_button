import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:wt_action_button/action_button.dart';

abstract class ActionDefinition {
  late StateNotifierProvider<ActionButtonStateNotifier, ActionButtonState> progress;
  late StateNotifierProvider<StateNotifier<bool>, bool> dependencies;

  final Ref ref;

  final String label;
  final IconData icon;

  ActionDefinition(this.ref, {required this.icon, required this.label}) {
    progress = StateNotifierProvider<ActionButtonStateNotifier, ActionButtonState>(
      name: 'actionOneProviders',
      (ref) => ActionButtonStateNotifier(),
    );
    dependencies = StateNotifierProvider<StateNotifier<bool>, bool>(
      name: 'Action One Progress',
      (ref) => DependenciesNotifier(
        ref: ref,
        dependencies: [],
      ),
    );
  }

  Widget component({
    String? label,
    IconData? icon,
    Color? color,
    Color? background,
    bool floating = false,
    bool noLabel = false,
  }) {
    return ActionButton(
      label: label ?? this.label,
      icon: Icon(icon ?? this.icon),
      floating: floating,
      noLabel: noLabel,
      color: color,
      background: background,
      jobState: this,
      onPressed: () => execute(),
    );
  }

  Future<void> execute();
}
