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
  String get competitionSelect => 'انتخاب رقابت‌ها';

  @override
  String get active => 'فعال';

  @override
  String get inactive => 'غیرفعال';

  @override
  String get saveOrder => 'ذخیره ترتیب';

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
  String get matchStatusAbnormal => 'غ‌ط';

  @override
  String get matchStatusNotStarted => 'ش‌ن';

  @override
  String get matchStatusFirstHalf => 'ن1';

  @override
  String get matchStatusHalfTime => 'ب‌د‌ن';

  @override
  String get matchStatusSecondHalf => 'ن2';

  @override
  String get matchStatusOvertime => 'و‌ا';

  @override
  String get matchStatusOvertimeDeprecated => 'و‌ا';

  @override
  String get matchStatusPenaltyShootout => 'پ';

  @override
  String get matchStatusEnded => 'پایان';

  @override
  String get matchStatusDelayed => 'تاخیر';

  @override
  String get matchStatusInterrupted => 'توقف';

  @override
  String get matchStatusCutInHalf => 'قطع';

  @override
  String get matchStatusCancelled => 'لغو';

  @override
  String get matchStatusTbd => 'نامشخص';

  @override
  String get matchStatusUnknown => '؟';

  @override
  String get addNewCompetition => 'افزودن رقابت جدید';

  @override
  String get enterCompetitionId => 'شناسه رقابت را وارد کنید';

  @override
  String get pleaseEnterCompetitionId => 'لطفاً شناسه رقابت را وارد کنید';

  @override
  String get competitionId => 'شناسه رقابت';

  @override
  String get add => 'افزودن';

  @override
  String get cancel => 'لغو';

  @override
  String get save => 'ذخیره';

  @override
  String get noResultsFound => 'نتیجه‌ای یافت نشد';

  @override
  String get typeToSearch => 'برای جستجو تایپ کنید...';

  @override
  String get searchCompetition => 'جستجوی رقابت';
}
