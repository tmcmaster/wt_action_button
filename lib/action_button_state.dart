class ActionButtonState {
  final int total;
  final int completed;
  final String currentItem;
  final List<String> errors;

  ActionButtonState({
    required this.total,
    required this.completed,
    required this.currentItem,
    this.errors = const [],
  });

  double get percentage => total == 0 ? 100 : completed / total;
  bool get done => total == completed;
  bool get hasErrors => errors.isNotEmpty;
}
