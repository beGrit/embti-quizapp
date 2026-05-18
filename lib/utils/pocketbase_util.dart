class PocketBaseUtils {
  /// Hoists everything inside 'expand' to the root level of the map
  static Map<String, dynamic> flattenExpand(Map<String, dynamic> json) {
    final hoistedJson = Map<String, dynamic>.from(json);

    if (hoistedJson.containsKey('expand') && hoistedJson['expand'] is Map) {
      final expand = hoistedJson['expand'] as Map<String, dynamic>;

      expand.forEach((key, value) {
        hoistedJson[key] = value;
      });
    }

    return hoistedJson;
  }

  static List<Map<String, dynamic>> flattenList(List<dynamic> items) {
    return items
        .map(
          (item) => flattenExpand(
            item is Map<String, dynamic> ? item : item.toJson(),
          ),
        )
        .toList();
  }
}
