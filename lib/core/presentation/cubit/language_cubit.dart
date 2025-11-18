import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/l10n.dart';

class LanguageCubit extends Cubit<Locale> {
  // Default language is English
  LanguageCubit() : super(L10n.all.first);

  void setLanguage(Locale locale) {
    if (L10n.all.contains(locale)) {
      emit(locale);
    }
  }

  bool isRTL() {
    return L10n.isRTL(state);
  }
}
