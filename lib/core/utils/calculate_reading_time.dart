int calculateReadingTime(String content) {
  final List<String> wordCount = content.split(RegExp(r'\s+'));
  final int readingTime = wordCount.length ~/ 225;

  return readingTime;
}
