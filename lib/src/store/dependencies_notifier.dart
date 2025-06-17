import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/src/dependency_checker.dart';
import 'package:wt_logging/wt_logging.dart';

class DependenciesNotifier extends StateNotifier<bool> {
  static final log = logger(DependenciesNotifier);
  final List<DependencyChecker> dependencies;
  final Map<String, bool> available = {};
  final List<ProviderSubscription> removeListeners = [];
  DependenciesNotifier({
    required Ref ref,
    required this.dependencies,
  }) : super(false) {
    final uniqueProviderNames = <String>{};
    for (final checker in dependencies) {
      if (checker.dependency.name == null) {
        throw Exception(
          'Providers must have a name: ${checker.dependency.runtimeType}',
        );
      }
      if (uniqueProviderNames.contains(checker.dependency.name)) {
        throw Exception(
          'Providers must have a unique name: ${checker.dependency.runtimeType}',
        );
      }

      removeListeners.add(
        ref.listen<dynamic>(checker.dependency, (previous, next) {
          final providerName = checker.dependency.name ?? 'should not happen';
          available[providerName] = checker.check(next);
          _recheck();
        }),
      );

      final providerName = checker.dependency.name ?? 'should not happen';
      final value = ref.read(checker.dependency);
      available[providerName] = checker.check(value);
    }
    _recheck();
  }

  @override
  void dispose() {
    for (final removeListener in removeListeners) {
      removeListener.close();
    }
    super.dispose();
  }

  void _recheck() {
    final newState = available.values.fold<bool>(true, (prev, next) => prev && next);
    if (state != newState) state = newState;
  }
}
