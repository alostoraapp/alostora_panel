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
  String get competitionSelect => 'اختيار المسابقات';

  @override
  String get active => 'نشط';

  @override
  String get inactive => 'غير نشط';

  @override
  String get saveOrder => 'حفظ الترتيب';

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

  @override
  String get sortByImportance => 'الأهمية';

  @override
  String get sortByTime => 'الوقت';

  @override
  String get liveFilter => 'مباشر';

  @override
  String get matchStatusAbnormal => 'غ.ط';

  @override
  String get matchStatusNotStarted => 'ل.ت';

  @override
  String get matchStatusFirstHalf => 'ش1';

  @override
  String get matchStatusHalfTime => 'إست';

  @override
  String get matchStatusSecondHalf => 'ش2';

  @override
  String get matchStatusOvertime => 'و.إ';

  @override
  String get matchStatusOvertimeDeprecated => 'و.إ';

  @override
  String get matchStatusPenaltyShootout => 'ر.ت';

  @override
  String get matchStatusEnded => 'انتهت';

  @override
  String get matchStatusDelayed => 'مؤج';

  @override
  String get matchStatusInterrupted => 'توق';

  @override
  String get matchStatusCutInHalf => 'انق';

  @override
  String get matchStatusCancelled => 'ألغ';

  @override
  String get matchStatusTbd => 'غ.م';

  @override
  String get matchStatusUnknown => '؟';

  @override
  String get addNewCompetition => 'إضافة مسابقة جديدة';

  @override
  String get enterCompetitionId => 'أدخل معرف المسابقة';

  @override
  String get pleaseEnterCompetitionId => 'يرجى إدخال معرف المسابقة';

  @override
  String get competitionId => 'معرف المسابقة';

  @override
  String get add => 'إضافة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get typeToSearch => 'اكتب للبحث...';

  @override
  String get searchCompetition => 'بحث عن مسابقة';

  @override
  String get deleteCompetition => 'حذف المسابقة';

  @override
  String get deleteCompetitionConfirmation => 'هل أنت متأكد أنك تريد حذف هذه المسابقة؟';

  @override
  String get delete => 'حذف';
}
