extension ListExtension<T> on List<T> {
  T get firstOrNull => isEmpty ? null : first;

  /// removes [start] items from the start of the list
  /// and [end] items from the end of it
  List<T> drop(int start, [int end = 0]) =>
      toList()..removeRange(0, start)..removeRange(length - end, length);
}
