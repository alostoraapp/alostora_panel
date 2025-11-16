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

  void toggleLanguage() {
    if (state == L10n.all.first) {
      emit(L10n.all.last);
    } else {
      emit(L10n.all.first);
    }
  }

  bool isRTL() {
    return L10n.isRTL(state);
  }
}