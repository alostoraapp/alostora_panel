import '../presentation/cubit/language_cubit.dart';
import '../../injection_container.dart';

class JsonHelper {
  /// Returns a localized string from a value that can be a String or a Translation Map.
  /// Calls sl<LanguageCubit>() to get current locale dynamically.
  static String localized(dynamic val, [String defaultVal = '']) {
    if (val == null) return defaultVal;
    if (val is String) return val;
    if (val is Map) {
      final languageCode = sl<LanguageCubit>().state.languageCode;
      return (val[languageCode] ?? val['en'] ?? val['ar'] ?? val.values.firstOrNull ?? '').toString();
    }
    return val.toString();
  }
}
