// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'لوحة الإدارة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get home => 'لوحة التحكم';

  @override
  String get welcome => 'أهلاً بك يا مسؤول!';

  @override
  String get changeTheme => 'تغيير السمة';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get emailHint => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get passwordHint => 'ادخل كلمة المرور الخاصة بك';

  @override
  String get loginCredentials => 'تسجيل الدخول باستخدام بيانات الاعتماد الخاصة بك';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get settings => 'الإعدادات';

  @override
  String get totalUsers => 'إجمالي المستخدمين';

  @override
  String get onlineUsers => 'المستخدمون المتصلون';

  @override
  String get todaysMatches => 'مباريات اليوم';

  @override
  String get liveMatches => 'المباريات المباشرة';

  @override
  String get tomorrowsMatches => 'مباريات الغد';

  @override
  String get thisWeeksMatches => 'مباريات هذا الأسبوع';

  @override
  String get loginError => 'فشل تسجيل الدخول. يرجى التحقق من بيانات الاعتماد الخاصة بك.';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get matches => 'المباريات';

  @override
  String get matchesTiles => 'عرض البلاط';

  @override
  String get matchesList => 'قائمة المباريات';

  @override
  String get live => 'مباشر';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غدا';

  @override
  String get yesterday => 'في الامس';

  @override
  String inXDays(Object count) {
    return 'في $count أيام';
  }

  @override
  String xDaysAgo(Object count) {
    return 'قبل $count أيام';
  }

  @override
  String get calendar => 'التقويم';

  @override
  String get search => 'بحث';
}
