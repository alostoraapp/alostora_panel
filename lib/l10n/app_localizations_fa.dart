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
  String get login => 'ورود';

  @override
  String get loginCredentials => 'با اطلاعات کاربری خود وارد شوید';

  @override
  String get email => 'ایمیل';

  @override
  String get emailHint => 'ایمیل خود را وارد کنید';

  @override
  String get password => 'رمز عبور';

  @override
  String get passwordHint => 'رمز عبور خود را وارد کنید';

  @override
  String get loginError => 'اطلاعات کاربری نامعتبر است. لطفا دوباره تلاش کنید.';

  @override
  String get changeTheme => 'تغییر پوسته';

  @override
  String get changeLanguage => 'تغییر زبان';

  @override
  String get matches => 'مسابقات';

  @override
  String get matchDetails => 'جزئیات بازی';

  @override
  String get matchTime => 'زمان بازی';

  @override
  String get matchStatus => 'وضعیت بازی';

  @override
  String get matchActions => 'عملیات';

  @override
  String get save => 'ذخیره';

  @override
  String get cancel => 'لغو';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'ویرایش';

  @override
  String get add => 'افزودن';

  @override
  String get search => 'جستجو';

  @override
  String get logout => 'خروج';

  @override
  String get settings => 'تنظیمات';

  @override
  String get dashboard => 'داشبورد';

  @override
  String get home => 'خانه';

  @override
  String get away => 'مهمان';

  @override
  String get team => 'تیم';

  @override
  String get teams => 'تیم‌ها';

  @override
  String get player => 'بازیکن';

  @override
  String get players => 'بازیکنان';

  @override
  String get competition => 'رقابت';

  @override
  String get competitions => 'رقابت‌ها';

  @override
  String get channel => 'کانال';

  @override
  String get channels => 'کانال‌ها';

  @override
  String get broadcaster => 'پخش‌کننده';

  @override
  String get broadcasters => 'پخش‌کنندگان';

  @override
  String get name => 'نام';

  @override
  String get shortName => 'نام کوتاه';

  @override
  String get displayName => 'نام نمایشی';

  @override
  String get logo => 'لوگو';

  @override
  String get country => 'کشور';

  @override
  String get successTitle => 'موفقیت';

  @override
  String get errorTitle => 'خطا';

  @override
  String get confirmTitle => 'تایید';

  @override
  String get deleteConfirmation => 'آیا از حذف این مورد اطمینان دارید؟';

  @override
  String get saveChangesSuccess => 'تغییرات با موفقیت ذخیره شد.';

  @override
  String get addSuccess => 'با موفقیت اضافه شد.';

  @override
  String get deleteSuccess => 'با موفقیت حذف شد.';

  @override
  String get anErrorOccurred => 'خطایی رخ داد. لطفا دوباره تلاش کنید.';

  @override
  String get selectCompetition => 'انتخاب رقابت';

  @override
  String get selectTeam => 'انتخاب تیم';

  @override
  String get selectBroadcaster => 'انتخاب پخش‌کننده';

  @override
  String get selectChannel => 'انتخاب کانال';

  @override
  String get noOptions => 'گزینه‌ای در دسترس نیست';

  @override
  String get homeTeam => 'تیم میزبان';

  @override
  String get awayTeam => 'تیم مهمان';

  @override
  String get competitionConfig => 'پیکربندی رقابت';

  @override
  String get visible => 'قابل مشاهده';

  @override
  String get hidden => 'مخفی';

  @override
  String get bestPlayer => 'بهترین بازیکن';

  @override
  String get summary => 'خلاصه';

  @override
  String get stats => 'آمار';

  @override
  String get h2h => 'رو در رو';

  @override
  String get standings => 'جدول رده‌بندی';

  @override
  String get onThePitch => 'در زمین';

  @override
  String get onTheBench => 'روی نیمکت';

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
  String get unknownPlayer => 'بازیکن ناشناس';

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
  String get sortByImportance => 'مرتب‌سازی بر اساس اهمیت';

  @override
  String get sortByTime => 'مرتب‌سازی بر اساس زمان';

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
  String get competitionSelect => 'انتخاب رقابت';

  @override
  String get active => 'فعال';

  @override
  String get addNewCompetition => 'افزودن رقابت جدید';

  @override
  String get competitionId => 'شناسه رقابت';

  @override
  String get pleaseEnterCompetitionId => 'لطفا شناسه رقابت را وارد کنید';

  @override
  String get deleteCompetition => 'حذف رقابت';

  @override
  String get deleteCompetitionConfirmation => 'آیا از حذف این پیکربندی رقابت اطمینان دارید؟';

  @override
  String get overview => 'نمای کلی';

  @override
  String get matchesTiles => 'مسابقات (کاشی)';

  @override
  String get matchesList => 'مسابقات (لیست)';

  @override
  String get noResultsFound => 'نتیجه‌ای یافت نشد';

  @override
  String get typeToSearch => 'برای جستجوی رقابت‌ها تایپ کنید';

  @override
  String get searchCompetition => 'جستجوی رقابت';

  @override
  String get matchStatusAbnormal => 'غیرطبیعی';

  @override
  String get matchStatusNotStarted => 'شروع نشده';

  @override
  String get matchStatusFirstHalf => 'نیمه ۱';

  @override
  String get matchStatusHalfTime => 'بین دو نیمه';

  @override
  String get matchStatusSecondHalf => 'نیمه ۲';

  @override
  String get matchStatusOvertime => 'و.ا';

  @override
  String get matchStatusOvertimeDeprecated => 'و.ا';

  @override
  String get matchStatusPenaltyShootout => 'پنالتی';

  @override
  String get matchStatusEnded => 'پایان';

  @override
  String get matchStatusDelayed => 'تاخیر';

  @override
  String get matchStatusInterrupted => 'متوقف';

  @override
  String get matchStatusCutInHalf => 'نیمه تمام';

  @override
  String get matchStatusCancelled => 'لغو';

  @override
  String get matchStatusTBD => 'نامشخص';

  @override
  String get matchStatusUnknown => 'نامشخص';

  @override
  String get highlights => 'خلاصه بازی';

  @override
  String get events => 'رویدادها';

  @override
  String get media => 'رسانه';

  @override
  String get details => 'جزئیات';

  @override
  String get kickOff => 'شروع بازی';

  @override
  String get halfTimeScore => 'نیمه اول';

  @override
  String get fullTimeScore => 'پایان بازی';

  @override
  String get extraTimeScore => 'وقت اضافه';

  @override
  String get penaltyShootoutScore => 'پنالتی';

  @override
  String get ownGoal => 'گل به خودی';

  @override
  String get penaltyMissed => 'پنالتی از دست رفته';

  @override
  String get varCheck => 'بررسی VAR';

  @override
  String get substitution => 'تعویض';

  @override
  String get noDataFound => 'داده‌ای یافت نشد';

  @override
  String get penalties => 'Penalties';

  @override
  String get overtime => 'Overtime';

  @override
  String get secondHalf => 'Second Half';

  @override
  String get firstHalf => 'First Half';
}
