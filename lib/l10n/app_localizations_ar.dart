// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get alostora => 'الأسطورة';

  @override
  String get appName => 'لوحة تحكم الأسطورة';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get matches => 'المباريات';

  @override
  String get match => 'مباراة';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get search => 'بحث';

  @override
  String get searchHint => 'البحث عن فرق، دوريات، أو مباريات...';

  @override
  String get live => 'مباشر';

  @override
  String get upcoming => 'قادم';

  @override
  String get finished => 'منتهية';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get tomorrow => 'غداً';

  @override
  String get noMatchesToday => 'لا توجد مباريات مجدولة لهذا اليوم.';

  @override
  String get noMatchesYesterday => 'لم تُلعب أي مباريات يوم أمس.';

  @override
  String get noMatchesTomorrow => 'لا توجد مباريات مجدولة ليوم غد.';

  @override
  String get noLiveMatches => 'لا توجد مباريات مباشرة في الوقت الحالي.';

  @override
  String get noUpcomingMatches => 'لا توجد مباريات قادمة في التاريخ المحدد.';

  @override
  String get noFinishedMatches => 'لم تنتهِ أي مباريات في التاريخ المحدد.';

  @override
  String get failedToLoadMatches => 'فشل تحميل المباريات.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get leagues => 'الدوريات';

  @override
  String get matchDetail => 'تفاصيل المباراة';

  @override
  String get summary => 'ملخص';

  @override
  String get lineUp => 'التشكيلة';

  @override
  String get stats => 'إحصائيات';

  @override
  String get h2h => 'مواجهات مباشرة';

  @override
  String get standings => 'الترتيب';

  @override
  String get chat => 'دردشة';

  @override
  String get odds => 'الاحتمالات';

  @override
  String get about => 'حول';

  @override
  String get incidents => 'الأحداث';

  @override
  String get referee => 'الحكم';

  @override
  String get stadium => 'الملعب';

  @override
  String get capacity => 'السعة';

  @override
  String get shakingHands => 'مصافحة';

  @override
  String get heads => 'وجه';

  @override
  String get tails => 'ظهر';

  @override
  String get selectCoin => 'اختر عملة';

  @override
  String get toss => 'رمي';

  @override
  String get home => 'المضيف';

  @override
  String get away => 'الضيف';

  @override
  String get bestPlayer => 'أفضل لاعب';

  @override
  String get onThePitch => 'في الملعب';

  @override
  String get onTheBench => 'على الدكة';

  @override
  String get highlights => 'الأهداف';

  @override
  String get events => 'الأحداث';

  @override
  String get media => 'وسائط';

  @override
  String get details => 'تفاصيل';

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
  String get changeTheme => 'تغيير السمة';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get logout => 'تسجيل الخروج';

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
  String get matchesTiles => 'بطاقات المباريات';

  @override
  String get matchesList => 'قائمة المباريات';

  @override
  String get addNewCompetition => 'إضافة مسابقة جديدة';

  @override
  String get competitionId => 'معرف المسابقة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get pleaseEnterCompetitionId => 'يرجى إدخال معرف المسابقة';

  @override
  String get deleteCompetition => 'حذف المسابقة';

  @override
  String get deleteCompetitionConfirmation => 'هل أنت متأكد أنك تريد حذف هذه المسابقة؟';

  @override
  String get delete => 'حذف';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get typeToSearch => 'اكتب للبحث عن المسابقات';

  @override
  String get searchCompetition => 'بحث عن مسابقة';

  @override
  String inXDays(int days) {
    return 'خلال $days أيام';
  }

  @override
  String xDaysAgo(int days) {
    return 'قبل $days أيام';
  }

  @override
  String get liveFilter => 'مباشر';

  @override
  String get sortByImportance => 'فرز حسب الأهمية';

  @override
  String get sortByTime => 'فرز حسب الوقت';

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
  String get matchStatusOvertimeDeprecated => 'وقت إضافي (مهمل)';

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

  @override
  String get weatherUnknown => 'غير معروف';

  @override
  String get weatherPartiallyCloudy => 'غائم جزئياً';

  @override
  String get weatherCloudy => 'غائم';

  @override
  String get weatherPartiallyCloudyRain => 'غائم جزئياً/مطر';

  @override
  String get weatherSnow => 'ثلج';

  @override
  String get weatherSunny => 'مشمس';

  @override
  String get weatherOvercastRainThunderstorm => 'غائم مع مطر/عاصفة رعدية جزئية';

  @override
  String get weatherOvercast => 'غائم كلياً';

  @override
  String get weatherMist => 'ضباب';

  @override
  String get weatherOvercastWithRain => 'غائم كلياً مع مطر';

  @override
  String get weatherCloudyWithRain => 'غائم مع مطر';

  @override
  String get weatherCloudyRainThunderstorm => 'غائم مع مطر/عواصف رعدية جزئية';

  @override
  String get weatherCloudsRainThunderstormLocal => 'غيوم/أمطار وعواصف رعدية محلية';

  @override
  String get weatherFog => 'ضباب كثيف';

  @override
  String get statTypeUnknown => 'غير معروف';

  @override
  String get statTypeGoal => 'هدف';

  @override
  String get statTypeCorner => 'ركنية';

  @override
  String get statTypeYellowCard => 'بطاقة صفراء';

  @override
  String get statTypeRedCard => 'بطاقة حمراء';

  @override
  String get statTypeOffside => 'تسلل';

  @override
  String get statTypeFreeKick => 'ركلة حرة';

  @override
  String get statTypeGoalKick => 'ركلة مرمى';

  @override
  String get statTypePenalty => 'ركلة جزاء';

  @override
  String get statTypeSubstitution => 'تبديل';

  @override
  String get statTypeStart => 'بداية';

  @override
  String get statTypeMidfield => 'منتصف الملعب';

  @override
  String get statTypeEnd => 'نهاية';

  @override
  String get statTypeHalftimeScore => 'نتيجة الشوط الأول';

  @override
  String get statTypeCardUpgradeConfirmed => 'تأكيد ترقية البطاقة';

  @override
  String get statTypePenaltyMissed => 'ركلة جزاء ضائعة';

  @override
  String get statTypeOwnGoal => 'هدف ذاتي';

  @override
  String get statTypeInjuryTime => 'وقت بدل ضائع';

  @override
  String get statTypeShotsOnTarget => 'تسديدات على المرمى';

  @override
  String get statTypeShotsOffTarget => 'تسديدات خارج المرمى';

  @override
  String get statTypeAttacks => 'هجمات';

  @override
  String get statTypeDangerousAttack => 'هجمة خطيرة';

  @override
  String get statTypeBallPossession => 'استحواذ';

  @override
  String get statTypeOvertimeIsOver => 'انتهى الوقت الإضافي';

  @override
  String get statTypePenaltyKickEnded => 'انتهت ركلات الترجيح';

  @override
  String get statTypeVAR => 'حكم الفيديو المساعد';

  @override
  String get statTypePenaltyShootout => 'ركلة جزاء (ركلات الترجيح)';

  @override
  String get statTypePenaltyMissedShootout => 'ركلة جزاء ضائعة (ركلات الترجيح)';

  @override
  String get incidentPositionNeutral => 'محايد';

  @override
  String get incidentPositionHome => 'المضيف';

  @override
  String get incidentPositionAway => 'الضيف';

  @override
  String get incidentVARReasonOther => 'آخر';

  @override
  String get incidentVARReasonGoalAwarded => 'تم احتساب الهدف';

  @override
  String get incidentVARReasonGoalNotAwarded => 'لم يتم احتساب الهدف';

  @override
  String get incidentVARReasonPenaltyAwarded => 'تم احتساب ركلة الجزاء';

  @override
  String get incidentVARReasonPenaltyNotAwarded => 'لم يتم احتساب ركلة الجزاء';

  @override
  String get incidentVARReasonRedCardGiven => 'تم إشهار البطاقة الحمراء';

  @override
  String get incidentVARReasonCardUpgrade => 'ترقية البطاقة';

  @override
  String get incidentVARReasonMistakenIdentity => 'هوية خاطئة';

  @override
  String get incidentVARResultUnknown => 'غير معروف';

  @override
  String get incidentVARResultGoalConfirmed => 'تم تأكيد الهدف';

  @override
  String get incidentVARResultGoalCancelled => 'تم إلغاء الهدف';

  @override
  String get incidentVARResultPenaltyConfirmed => 'تم تأكيد ركلة الجزاء';

  @override
  String get incidentVARResultPenaltyCancelled => 'تم إلغاء ركلة الجزاء';

  @override
  String get incidentVARResultRedCardConfirmed => 'تم تأكيد البطاقة الحمراء';

  @override
  String get incidentVARResultRedCardCancelled => 'تم إلغاء البطاقة الحمراء';

  @override
  String get incidentVARResultCardUpgradeConfirmed => 'تم تأكيد ترقية البطاقة';

  @override
  String get incidentVARResultCardUpgradeCancelled => 'تم إلغاء ترقية البطاقة';

  @override
  String get incidentVARResultOriginalDecision => 'القرار الأصلي';

  @override
  String get incidentVARResultOriginalDecisionChanged => 'تم تغيير القرار الأصلي';

  @override
  String get incidentReasonTypeUnknown => 'غير معروف';

  @override
  String get incidentReasonTypeFoul => 'خطأ';

  @override
  String get incidentReasonTypeProfessionalFoul => 'خطأ احترافي';

  @override
  String get incidentReasonTypeEncroachmentOrInjurySub => 'تعدي / تبديل بسبب الإصابة';

  @override
  String get incidentReasonTypeTacticalFoulOrSub => 'خطأ تكتيكي / تبديل تكتيكي';

  @override
  String get incidentReasonTypeRecklessOffence => 'تهور';

  @override
  String get incidentReasonTypeOffBallFoul => 'خطأ بدون كرة';

  @override
  String get incidentReasonTypePersistentFouling => 'أخطاء متكررة';

  @override
  String get incidentReasonTypePersistentInfringement => 'مخالفة متكررة';

  @override
  String get incidentReasonTypeViolentConduct => 'سلوك عنيف';

  @override
  String get incidentReasonTypeDangerousPlay => 'لعب خطير';

  @override
  String get incidentReasonTypeHandball => 'لمسة يد';

  @override
  String get incidentReasonTypeSeriousFoul => 'خطأ جسيم';

  @override
  String get incidentReasonTypeProfessionalFoulLastMan => 'خطأ احترافي (آخر لاعب)';

  @override
  String get incidentReasonTypeDeniedGoalScoringOpportunity => 'حرمان من فرصة تسجيل هدف';

  @override
  String get incidentReasonTypeTimeWasting => 'إضاعة الوقت';

  @override
  String get incidentReasonTypeVideoSyncDone => 'تمت مزامنة الفيديو';

  @override
  String get incidentReasonTypeRescindedCard => 'تم إلغاء البطاقة';

  @override
  String get incidentReasonTypeArgument => 'جدال';

  @override
  String get incidentReasonTypeDissent => 'اعتراض';

  @override
  String get incidentReasonTypeFoulAndAbusiveLanguage => 'لغة بذيئة ومسيئة';

  @override
  String get incidentReasonTypeExcessiveCelebration => 'احتفال مفرط';

  @override
  String get incidentReasonTypeNotRetreating => 'عدم التراجع';

  @override
  String get incidentReasonTypeFight => 'شجار';

  @override
  String get incidentReasonTypeExtraFlagToChecker => 'علم إضافي للمدقق';

  @override
  String get incidentReasonTypeOnBench => 'على مقاعد البدلاء';

  @override
  String get incidentReasonTypePostMatch => 'بعد المباراة';

  @override
  String get incidentReasonTypeOtherReason => 'سبب آخر';

  @override
  String get incidentReasonTypeUnallowedFieldEntering => 'دخول غير مسموح به إلى الملعب';

  @override
  String get incidentReasonTypeEnteringField => 'دخول الملعب';

  @override
  String get incidentReasonTypeLeavingField => 'مغادرة الملعب';

  @override
  String get incidentReasonTypeUnsportingBehaviour => 'سلوك غير رياضي';

  @override
  String get incidentReasonTypeNotVisible => 'غير مرئي';

  @override
  String get incidentReasonTypeFlop => 'تمثيل';

  @override
  String get incidentReasonTypeExcessiveUsageOfReviewSignal => 'استخدام مفرط لإشارة المراجعة';

  @override
  String get incidentReasonTypeEnteringRefereeReviewArea => 'دخول منطقة مراجعة الحكم';

  @override
  String get incidentReasonTypeSpitting => 'بصق';

  @override
  String get incidentReasonTypeViral => 'منتشر';

  @override
  String get playerPositionForward => 'مهاجم';

  @override
  String get playerPositionMidfielder => 'لاعب وسط';

  @override
  String get playerPositionDefender => 'مدافع';

  @override
  String get playerPositionGoalkeeper => 'حارس مرمى';

  @override
  String get playerPositionUnknown => 'غير معروف';

  @override
  String get teamSideHome => 'المضيف';

  @override
  String get teamSideAway => 'الضيف';

  @override
  String get injuryTypeUnknown => 'غير معروف';

  @override
  String get injuryTypeInjured => 'مصاب';

  @override
  String get injuryTypeSuspended => 'موقوف';

  @override
  String get injuryTypeQuestionable => 'مشكوك في أمره';
}
