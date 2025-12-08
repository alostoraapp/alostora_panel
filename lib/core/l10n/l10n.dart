import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../constants/app_icons.dart';

// A helper class to easily access the AppLocalizations
// This allows you to call S.of(context).login instead of AppLocalizations.of(context)!.login
class S {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}

class L10n {
  static final all = [
    const Locale('en'), // English (LTR)
    const Locale('fa'), // Persian (RTL)
    const Locale('ar'), // Arabic (RTL)
  ];

  static String? getFlagPath(String code) {
    switch (code) {
      case 'en':
        return AppIcons.flagUK;
      case 'fa':
        return AppIcons.flagIR;
      case 'ar':
        return AppIcons.flagSA;
      default:
        return null;
    }
  }

  static bool isRTL(Locale locale) {
    return ['fa', 'ar'].contains(locale.languageCode);
  }
}
