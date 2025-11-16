import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

// A helper class to easily access the AppLocalizations
// This allows you to call S.of(context).login instead of AppLocalizations.of(context)!.login
class S {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}