import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:utils/logging.dart';

import 'dependency_checker.dart';

class DependenciesNotifier extends StateNotifier<bool> {
  static final log = logger(DependenciesNotifier);
  final List<DependencyChecker> dependencies;
  final Map<String, bool> available = {};
  final List<ProviderSubscription> removeListeners = [];
  DependenciesNotifier({
    required Ref ref,
    required this.dependencies,
  }) : super(false) {
    Set<String> uniqueProviderNames = {};
    for (var checker in dependencies) {
      if (checker.dependency.name == null) {
        throw Exception('Providers must have a name: ${checker.dependency.runtimeType}');
      }
      if (uniqueProviderNames.contains(checker.dependency.name)) {
        throw Exception('Providers must have a unique name: ${checker.dependency.runtimeType}');
      }

      removeListeners.add(ref.listen<dynamic>(checker.dependency, (previous, next) {
        String providerName = checker.dependency.name ?? 'should not happen';
        available[providerName] = checker.check(next);
        _recheck();
      }));

      String providerName = checker.dependency.name ?? 'should not happen';
      final value = ref.read(checker.dependency);
      available[providerName] = checker.check(value);
    }
    _recheck();
  }

  @override
  void dispose() {
    for (var removeListener in removeListeners) {
      removeListener.close();
    }
    super.dispose();
  }

  void _recheck() {
    final newState = available.values.fold<bool>(true, (prev, next) => prev && next);
    if (state != newState) state = newState;
  }
}
