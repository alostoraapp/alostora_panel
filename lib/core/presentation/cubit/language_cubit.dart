import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/l10n.dart';
import '../../services/api_client.dart';

class LanguageCubit extends Cubit<Locale> {
  final ApiClient _apiClient;
  static const String _languageKey = 'selected_language';

  LanguageCubit(this._apiClient) : super(L10n.all.first) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey);

    if (languageCode != null) {
      final locale = Locale(languageCode);
      if (L10n.all.contains(locale)) {
        emit(locale);
        _updateApiLanguage(locale);
        return;
      }
    }
    _updateApiLanguage(state);
  }

  Future<void> setLanguage(Locale locale) async {
    if (L10n.all.contains(locale)) {
      emit(locale);
      _updateApiLanguage(locale);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, locale.languageCode);
    }
  }

  void _updateApiLanguage(Locale locale) {
    _apiClient.updateLanguage(locale.languageCode);
  }

  bool isRTL() {
    return L10n.isRTL(state);
  }
}
