// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'لوحة تحكم الأسطورة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginCredentials => 'سجل الدخول باستخدام بياناتك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get loginError => 'بيانات الاعتماد غير صالحة. يرجى المحاولة مرة أخرى.';

  @override
  String get changeTheme => 'تغيير السمة';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get matches => 'المباريات';

  @override
  String get matchDetails => 'تفاصيل المباراة';

  @override
  String get matchTime => 'وقت المباراة';

  @override
  String get matchStatus => 'حالة المباراة';

  @override
  String get matchActions => 'إجراءات المباراة';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get add => 'إضافة';

  @override
  String get search => 'بحث';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get settings => 'الإعدادات';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get home => 'الرئيسية';

  @override
  String get away => 'الخارج';

  @override
  String get team => 'الفريق';

  @override
  String get teams => 'الفرق';

  @override
  String get player => 'اللاعب';

  @override
  String get players => 'اللاعبون';

  @override
  String get competition => 'المسابقة';

  @override
  String get competitions => 'المسابقات';

  @override
  String get channel => 'القناة';

  @override
  String get channels => 'القنوات';

  @override
  String get broadcaster => 'المذيع';

  @override
  String get broadcasters => 'المذيعون';

  @override
  String get name => 'الاسم';

  @override
  String get shortName => 'الاسم المختصر';

  @override
  String get displayName => 'اسم العرض';

  @override
  String get logo => 'الشعار';

  @override
  String get country => 'الدولة';

  @override
  String get successTitle => 'نجاح';

  @override
  String get errorTitle => 'خطأ';

  @override
  String get confirmTitle => 'تأكيد';

  @override
  String get deleteConfirmation => 'هل أنت متأكد أنك تريد حذف هذا العنصر؟';

  @override
  String get saveChangesSuccess => 'تم حفظ التغييرات بنجاح.';

  @override
  String get addSuccess => 'تمت الإضافة بنجاح.';

  @override
  String get deleteSuccess => 'تم الحذف بنجاح.';

  @override
  String get anErrorOccurred => 'حدث خطأ. يرجى المحاولة مرة أخرى.';

  @override
  String get selectCompetition => 'اختر المسابقة';

  @override
  String get selectTeam => 'اختر الفريق';

  @override
  String get selectBroadcaster => 'اختر المذيع';

  @override
  String get selectChannel => 'اختر القناة';

  @override
  String get noOptions => 'لا توجد خيارات متاحة';

  @override
  String get homeTeam => 'الفريق المضيف';

  @override
  String get awayTeam => 'الفريق الضيف';

  @override
  String get competitionConfig => 'إعدادات المسابقة';

  @override
  String get visible => 'مرئي';

  @override
  String get hidden => 'مخفي';

  @override
  String get bestPlayer => 'أفضل لاعب';

  @override
  String get summary => 'ملخص';

  @override
  String get stats => 'إحصائيات';

  @override
  String get h2h => 'مواجهات مباشرة';

  @override
  String get standings => 'الترتيب';

  @override
  String get onThePitch => 'في الملعب';

  @override
  String get onTheBench => 'على مقاعد البدلاء';

  @override
  String get confirmMOTMTitle => 'تأكيد أفضل لاعب في المباراة';

  @override
  String confirmMOTMMessage(String playerName) {
    return 'هل أنت متأكد من اختيار $playerName كأفضل لاعب في المباراة؟';
  }

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get unknownPlayer => 'لاعب غير معروف';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غداً';

  @override
  String get yesterday => 'أمس';

  @override
  String inXDays(int count) {
    return 'بعد $count أيام';
  }

  @override
  String xDaysAgo(int count) {
    return 'قبل $count أيام';
  }

  @override
  String get liveFilter => 'مباشر';

  @override
  String get sortByImportance => 'فرز حسب الأهمية';

  @override
  String get sortByTime => 'فرز حسب الوقت';

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
  String get competitionSelect => 'اختيار المسابقة';

  @override
  String get active => 'نشط';

  @override
  String get addNewCompetition => 'إضافة مسابقة جديدة';

  @override
  String get competitionId => 'معرف المسابقة';

  @override
  String get pleaseEnterCompetitionId => 'الرجاء إدخال معرف المسابقة';

  @override
  String get deleteCompetition => 'حذف المسابقة';

  @override
  String get deleteCompetitionConfirmation => 'هل أنت متأكد أنك تريد حذف إعدادات هذه المسابقة؟';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get matchesTiles => 'المباريات (مربعات)';

  @override
  String get matchesList => 'المباريات (قائمة)';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get typeToSearch => 'اكتب للبحث عن المسابقات';

  @override
  String get searchCompetition => 'بحث عن مسابقة';

  @override
  String get matchStatusAbnormal => 'غير طبيعي';

  @override
  String get matchStatusNotStarted => 'لم تبدأ';

  @override
  String get matchStatusFirstHalf => 'الشوط الأول';

  @override
  String get matchStatusHalfTime => 'استراحة';

  @override
  String get matchStatusSecondHalf => 'الشوط الثاني';

  @override
  String get matchStatusOvertime => 'وقت إضافي';

  @override
  String get matchStatusOvertimeDeprecated => 'وقت إضافي';

  @override
  String get matchStatusPenaltyShootout => 'ركلات الترجيح';

  @override
  String get matchStatusEnded => 'انتهت';

  @override
  String get matchStatusDelayed => 'مؤجلة';

  @override
  String get matchStatusInterrupted => 'متوقفة';

  @override
  String get matchStatusCutInHalf => 'مقطوعة';

  @override
  String get matchStatusCancelled => 'ملغاة';

  @override
  String get matchStatusTBD => 'سيتم تحديدها';

  @override
  String get matchStatusUnknown => 'غير معروف';
}
