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
  /// **'Alostora Panel'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginCredentials.
  ///
  /// In en, this message translates to:
  /// **'Login with your credentials'**
  String get loginCredentials;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Please try again.'**
  String get loginError;

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

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @matchDetails.
  ///
  /// In en, this message translates to:
  /// **'Match Details'**
  String get matchDetails;

  /// No description provided for @matchTime.
  ///
  /// In en, this message translates to:
  /// **'Match Time'**
  String get matchTime;

  /// No description provided for @matchStatus.
  ///
  /// In en, this message translates to:
  /// **'Match Status'**
  String get matchStatus;

  /// No description provided for @matchActions.
  ///
  /// In en, this message translates to:
  /// **'Match Actions'**
  String get matchActions;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @away.
  ///
  /// In en, this message translates to:
  /// **'Away'**
  String get away;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @teams.
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teams;

  /// No description provided for @player.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// No description provided for @players.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// No description provided for @competition.
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get competition;

  /// No description provided for @competitions.
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get competitions;

  /// No description provided for @channel.
  ///
  /// In en, this message translates to:
  /// **'Channel'**
  String get channel;

  /// No description provided for @channels.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get channels;

  /// No description provided for @broadcaster.
  ///
  /// In en, this message translates to:
  /// **'Broadcaster'**
  String get broadcaster;

  /// No description provided for @broadcasters.
  ///
  /// In en, this message translates to:
  /// **'Broadcasters'**
  String get broadcasters;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @shortName.
  ///
  /// In en, this message translates to:
  /// **'Short Name'**
  String get shortName;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// No description provided for @logo.
  ///
  /// In en, this message translates to:
  /// **'Logo'**
  String get logo;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @successTitle.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get successTitle;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @confirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmTitle;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item?'**
  String get deleteConfirmation;

  /// No description provided for @saveChangesSuccess.
  ///
  /// In en, this message translates to:
  /// **'Changes saved successfully.'**
  String get saveChangesSuccess;

  /// No description provided for @addSuccess.
  ///
  /// In en, this message translates to:
  /// **'Added successfully.'**
  String get addSuccess;

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully.'**
  String get deleteSuccess;

  /// No description provided for @anErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get anErrorOccurred;

  /// No description provided for @selectCompetition.
  ///
  /// In en, this message translates to:
  /// **'Select Competition'**
  String get selectCompetition;

  /// No description provided for @selectTeam.
  ///
  /// In en, this message translates to:
  /// **'Select Team'**
  String get selectTeam;

  /// No description provided for @selectBroadcaster.
  ///
  /// In en, this message translates to:
  /// **'Select Broadcaster'**
  String get selectBroadcaster;

  /// No description provided for @selectChannel.
  ///
  /// In en, this message translates to:
  /// **'Select Channel'**
  String get selectChannel;

  /// No description provided for @noOptions.
  ///
  /// In en, this message translates to:
  /// **'No options available'**
  String get noOptions;

  /// No description provided for @homeTeam.
  ///
  /// In en, this message translates to:
  /// **'Home Team'**
  String get homeTeam;

  /// No description provided for @awayTeam.
  ///
  /// In en, this message translates to:
  /// **'Away Team'**
  String get awayTeam;

  /// No description provided for @competitionConfig.
  ///
  /// In en, this message translates to:
  /// **'Competition Config'**
  String get competitionConfig;

  /// No description provided for @visible.
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get visible;

  /// No description provided for @hidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hidden;

  /// No description provided for @bestPlayer.
  ///
  /// In en, this message translates to:
  /// **'Best Player'**
  String get bestPlayer;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// No description provided for @h2h.
  ///
  /// In en, this message translates to:
  /// **'H2H'**
  String get h2h;

  /// No description provided for @standings.
  ///
  /// In en, this message translates to:
  /// **'Standings'**
  String get standings;

  /// No description provided for @onThePitch.
  ///
  /// In en, this message translates to:
  /// **'On the Pitch'**
  String get onThePitch;

  /// No description provided for @onTheBench.
  ///
  /// In en, this message translates to:
  /// **'On the Bench'**
  String get onTheBench;

  /// No description provided for @confirmMOTMTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Man of the Match'**
  String get confirmMOTMTitle;

  /// No description provided for @confirmMOTMMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to select {playerName} as the Man of the Match?'**
  String confirmMOTMMessage(String playerName);

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @unknownPlayer.
  ///
  /// In en, this message translates to:
  /// **'Unknown Player'**
  String get unknownPlayer;

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
  String inXDays(int count);

  /// No description provided for @xDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String xDaysAgo(int count);

  /// No description provided for @liveFilter.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get liveFilter;

  /// No description provided for @sortByImportance.
  ///
  /// In en, this message translates to:
  /// **'Sort by Importance'**
  String get sortByImportance;

  /// No description provided for @sortByTime.
  ///
  /// In en, this message translates to:
  /// **'Sort by Time'**
  String get sortByTime;

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

  /// No description provided for @addNewCompetition.
  ///
  /// In en, this message translates to:
  /// **'Add New Competition'**
  String get addNewCompetition;

  /// No description provided for @competitionId.
  ///
  /// In en, this message translates to:
  /// **'Competition ID'**
  String get competitionId;

  /// No description provided for @pleaseEnterCompetitionId.
  ///
  /// In en, this message translates to:
  /// **'Please enter a competition ID'**
  String get pleaseEnterCompetitionId;

  /// No description provided for @deleteCompetition.
  ///
  /// In en, this message translates to:
  /// **'Delete Competition'**
  String get deleteCompetition;

  /// No description provided for @deleteCompetitionConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this competition configuration?'**
  String get deleteCompetitionConfirmation;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @matchesTiles.
  ///
  /// In en, this message translates to:
  /// **'Matches (Tiles)'**
  String get matchesTiles;

  /// No description provided for @matchesList.
  ///
  /// In en, this message translates to:
  /// **'Matches (List)'**
  String get matchesList;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @typeToSearch.
  ///
  /// In en, this message translates to:
  /// **'Type to search for competitions'**
  String get typeToSearch;

  /// No description provided for @searchCompetition.
  ///
  /// In en, this message translates to:
  /// **'Search Competition'**
  String get searchCompetition;

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
  /// **'First Half'**
  String get matchStatusFirstHalf;

  /// No description provided for @matchStatusHalfTime.
  ///
  /// In en, this message translates to:
  /// **'Half Time'**
  String get matchStatusHalfTime;

  /// No description provided for @matchStatusSecondHalf.
  ///
  /// In en, this message translates to:
  /// **'Second Half'**
  String get matchStatusSecondHalf;

  /// No description provided for @matchStatusOvertime.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get matchStatusOvertime;

  /// No description provided for @matchStatusOvertimeDeprecated.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
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
  /// **'Cut in Half'**
  String get matchStatusCutInHalf;

  /// No description provided for @matchStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get matchStatusCancelled;

  /// No description provided for @matchStatusTBD.
  ///
  /// In en, this message translates to:
  /// **'To Be Determined'**
  String get matchStatusTBD;

  /// No description provided for @matchStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get matchStatusUnknown;
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
