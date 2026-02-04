class JsonHelper {
  static double doubleVal(dynamic value, {double fallback = 0.0}) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? fallback;
    return fallback;
  }

  static int intVal(dynamic v, {int fallback = 0}) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }

  static String stringVal(dynamic v, {String fallback = ''}) =>
      v?.toString() ?? fallback;

  static bool boolVal(dynamic v, {bool fallback = false}) {
    if (v is bool) return v;
    if (v is String) return v.toLowerCase() == 'true';
    if (v is num) return v == 1;
    return fallback;
  }

  /// 🔒 Safe Date parser
  static DateTime? parseDate(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
