// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'پنل الأسطورة';

  @override
  String get changeTheme => 'تغییر پوسته';

  @override
  String get changeLanguage => 'تغییر زبان';

  @override
  String get login => 'ورود';

  @override
  String get loginError => 'ورود ناموفق بود. لطفاً اطلاعات خود را بررسی کنید.';

  @override
  String get loginCredentials => 'برای ورود اطلاعات خود را وارد کنید';

  @override
  String get email => 'ایمیل';

  @override
  String get emailHint => 'ایمیل خود را وارد کنید';

  @override
  String get password => 'رمز عبور';

  @override
  String get passwordHint => 'رمز عبور خود را وارد کنید';

  @override
  String get logout => 'خروج';

  @override
  String get dashboard => 'داشبورد';

  @override
  String get overview => 'نمای کلی';

  @override
  String get totalUsers => 'کل کاربران';

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
  String get matches => 'مسابقات';

  @override
  String get matchesTiles => 'مسابقات (کاشی)';

  @override
  String get matchesList => 'مسابقات (لیست)';

  @override
  String get settings => 'تنظیمات';

  @override
  String get competitionSelect => 'انتخاب رقابت‌ها';

  @override
  String get active => 'فعال';

  @override
  String get addNewCompetition => 'افزودن رقابت جدید';

  @override
  String get competitionId => 'شناسه رقابت';

  @override
  String get pleaseEnterCompetitionId => 'لطفاً شناسه رقابت را وارد کنید';

  @override
  String get save => 'ذخیره';

  @override
  String get cancel => 'لغو';

  @override
  String get delete => 'حذف';

  @override
  String get deleteCompetition => 'حذف رقابت';

  @override
  String get deleteCompetitionConfirmation => 'آیا از حذف این رقابت اطمینان دارید؟';

  @override
  String get searchCompetition => 'جستجوی یک رقابت';

  @override
  String get noResultsFound => 'نتیجه‌ای یافت نشد';

  @override
  String get typeToSearch => 'برای جستجو تایپ کنید';

  @override
  String get matchStatusAbnormal => 'غیرعادی';

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
  String get matchStatusOvertimeDeprecated => 'وقت اضافه';

  @override
  String get matchStatusPenaltyShootout => 'ضربات پنالتی';

  @override
  String get matchStatusEnded => 'پایان یافته';

  @override
  String get matchStatusDelayed => 'با تاخیر';

  @override
  String get matchStatusInterrupted => 'متوقف شده';

  @override
  String get matchStatusCutInHalf => 'نیمه تمام';

  @override
  String get matchStatusCancelled => 'لغو شده';

  @override
  String get matchStatusTBD => 'نامشخص';

  @override
  String get matchStatusUnknown => 'وضعیت نامشخص';

  @override
  String get bestPlayer => 'بهترین بازیکن';

  @override
  String get highlights => 'خلاصه بازی';

  @override
  String get events => 'رویدادها';

  @override
  String get live => 'زنده';

  @override
  String get details => 'جزئیات';

  @override
  String get onThePitch => 'در زمین';

  @override
  String get onTheBench => 'روی نیمکت';

  @override
  String get unknownPlayer => 'بازیکن نامشخص';

  @override
  String get confirmMOTMTitle => 'تایید بهترین بازیکن زمین';

  @override
  String confirmMOTMMessage(String playerName) {
    return 'آیا مطمئن هستید که می‌خواهید $playerName را به عنوان بهترین بازیکن زمین انتخاب کنید؟';
  }

  @override
  String get yes => 'بله';

  @override
  String get no => 'خیر';

  @override
  String get noDataFound => 'داده‌ای یافت نشد';

  @override
  String get penalties => 'پنالتی‌ها';

  @override
  String get overtime => 'وقت اضافه';

  @override
  String get secondHalf => 'نیمه دوم';

  @override
  String get firstHalf => 'نیمه اول';

  @override
  String get ownGoal => '(گل به خودی)';

  @override
  String get penaltyMissed => '(پنالتی از دست رفته)';

  @override
  String get varCheck => 'بررسی VAR';

  @override
  String get today => 'امروز';

  @override
  String get tomorrow => 'فردا';

  @override
  String get yesterday => 'دیروز';

  @override
  String inXDays(int count) {
    return '$count روز دیگر';
  }

  @override
  String xDaysAgo(int count) {
    return '$count روز پیش';
  }

  @override
  String get liveFilter => 'زنده';

  @override
  String get search => 'جستجو...';

  @override
  String get sortByImportance => 'مرتب‌سازی بر اساس اهمیت';

  @override
  String get sortByTime => 'مرتب‌سازی بر اساس زمان';

  @override
  String get noMatchesFound => 'هیچ مسابقه‌ای یافت نشد';

  @override
  String get importantEvents => 'مهم ها';

  @override
  String get refresh => 'بازخوانی';

  @override
  String get mediaUrl => 'آدرس رسانه';

  @override
  String get mediaCover => 'تصویر کاور';

  @override
  String get videoTime => 'زمان ویدیو (ثانیه)';

  @override
  String get editIncidentMedia => 'ویرایش رسانه رویداد';

  @override
  String get sendNotification => 'ارسال اعلان';

  @override
  String get sendNotificationSubtitle => 'در صورت فعال بودن، اولویت روی فوری تنظیم می‌شود.';

  @override
  String get approve => 'تایید';

  @override
  String get incidentApproved => 'رویداد تایید شد';

  @override
  String get requestSent => 'درخواست ارسال شد';

  @override
  String errorPickingImage(String error) {
    return 'خطا در انتخاب تصویر: $error';
  }

  @override
  String error(String error) {
    return 'خطا: $error';
  }

  @override
  String get hours => 'ساعت';

  @override
  String get minutes => 'دقیقه';

  @override
  String get seconds => 'ثانیه';
}
