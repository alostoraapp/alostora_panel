// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'پنل ادمین';

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

  @override
  String get dashboard => 'داشبورد';

  @override
  String get settings => 'تنظیمات';

  @override
  String get totalUsers => 'تعداد کل کاربران';

  @override
  String get onlineUsers => 'کاربران آنلاین';

  @override
  String get todaysMatches => 'مسابقات امروز';

  @override
  String get liveMatches => 'مسابقات زنده';

  @override
  String get tomorrowsMatches => 'مسابقات فردا';

  @override
  String get thisWeeksMatches => 'مسابقات این هفته';

  @override
  String get loginError => 'ورود ناموفق بود. لطفا اطلاعات خود را بررسی کنید.';

  @override
  String get overview => 'بررسی اجمالی';

  @override
  String get matches => 'مسابقات';

  @override
  String get matchesTiles => 'نمای تایل';

  @override
  String get matchesList => 'لیست مسابقات';

  @override
  String get live => 'زنده';

  @override
  String get today => 'امروز';

  @override
  String get tomorrow => 'فردا';

  @override
  String get yesterday => 'دیروز';

  @override
  String inXDays(Object count) {
    return 'در $count روز آینده';
  }

  @override
  String xDaysAgo(Object count) {
    return '$count روز قبل';
  }

  @override
  String get calendar => 'تقویم';

  @override
  String get search => 'جستجو';

  @override
  String get sortByImportance => 'اهمیت';

  @override
  String get sortByTime => 'زمان';

  @override
  String get liveFilter => 'زنده';

  @override
  String get matchStatusAbnormal => 'غیر عادی';

  @override
  String get matchStatusNotStarted => 'شروع نشده';

  @override
  String get matchStatusFirstHalf => 'نیمه اول';

  @override
  String get matchStatusHalfTime => 'بین دو نیمه';

  @override
  String get matchStatusSecondHalf => 'نیمه دوم';

  @override
  String get matchStatusOvertime => 'وقت اضافه';

  @override
  String get matchStatusOvertimeDeprecated => 'وقت اضافه (منسوخ)';

  @override
  String get matchStatusPenaltyShootout => 'ضربات پنالتی';

  @override
  String get matchStatusEnded => 'پایان یافته';

  @override
  String get matchStatusDelayed => 'با تاخیر';

  @override
  String get matchStatusInterrupted => 'متوقف شده';

  @override
  String get matchStatusCutInHalf => 'قطع شده';

  @override
  String get matchStatusCancelled => 'لغو شده';

  @override
  String get matchStatusTbd => 'نامشخص';

  @override
  String get matchStatusUnknown => 'ناشناخته';
}
