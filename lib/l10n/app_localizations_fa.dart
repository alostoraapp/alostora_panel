// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'پنل ادمین الاسطوره';

  @override
  String get login => 'ورود';

  @override
  String get logout => 'خروج';

  @override
  String get home => 'داشبورد';

  @override
  String get welcome => 'خوش آمدید، ادمین!';

  @override
  String get changeTheme => 'تغییر تم';

  @override
  String get changeLanguage => 'تغییر زبان';

  @override
  String get email => 'ایمیل';

  @override
  String get password => 'رمز عبور';

  @override
  String get emailHint => 'آدرس ایمیل خود را وارد کنید';

  @override
  String get passwordHint => 'رمز عبور خود را وارد کنید';

  @override
  String get loginCredentials => 'با اطلاعات کاربری خود وارد شوید';
}
