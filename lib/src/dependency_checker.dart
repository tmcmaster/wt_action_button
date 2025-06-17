import 'package:flutter_riverpod/flutter_riverpod.dart';

class DependencyChecker<T> {
  // TODO: is dependency required
  final ProviderBase<T> dependency;
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

class IsTrueDependencyChecker extends DependencyChecker<bool> {
  IsTrueDependencyChecker({
    required super.dependency,
  }) : super(predicate: (value) => value == true);
}

class IsFalseDependencyChecker extends DependencyChecker<bool> {
  IsFalseDependencyChecker({
    required super.dependency,
  }) : super(predicate: (value) => value == false);
}
