import 'package:hooks_riverpod/hooks_riverpod.dart';

class DependencyChecker<T> {
  // TODO: is dependency required
  final AlwaysAliveProviderBase<T> dependency;
  final bool Function(T value) predicate;

  DependencyChecker({
    required this.dependency,
    required this.predicate,
  });

  bool check(T value) {
    return predicate(value);
  }
}

class NotEmptyDependencyChecker<T extends Iterable> extends DependencyChecker<T> {
  NotEmptyDependencyChecker({
    required super.dependency,
  }) : super(predicate: (value) => value.isNotEmpty);
}

class NotNullDependencyChecker<T> extends DependencyChecker<T> {
  NotNullDependencyChecker({
    required super.dependency,
  }) : super(predicate: (value) => value != null);
}
