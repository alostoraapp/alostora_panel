import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'), // English (LTR)
    const Locale('fa'), // Persian (RTL)
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'fa':
        return '🇮🇷';
      default:
        return '🇺🇳';
    }
  }

  static bool isRTL(Locale locale) {
    return locale.languageCode == 'fa';
  }
}