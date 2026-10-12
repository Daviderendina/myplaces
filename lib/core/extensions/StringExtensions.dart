extension StringExtensions on String {
  String toTitleCase() {
    if (isEmpty) return this;

    final words = trim().split(RegExp(r'\s+'));

    return words
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }
}
