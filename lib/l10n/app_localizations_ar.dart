// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get selectMatchToViewDetails => 'اختر مباراة لعرض التفاصيل';

  @override
  String get appName => 'لوحة تحكم الأسطورة';

  @override
  String get changeTheme => 'تغيير المظهر';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginError => 'فشل تسجيل الدخول. يرجى التحقق من بياناتك.';

  @override
  String get loginCredentials => 'أدخل بياناتك لتسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get overview => 'نظرة عامة';

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
  String get matches => 'المباريات';

  @override
  String get matchesTiles => 'المباريات (مربعات)';

  @override
  String get matchesList => 'المباريات (قائمة)';

  @override
  String get settings => 'الإعدادات';

  @override
  String get competitionSelect => 'اختيار المسابقات';

  @override
  String get active => 'نشط';

  @override
  String get addNewCompetition => 'إضافة مسابقة جديدة';

  @override
  String get competitionId => 'معرف المسابقة';

  @override
  String get pleaseEnterCompetitionId => 'يرجى إدخال معرف المسابقة';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get deleteCompetition => 'حذف المسابقة';

  @override
  String get deleteCompetitionConfirmation => 'هل أنت متأكد أنك تريد حذف هذه المسابقة؟';

  @override
  String get searchCompetition => 'ابحث عن مسابقة';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get typeToSearch => 'اكتب للبحث';

  @override
  String get matchStatusAbnormal => 'غير طبيعي';

  @override
  String get matchStatusNotStarted => 'لم تبدأ';

  @override
  String get matchStatusFirstHalf => 'الشوط الأول';

  @override
  String get matchStatusHalfTime => 'بين الشوطين';

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
  String get matchStatusTBD => 'لم تحدد';

  @override
  String get matchStatusUnknown => 'حالة غير معروفة';

  @override
  String get bestPlayer => 'أفضل لاعب';

  @override
  String get highlights => 'الأهداف';

  @override
  String get events => 'الأحداث';

  @override
  String get live => 'مباشر';

  @override
  String get details => 'التفاصيل';

  @override
  String get onThePitch => 'في الملعب';

  @override
  String get onTheBench => 'على الدكة';

  @override
  String get unknownPlayer => 'لاعب غير معروف';

  @override
  String get confirmMOTMTitle => 'تأكيد رجل المباراة';

  @override
  String confirmMOTMMessage(String playerName) {
    return 'هل أنت متأكد أنك تريد تعيين $playerName كرجل المباراة؟';
  }

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get noDataFound => 'لا توجد بيانات';

  @override
  String get penalties => 'ركلات الترجيح';

  @override
  String get overtime => 'وقت إضافي';

  @override
  String get secondHalf => 'الشوط الثاني';

  @override
  String get firstHalf => 'الشوط الأول';

  @override
  String get ownGoal => '(هدف ذاتي)';

  @override
  String get penaltyMissed => '(ركلة جزاء ضائعة)';

  @override
  String get varCheck => 'فحص VAR';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غداً';

  @override
  String get yesterday => 'أمس';

  @override
  String inXDays(int count) {
    return 'خلال $count أيام';
  }

  @override
  String xDaysAgo(int count) {
    return 'قبل $count أيام';
  }

  @override
  String get liveFilter => 'مباشر';

  @override
  String get search => 'بحث...';

  @override
  String get sortByImportance => 'ترتيب حسب الأهمية';

  @override
  String get sortByTime => 'ترتيب حسب الوقت';

  @override
  String get noMatchesFound => 'لم يتم العثور على مباريات';

  @override
  String get importantEvents => 'المهمة';

  @override
  String get refresh => 'تحديث';

  @override
  String get mediaUrl => 'رابط الوسائط';

  @override
  String get mediaCover => 'صورة الغلاف';

  @override
  String get videoTime => 'وقت الفيديو (ثواني)';

  @override
  String get editIncidentMedia => 'تعديل وسائط الحدث';

  @override
  String get sendNotification => 'إرسال إشعار';

  @override
  String get sendNotificationSubtitle => 'إذا تم التفعيل، سيتم تعيين الأولوية إلى عاجل.';

  @override
  String get approve => 'موافقة';

  @override
  String get incidentApproved => 'تمت الموافقة على الحدث';

  @override
  String get requestSent => 'تم إرسال الطلب';

  @override
  String get highlightTypeSummary => 'ملخص';

  @override
  String get highlightTypeGoals => 'أهداف';

  @override
  String get highlightTypeFullMatch => 'مباراة كاملة';

  @override
  String get highlightTypePenalties => 'ركلات ترجيح';

  @override
  String get highlightTypeCelebration => 'احتفال';

  @override
  String get highlightTypeOther => 'أخرى';

  @override
  String get highlightStatusDraft => 'مسودة';

  @override
  String get highlightStatusPendingApproval => 'بانتظار الموافقة';

  @override
  String get highlightStatusPublished => 'منشور';

  @override
  String get highlightPriorityNormal => 'عادي';

  @override
  String get highlightPriorityImportant => 'مهم (بدون إشعار)';

  @override
  String get highlightPriorityUrgent => 'عاجل (مع إشعار)';

  @override
  String get highlightType => 'النوع';

  @override
  String get highlightPriority => 'الأولوية';

  @override
  String get highlightStatus => 'الحالة';

  @override
  String errorPickingImage(String error) {
    return 'خطأ في اختيار الصورة: $error';
  }

  @override
  String error(String error) {
    return 'خطأ: $error';
  }

  @override
  String get hours => 'ساعات';

  @override
  String get minutes => 'دقائق';

  @override
  String get seconds => 'ثواني';

  @override
  String get addMedia => 'إضافة وسائط';

  @override
  String get editMedia => 'تعديل الوسائط';

  @override
  String get lineup => 'التشكيلة';

  @override
  String get matchDetails => 'تفاصيل المباراة';

  @override
  String get platformYouTube => 'يوتيوب';

  @override
  String get platformX => 'إكس (تويتر)';

  @override
  String get platformFacebook => 'فيسبوك';

  @override
  String get platformOfficial => 'الموقع الرسمي';

  @override
  String get platformOther => 'أخرى';

  @override
  String get addBroadcast => 'إضافة بث';

  @override
  String get editBroadcast => 'تعديل البث';

  @override
  String get platform => 'المنصة';

  @override
  String get tvChannel => 'القناة التلفزيونية';

  @override
  String get url => 'الرابط';

  @override
  String get pleaseSelectTvChannel => 'يرجى اختيار قناة تلفزيونية';

  @override
  String get pleaseSelectPlatform => 'يرجى اختيار منصة';

  @override
  String get pleaseEnterUrl => 'يرجى إدخال الرابط';

  @override
  String get deleteBroadcast => 'حذف البث';

  @override
  String get deleteBroadcastConfirmation => 'هل أنت متأكد أنك تريد حذف هذا البث؟';

  @override
  String get tvChannels => 'القنوات التلفزيونية';

  @override
  String get commentators => 'المعلقين';

  @override
  String get deleteTvChannel => 'حذف القناة';

  @override
  String get deleteTvChannelConfirmation => 'هل أنت متأكد أنك تريد حذف هذه القناة؟';

  @override
  String get deleteCommentator => 'حذف المعلق';

  @override
  String get deleteCommentatorConfirmation => 'هل أنت متأكد أنك تريد حذف هذا المعلق؟';
}
