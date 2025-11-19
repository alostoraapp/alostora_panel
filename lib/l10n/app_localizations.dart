import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get home;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Admin!'**
  String get welcome;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @loginCredentials.
  ///
  /// In en, this message translates to:
  /// **'Login with your credentials'**
  String get loginCredentials;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @competitionSelect.
  ///
  /// In en, this message translates to:
  /// **'Competition Select'**
  String get competitionSelect;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @saveOrder.
  ///
  /// In en, this message translates to:
  /// **'Save Order'**
  String get saveOrder;

  /// No description provided for @totalUsers.
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get totalUsers;

  /// No description provided for @onlineUsers.
  ///
  /// In en, this message translates to:
  /// **'Online Users'**
  String get onlineUsers;

  /// No description provided for @todaysMatches.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Matches'**
  String get todaysMatches;

  /// No description provided for @liveMatches.
  ///
  /// In en, this message translates to:
  /// **'Live Matches'**
  String get liveMatches;

  /// No description provided for @tomorrowsMatches.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow\'s Matches'**
  String get tomorrowsMatches;

  /// No description provided for @thisWeeksMatches.
  ///
  /// In en, this message translates to:
  /// **'This Week\'s Matches'**
  String get thisWeeksMatches;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get loginError;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @matchesTiles.
  ///
  /// In en, this message translates to:
  /// **'Tiles View'**
  String get matchesTiles;

  /// No description provided for @matchesList.
  ///
  /// In en, this message translates to:
  /// **'Matches List'**
  String get matchesList;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @inXDays.
  ///
  /// In en, this message translates to:
  /// **'In {count} days'**
  String inXDays(Object count);

  /// No description provided for @xDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String xDaysAgo(Object count);

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @sortByImportance.
  ///
  /// In en, this message translates to:
  /// **'Importance'**
  String get sortByImportance;

  /// No description provided for @sortByTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get sortByTime;

  /// No description provided for @liveFilter.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get liveFilter;

  /// No description provided for @matchStatusAbnormal.
  ///
  /// In en, this message translates to:
  /// **'Abnormal'**
  String get matchStatusAbnormal;

  /// No description provided for @matchStatusNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get matchStatusNotStarted;

  /// No description provided for @matchStatusFirstHalf.
  ///
  /// In en, this message translates to:
  /// **'1H'**
  String get matchStatusFirstHalf;

  /// No description provided for @matchStatusHalfTime.
  ///
  /// In en, this message translates to:
  /// **'Half-Time'**
  String get matchStatusHalfTime;

  /// No description provided for @matchStatusSecondHalf.
  ///
  /// In en, this message translates to:
  /// **'2H'**
  String get matchStatusSecondHalf;

  /// No description provided for @matchStatusOvertime.
  ///
  /// In en, this message translates to:
  /// **'ET'**
  String get matchStatusOvertime;

  /// No description provided for @matchStatusOvertimeDeprecated.
  ///
  /// In en, this message translates to:
  /// **'Overtime (Deprecated)'**
  String get matchStatusOvertimeDeprecated;

  /// No description provided for @matchStatusPenaltyShootout.
  ///
  /// In en, this message translates to:
  /// **'Penalty Shootout'**
  String get matchStatusPenaltyShootout;

  /// No description provided for @matchStatusEnded.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get matchStatusEnded;

  /// No description provided for @matchStatusDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get matchStatusDelayed;

  /// No description provided for @matchStatusInterrupted.
  ///
  /// In en, this message translates to:
  /// **'Interrupted'**
  String get matchStatusInterrupted;

  /// No description provided for @matchStatusCutInHalf.
  ///
  /// In en, this message translates to:
  /// **'Cut in half'**
  String get matchStatusCutInHalf;

  /// No description provided for @matchStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get matchStatusCancelled;

  /// No description provided for @matchStatusTbd.
  ///
  /// In en, this message translates to:
  /// **'To be determined'**
  String get matchStatusTbd;

  /// No description provided for @matchStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get matchStatusUnknown;

  /// No description provided for @addNewCompetition.
  ///
  /// In en, this message translates to:
  /// **'Add New Competition'**
  String get addNewCompetition;

  /// No description provided for @enterCompetitionId.
  ///
  /// In en, this message translates to:
  /// **'Enter Competition ID'**
  String get enterCompetitionId;

  /// No description provided for @pleaseEnterCompetitionId.
  ///
  /// In en, this message translates to:
  /// **'Please enter competition ID'**
  String get pleaseEnterCompetitionId;

  /// No description provided for @competitionId.
  ///
  /// In en, this message translates to:
  /// **'Competition ID'**
  String get competitionId;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @typeToSearch.
  ///
  /// In en, this message translates to:
  /// **'Type to search...'**
  String get typeToSearch;

  /// No description provided for @searchCompetition.
  ///
  /// In en, this message translates to:
  /// **'Search Competition'**
  String get searchCompetition;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fa': return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
