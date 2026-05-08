class NumberFormatter {
  /// Converts a number like 1200 to "1.2k" or 1500000 to "1.5m".
  /// Returns a plain string for numbers under 1000.
  static String formatSocialCount(int count) {
    if (count < 1000) return count.toString();

    double value;
    String suffix;

    if (count >= 1000000) {
      value = count / 1000000;
      suffix = 'm';
    } else {
      value = count / 1000;
      suffix = 'k';
    }

    // Convert to 1 decimal place
    String result = value.toStringAsFixed(1);

    // Clean up trailing zeros (e.g., "1.0k" -> "1k")
    if (result.endsWith('.0')) {
      result = result.substring(0, result.length - 2);
    }

    return '$result$suffix';
  }
}
