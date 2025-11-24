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

  /// No description provided for @alostora.
  ///
  /// In en, this message translates to:
  /// **'Alostora'**
  String get alostora;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Alostora Panel'**
  String get appName;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @match.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get match;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for teams, leagues, or matches...'**
  String get searchHint;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @noMatchesToday.
  ///
  /// In en, this message translates to:
  /// **'No matches scheduled for today.'**
  String get noMatchesToday;

  /// No description provided for @noMatchesYesterday.
  ///
  /// In en, this message translates to:
  /// **'No matches were played yesterday.'**
  String get noMatchesYesterday;

  /// No description provided for @noMatchesTomorrow.
  ///
  /// In en, this message translates to:
  /// **'No matches scheduled for tomorrow.'**
  String get noMatchesTomorrow;

  /// No description provided for @noLiveMatches.
  ///
  /// In en, this message translates to:
  /// **'No live matches at the moment.'**
  String get noLiveMatches;

  /// No description provided for @noUpcomingMatches.
  ///
  /// In en, this message translates to:
  /// **'No upcoming matches in the selected date.'**
  String get noUpcomingMatches;

  /// No description provided for @noFinishedMatches.
  ///
  /// In en, this message translates to:
  /// **'No matches finished in the selected date.'**
  String get noFinishedMatches;

  /// No description provided for @failedToLoadMatches.
  ///
  /// In en, this message translates to:
  /// **'Failed to load matches.'**
  String get failedToLoadMatches;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @leagues.
  ///
  /// In en, this message translates to:
  /// **'Leagues'**
  String get leagues;

  /// No description provided for @matchDetail.
  ///
  /// In en, this message translates to:
  /// **'Match Detail'**
  String get matchDetail;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @lineUp.
  ///
  /// In en, this message translates to:
  /// **'Line-up'**
  String get lineUp;

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

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @odds.
  ///
  /// In en, this message translates to:
  /// **'Odds'**
  String get odds;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @incidents.
  ///
  /// In en, this message translates to:
  /// **'Incidents'**
  String get incidents;

  /// No description provided for @referee.
  ///
  /// In en, this message translates to:
  /// **'Referee'**
  String get referee;

  /// No description provided for @stadium.
  ///
  /// In en, this message translates to:
  /// **'Stadium'**
  String get stadium;

  /// No description provided for @capacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacity;

  /// No description provided for @shakingHands.
  ///
  /// In en, this message translates to:
  /// **'Shaking Hands'**
  String get shakingHands;

  /// No description provided for @heads.
  ///
  /// In en, this message translates to:
  /// **'Heads'**
  String get heads;

  /// No description provided for @tails.
  ///
  /// In en, this message translates to:
  /// **'Tails'**
  String get tails;

  /// No description provided for @selectCoin.
  ///
  /// In en, this message translates to:
  /// **'Select Coin'**
  String get selectCoin;

  /// No description provided for @toss.
  ///
  /// In en, this message translates to:
  /// **'Toss'**
  String get toss;

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

  /// No description provided for @bestPlayer.
  ///
  /// In en, this message translates to:
  /// **'Best Player'**
  String get bestPlayer;

  /// No description provided for @onThePitch.
  ///
  /// In en, this message translates to:
  /// **'On the pitch'**
  String get onThePitch;

  /// No description provided for @onTheBench.
  ///
  /// In en, this message translates to:
  /// **'On the bench'**
  String get onTheBench;

  /// No description provided for @highlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get highlights;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @media.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get media;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get loginError;

  /// No description provided for @loginCredentials.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to login'**
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

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

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

  /// No description provided for @matchesTiles.
  ///
  /// In en, this message translates to:
  /// **'Matches Tiles'**
  String get matchesTiles;

  /// No description provided for @matchesList.
  ///
  /// In en, this message translates to:
  /// **'Matches List'**
  String get matchesList;

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
  /// **'Are you sure you want to delete this competition?'**
  String get deleteCompetitionConfirmation;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

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

  /// No description provided for @inXDays.
  ///
  /// In en, this message translates to:
  /// **'In {days} days'**
  String inXDays(int days);

  /// No description provided for @xDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String xDaysAgo(int days);

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

  /// No description provided for @matchStatusAbnormal.
  ///
  /// In en, this message translates to:
  /// **'Abnormal'**
  String get matchStatusAbnormal;

  /// No description provided for @matchStatusNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get matchStatusNotStarted;

  /// No description provided for @matchStatusFirstHalf.
  ///
  /// In en, this message translates to:
  /// **'First half'**
  String get matchStatusFirstHalf;

  /// No description provided for @matchStatusHalfTime.
  ///
  /// In en, this message translates to:
  /// **'Half-time'**
  String get matchStatusHalfTime;

  /// No description provided for @matchStatusSecondHalf.
  ///
  /// In en, this message translates to:
  /// **'Second half'**
  String get matchStatusSecondHalf;

  /// No description provided for @matchStatusOvertime.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get matchStatusOvertime;

  /// No description provided for @matchStatusOvertimeDeprecated.
  ///
  /// In en, this message translates to:
  /// **'Overtime (deprecated)'**
  String get matchStatusOvertimeDeprecated;

  /// No description provided for @matchStatusPenaltyShootout.
  ///
  /// In en, this message translates to:
  /// **'Penalty Shoot-out'**
  String get matchStatusPenaltyShootout;

  /// No description provided for @matchStatusEnded.
  ///
  /// In en, this message translates to:
  /// **'End'**
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

  /// No description provided for @matchStatusTBD.
  ///
  /// In en, this message translates to:
  /// **'To be determined'**
  String get matchStatusTBD;

  /// No description provided for @matchStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get matchStatusUnknown;

  /// No description provided for @weatherUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get weatherUnknown;

  /// No description provided for @weatherPartiallyCloudy.
  ///
  /// In en, this message translates to:
  /// **'Partially cloudy'**
  String get weatherPartiallyCloudy;

  /// No description provided for @weatherCloudy.
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get weatherCloudy;

  /// No description provided for @weatherPartiallyCloudyRain.
  ///
  /// In en, this message translates to:
  /// **'Partially cloudy/rain'**
  String get weatherPartiallyCloudyRain;

  /// No description provided for @weatherSnow.
  ///
  /// In en, this message translates to:
  /// **'Snow'**
  String get weatherSnow;

  /// No description provided for @weatherSunny.
  ///
  /// In en, this message translates to:
  /// **'Sunny'**
  String get weatherSunny;

  /// No description provided for @weatherOvercastRainThunderstorm.
  ///
  /// In en, this message translates to:
  /// **'Overcast Rain/partial thunderstorm'**
  String get weatherOvercastRainThunderstorm;

  /// No description provided for @weatherOvercast.
  ///
  /// In en, this message translates to:
  /// **'Overcast'**
  String get weatherOvercast;

  /// No description provided for @weatherMist.
  ///
  /// In en, this message translates to:
  /// **'Mist'**
  String get weatherMist;

  /// No description provided for @weatherOvercastWithRain.
  ///
  /// In en, this message translates to:
  /// **'Overcast with rain'**
  String get weatherOvercastWithRain;

  /// No description provided for @weatherCloudyWithRain.
  ///
  /// In en, this message translates to:
  /// **'Cloudy with rain'**
  String get weatherCloudyWithRain;

  /// No description provided for @weatherCloudyRainThunderstorm.
  ///
  /// In en, this message translates to:
  /// **'Cloudy with rain/partial Thunderstorms'**
  String get weatherCloudyRainThunderstorm;

  /// No description provided for @weatherCloudsRainThunderstormLocal.
  ///
  /// In en, this message translates to:
  /// **'Clouds/rains and thunderstorms locally'**
  String get weatherCloudsRainThunderstormLocal;

  /// No description provided for @weatherFog.
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get weatherFog;

  /// No description provided for @statTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statTypeUnknown;

  /// No description provided for @statTypeGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get statTypeGoal;

  /// No description provided for @statTypeCorner.
  ///
  /// In en, this message translates to:
  /// **'Corner'**
  String get statTypeCorner;

  /// No description provided for @statTypeYellowCard.
  ///
  /// In en, this message translates to:
  /// **'Yellow card'**
  String get statTypeYellowCard;

  /// No description provided for @statTypeRedCard.
  ///
  /// In en, this message translates to:
  /// **'Red card'**
  String get statTypeRedCard;

  /// No description provided for @statTypeOffside.
  ///
  /// In en, this message translates to:
  /// **'Offside'**
  String get statTypeOffside;

  /// No description provided for @statTypeFreeKick.
  ///
  /// In en, this message translates to:
  /// **'Free kick'**
  String get statTypeFreeKick;

  /// No description provided for @statTypeGoalKick.
  ///
  /// In en, this message translates to:
  /// **'Goal kick'**
  String get statTypeGoalKick;

  /// No description provided for @statTypePenalty.
  ///
  /// In en, this message translates to:
  /// **'Penalty'**
  String get statTypePenalty;

  /// No description provided for @statTypeSubstitution.
  ///
  /// In en, this message translates to:
  /// **'Substitution'**
  String get statTypeSubstitution;

  /// No description provided for @statTypeStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get statTypeStart;

  /// No description provided for @statTypeMidfield.
  ///
  /// In en, this message translates to:
  /// **'Midfield'**
  String get statTypeMidfield;

  /// No description provided for @statTypeEnd.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get statTypeEnd;

  /// No description provided for @statTypeHalftimeScore.
  ///
  /// In en, this message translates to:
  /// **'Halftime score'**
  String get statTypeHalftimeScore;

  /// No description provided for @statTypeCardUpgradeConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Card upgrade confirmed'**
  String get statTypeCardUpgradeConfirmed;

  /// No description provided for @statTypePenaltyMissed.
  ///
  /// In en, this message translates to:
  /// **'Penalty missed'**
  String get statTypePenaltyMissed;

  /// No description provided for @statTypeOwnGoal.
  ///
  /// In en, this message translates to:
  /// **'Own goal'**
  String get statTypeOwnGoal;

  /// No description provided for @statTypeInjuryTime.
  ///
  /// In en, this message translates to:
  /// **'Injury time'**
  String get statTypeInjuryTime;

  /// No description provided for @statTypeShotsOnTarget.
  ///
  /// In en, this message translates to:
  /// **'Shots on target'**
  String get statTypeShotsOnTarget;

  /// No description provided for @statTypeShotsOffTarget.
  ///
  /// In en, this message translates to:
  /// **'Shots off target'**
  String get statTypeShotsOffTarget;

  /// No description provided for @statTypeAttacks.
  ///
  /// In en, this message translates to:
  /// **'Attacks'**
  String get statTypeAttacks;

  /// No description provided for @statTypeDangerousAttack.
  ///
  /// In en, this message translates to:
  /// **'Dangerous Attack'**
  String get statTypeDangerousAttack;

  /// No description provided for @statTypeBallPossession.
  ///
  /// In en, this message translates to:
  /// **'Ball possession'**
  String get statTypeBallPossession;

  /// No description provided for @statTypeOvertimeIsOver.
  ///
  /// In en, this message translates to:
  /// **'Overtime is over'**
  String get statTypeOvertimeIsOver;

  /// No description provided for @statTypePenaltyKickEnded.
  ///
  /// In en, this message translates to:
  /// **'Penalty kick ended'**
  String get statTypePenaltyKickEnded;

  /// No description provided for @statTypeVAR.
  ///
  /// In en, this message translates to:
  /// **'VAR'**
  String get statTypeVAR;

  /// No description provided for @statTypePenaltyShootout.
  ///
  /// In en, this message translates to:
  /// **'Penalty (Penalty Shoot-out)'**
  String get statTypePenaltyShootout;

  /// No description provided for @statTypePenaltyMissedShootout.
  ///
  /// In en, this message translates to:
  /// **'Penalty missed (Penalty Shoot-out)'**
  String get statTypePenaltyMissedShootout;

  /// No description provided for @incidentPositionNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get incidentPositionNeutral;

  /// No description provided for @incidentPositionHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get incidentPositionHome;

  /// No description provided for @incidentPositionAway.
  ///
  /// In en, this message translates to:
  /// **'Away'**
  String get incidentPositionAway;

  /// No description provided for @incidentVARReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get incidentVARReasonOther;

  /// No description provided for @incidentVARReasonGoalAwarded.
  ///
  /// In en, this message translates to:
  /// **'Goal awarded'**
  String get incidentVARReasonGoalAwarded;

  /// No description provided for @incidentVARReasonGoalNotAwarded.
  ///
  /// In en, this message translates to:
  /// **'Goal not awarded'**
  String get incidentVARReasonGoalNotAwarded;

  /// No description provided for @incidentVARReasonPenaltyAwarded.
  ///
  /// In en, this message translates to:
  /// **'Penalty awarded'**
  String get incidentVARReasonPenaltyAwarded;

  /// No description provided for @incidentVARReasonPenaltyNotAwarded.
  ///
  /// In en, this message translates to:
  /// **'Penalty not awarded'**
  String get incidentVARReasonPenaltyNotAwarded;

  /// No description provided for @incidentVARReasonRedCardGiven.
  ///
  /// In en, this message translates to:
  /// **'Red card given'**
  String get incidentVARReasonRedCardGiven;

  /// No description provided for @incidentVARReasonCardUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Card upgrade'**
  String get incidentVARReasonCardUpgrade;

  /// No description provided for @incidentVARReasonMistakenIdentity.
  ///
  /// In en, this message translates to:
  /// **'Mistaken identity'**
  String get incidentVARReasonMistakenIdentity;

  /// No description provided for @incidentVARResultUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get incidentVARResultUnknown;

  /// No description provided for @incidentVARResultGoalConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Goal confirmed'**
  String get incidentVARResultGoalConfirmed;

  /// No description provided for @incidentVARResultGoalCancelled.
  ///
  /// In en, this message translates to:
  /// **'Goal cancelled'**
  String get incidentVARResultGoalCancelled;

  /// No description provided for @incidentVARResultPenaltyConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Penalty confirmed'**
  String get incidentVARResultPenaltyConfirmed;

  /// No description provided for @incidentVARResultPenaltyCancelled.
  ///
  /// In en, this message translates to:
  /// **'Penalty cancelled'**
  String get incidentVARResultPenaltyCancelled;

  /// No description provided for @incidentVARResultRedCardConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Red card confirmed'**
  String get incidentVARResultRedCardConfirmed;

  /// No description provided for @incidentVARResultRedCardCancelled.
  ///
  /// In en, this message translates to:
  /// **'Red card cancelled'**
  String get incidentVARResultRedCardCancelled;

  /// No description provided for @incidentVARResultCardUpgradeConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Card upgrade confirmed'**
  String get incidentVARResultCardUpgradeConfirmed;

  /// No description provided for @incidentVARResultCardUpgradeCancelled.
  ///
  /// In en, this message translates to:
  /// **'Card upgrade cancelled'**
  String get incidentVARResultCardUpgradeCancelled;

  /// No description provided for @incidentVARResultOriginalDecision.
  ///
  /// In en, this message translates to:
  /// **'Original decision'**
  String get incidentVARResultOriginalDecision;

  /// No description provided for @incidentVARResultOriginalDecisionChanged.
  ///
  /// In en, this message translates to:
  /// **'Original decision changed'**
  String get incidentVARResultOriginalDecisionChanged;

  /// No description provided for @incidentReasonTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get incidentReasonTypeUnknown;

  /// No description provided for @incidentReasonTypeFoul.
  ///
  /// In en, this message translates to:
  /// **'Foul'**
  String get incidentReasonTypeFoul;

  /// No description provided for @incidentReasonTypeProfessionalFoul.
  ///
  /// In en, this message translates to:
  /// **'Professional foul'**
  String get incidentReasonTypeProfessionalFoul;

  /// No description provided for @incidentReasonTypeEncroachmentOrInjurySub.
  ///
  /// In en, this message translates to:
  /// **'Encroachment / Injury substitution'**
  String get incidentReasonTypeEncroachmentOrInjurySub;

  /// No description provided for @incidentReasonTypeTacticalFoulOrSub.
  ///
  /// In en, this message translates to:
  /// **'Tactical Foul / Tactical substitution'**
  String get incidentReasonTypeTacticalFoulOrSub;

  /// No description provided for @incidentReasonTypeRecklessOffence.
  ///
  /// In en, this message translates to:
  /// **'Reckless Offence'**
  String get incidentReasonTypeRecklessOffence;

  /// No description provided for @incidentReasonTypeOffBallFoul.
  ///
  /// In en, this message translates to:
  /// **'Off the ball foul'**
  String get incidentReasonTypeOffBallFoul;

  /// No description provided for @incidentReasonTypePersistentFouling.
  ///
  /// In en, this message translates to:
  /// **'Persistent fouling'**
  String get incidentReasonTypePersistentFouling;

  /// No description provided for @incidentReasonTypePersistentInfringement.
  ///
  /// In en, this message translates to:
  /// **'Persistent Infringement'**
  String get incidentReasonTypePersistentInfringement;

  /// No description provided for @incidentReasonTypeViolentConduct.
  ///
  /// In en, this message translates to:
  /// **'Violent conduct'**
  String get incidentReasonTypeViolentConduct;

  /// No description provided for @incidentReasonTypeDangerousPlay.
  ///
  /// In en, this message translates to:
  /// **'Dangerous play'**
  String get incidentReasonTypeDangerousPlay;

  /// No description provided for @incidentReasonTypeHandball.
  ///
  /// In en, this message translates to:
  /// **'Handball'**
  String get incidentReasonTypeHandball;

  /// No description provided for @incidentReasonTypeSeriousFoul.
  ///
  /// In en, this message translates to:
  /// **'Serious Foul'**
  String get incidentReasonTypeSeriousFoul;

  /// No description provided for @incidentReasonTypeProfessionalFoulLastMan.
  ///
  /// In en, this message translates to:
  /// **'Professional foul last man'**
  String get incidentReasonTypeProfessionalFoulLastMan;

  /// No description provided for @incidentReasonTypeDeniedGoalScoringOpportunity.
  ///
  /// In en, this message translates to:
  /// **'Denied goal-scoring opportunity'**
  String get incidentReasonTypeDeniedGoalScoringOpportunity;

  /// No description provided for @incidentReasonTypeTimeWasting.
  ///
  /// In en, this message translates to:
  /// **'Time wasting'**
  String get incidentReasonTypeTimeWasting;

  /// No description provided for @incidentReasonTypeVideoSyncDone.
  ///
  /// In en, this message translates to:
  /// **'Video sync done'**
  String get incidentReasonTypeVideoSyncDone;

  /// No description provided for @incidentReasonTypeRescindedCard.
  ///
  /// In en, this message translates to:
  /// **'Rescinded Card'**
  String get incidentReasonTypeRescindedCard;

  /// No description provided for @incidentReasonTypeArgument.
  ///
  /// In en, this message translates to:
  /// **'Argument'**
  String get incidentReasonTypeArgument;

  /// No description provided for @incidentReasonTypeDissent.
  ///
  /// In en, this message translates to:
  /// **'Dissent'**
  String get incidentReasonTypeDissent;

  /// No description provided for @incidentReasonTypeFoulAndAbusiveLanguage.
  ///
  /// In en, this message translates to:
  /// **'Foul and Abusive Language'**
  String get incidentReasonTypeFoulAndAbusiveLanguage;

  /// No description provided for @incidentReasonTypeExcessiveCelebration.
  ///
  /// In en, this message translates to:
  /// **'Excessive celebration'**
  String get incidentReasonTypeExcessiveCelebration;

  /// No description provided for @incidentReasonTypeNotRetreating.
  ///
  /// In en, this message translates to:
  /// **'Not Retreating'**
  String get incidentReasonTypeNotRetreating;

  /// No description provided for @incidentReasonTypeFight.
  ///
  /// In en, this message translates to:
  /// **'Fight'**
  String get incidentReasonTypeFight;

  /// No description provided for @incidentReasonTypeExtraFlagToChecker.
  ///
  /// In en, this message translates to:
  /// **'Extra flag to checker'**
  String get incidentReasonTypeExtraFlagToChecker;

  /// No description provided for @incidentReasonTypeOnBench.
  ///
  /// In en, this message translates to:
  /// **'On bench'**
  String get incidentReasonTypeOnBench;

  /// No description provided for @incidentReasonTypePostMatch.
  ///
  /// In en, this message translates to:
  /// **'Post match'**
  String get incidentReasonTypePostMatch;

  /// No description provided for @incidentReasonTypeOtherReason.
  ///
  /// In en, this message translates to:
  /// **'Other reason'**
  String get incidentReasonTypeOtherReason;

  /// No description provided for @incidentReasonTypeUnallowedFieldEntering.
  ///
  /// In en, this message translates to:
  /// **'Unallowed field entering'**
  String get incidentReasonTypeUnallowedFieldEntering;

  /// No description provided for @incidentReasonTypeEnteringField.
  ///
  /// In en, this message translates to:
  /// **'Entering field'**
  String get incidentReasonTypeEnteringField;

  /// No description provided for @incidentReasonTypeLeavingField.
  ///
  /// In en, this message translates to:
  /// **'Leaving field'**
  String get incidentReasonTypeLeavingField;

  /// No description provided for @incidentReasonTypeUnsportingBehaviour.
  ///
  /// In en, this message translates to:
  /// **'Unsporting behaviour'**
  String get incidentReasonTypeUnsportingBehaviour;

  /// No description provided for @incidentReasonTypeNotVisible.
  ///
  /// In en, this message translates to:
  /// **'Not visible'**
  String get incidentReasonTypeNotVisible;

  /// No description provided for @incidentReasonTypeFlop.
  ///
  /// In en, this message translates to:
  /// **'Flop'**
  String get incidentReasonTypeFlop;

  /// No description provided for @incidentReasonTypeExcessiveUsageOfReviewSignal.
  ///
  /// In en, this message translates to:
  /// **'Excessive usage of review signal'**
  String get incidentReasonTypeExcessiveUsageOfReviewSignal;

  /// No description provided for @incidentReasonTypeEnteringRefereeReviewArea.
  ///
  /// In en, this message translates to:
  /// **'Entering referee review area'**
  String get incidentReasonTypeEnteringRefereeReviewArea;

  /// No description provided for @incidentReasonTypeSpitting.
  ///
  /// In en, this message translates to:
  /// **'Spitting'**
  String get incidentReasonTypeSpitting;

  /// No description provided for @incidentReasonTypeViral.
  ///
  /// In en, this message translates to:
  /// **'Viral'**
  String get incidentReasonTypeViral;

  /// No description provided for @playerPositionForward.
  ///
  /// In en, this message translates to:
  /// **'Forward'**
  String get playerPositionForward;

  /// No description provided for @playerPositionMidfielder.
  ///
  /// In en, this message translates to:
  /// **'Midfielder'**
  String get playerPositionMidfielder;

  /// No description provided for @playerPositionDefender.
  ///
  /// In en, this message translates to:
  /// **'Defender'**
  String get playerPositionDefender;

  /// No description provided for @playerPositionGoalkeeper.
  ///
  /// In en, this message translates to:
  /// **'Goalkeeper'**
  String get playerPositionGoalkeeper;

  /// No description provided for @playerPositionUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get playerPositionUnknown;

  /// No description provided for @teamSideHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get teamSideHome;

  /// No description provided for @teamSideAway.
  ///
  /// In en, this message translates to:
  /// **'Away'**
  String get teamSideAway;

  /// No description provided for @injuryTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get injuryTypeUnknown;

  /// No description provided for @injuryTypeInjured.
  ///
  /// In en, this message translates to:
  /// **'Injured'**
  String get injuryTypeInjured;

  /// No description provided for @injuryTypeSuspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get injuryTypeSuspended;

  /// No description provided for @injuryTypeQuestionable.
  ///
  /// In en, this message translates to:
  /// **'Questionable'**
  String get injuryTypeQuestionable;
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
