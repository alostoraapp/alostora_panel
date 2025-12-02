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
  /// **'Al Ostora Panel'**
  String get appName;

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

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

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

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

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

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @competitionSelect.
  ///
  /// In en, this message translates to:
  /// **'Select Competitions'**
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

  /// No description provided for @searchCompetition.
  ///
  /// In en, this message translates to:
  /// **'Search for a competition'**
  String get searchCompetition;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @typeToSearch.
  ///
  /// In en, this message translates to:
  /// **'Type to search'**
  String get typeToSearch;

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
  /// **'1st Half'**
  String get matchStatusFirstHalf;

  /// No description provided for @matchStatusHalfTime.
  ///
  /// In en, this message translates to:
  /// **'Half Time'**
  String get matchStatusHalfTime;

  /// No description provided for @matchStatusSecondHalf.
  ///
  /// In en, this message translates to:
  /// **'2nd Half'**
  String get matchStatusSecondHalf;

  /// No description provided for @matchStatusOvertime.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get matchStatusOvertime;

  /// No description provided for @matchStatusOvertimeDeprecated.
  ///
  /// In en, this message translates to:
  /// **'Extra Time'**
  String get matchStatusOvertimeDeprecated;

  /// No description provided for @matchStatusPenaltyShootout.
  ///
  /// In en, this message translates to:
  /// **'Penalties'**
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
  /// **'To Be Defined'**
  String get matchStatusTBD;

  /// No description provided for @matchStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown Status'**
  String get matchStatusUnknown;

  /// No description provided for @bestPlayer.
  ///
  /// In en, this message translates to:
  /// **'Best Player'**
  String get bestPlayer;

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

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

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

  /// No description provided for @unknownPlayer.
  ///
  /// In en, this message translates to:
  /// **'Unknown Player'**
  String get unknownPlayer;

  /// No description provided for @confirmMOTMTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Man of the Match'**
  String get confirmMOTMTitle;

  /// No description provided for @confirmMOTMMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to set {playerName} as the Man of the Match?'**
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

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found'**
  String get noDataFound;

  /// No description provided for @penalties.
  ///
  /// In en, this message translates to:
  /// **'Penalties'**
  String get penalties;

  /// No description provided for @overtime.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get overtime;

  /// No description provided for @secondHalf.
  ///
  /// In en, this message translates to:
  /// **'Second Half'**
  String get secondHalf;

  /// No description provided for @firstHalf.
  ///
  /// In en, this message translates to:
  /// **'First Half'**
  String get firstHalf;

  /// No description provided for @ownGoal.
  ///
  /// In en, this message translates to:
  /// **'(Own Goal)'**
  String get ownGoal;

  /// No description provided for @penaltyMissed.
  ///
  /// In en, this message translates to:
  /// **'(Penalty Missed)'**
  String get penaltyMissed;

  /// No description provided for @varCheck.
  ///
  /// In en, this message translates to:
  /// **'VAR Check'**
  String get varCheck;

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

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search;

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

  /// No description provided for @noMatchesFound.
  ///
  /// In en, this message translates to:
  /// **'No Matches Found'**
  String get noMatchesFound;

  /// No description provided for @importantEvents.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get importantEvents;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @mediaUrl.
  ///
  /// In en, this message translates to:
  /// **'Media URL'**
  String get mediaUrl;

  /// No description provided for @mediaCover.
  ///
  /// In en, this message translates to:
  /// **'Media Cover'**
  String get mediaCover;

  /// No description provided for @videoTime.
  ///
  /// In en, this message translates to:
  /// **'Video Time (seconds)'**
  String get videoTime;

  /// No description provided for @editIncidentMedia.
  ///
  /// In en, this message translates to:
  /// **'Edit Incident Media'**
  String get editIncidentMedia;

  /// No description provided for @sendNotification.
  ///
  /// In en, this message translates to:
  /// **'Send Notification'**
  String get sendNotification;

  /// No description provided for @sendNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'If enabled, priority will be set to Urgent.'**
  String get sendNotificationSubtitle;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @incidentApproved.
  ///
  /// In en, this message translates to:
  /// **'Incident Approved'**
  String get incidentApproved;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get requestSent;

  /// No description provided for @highlightTypeSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get highlightTypeSummary;

  /// No description provided for @highlightTypeGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get highlightTypeGoals;

  /// No description provided for @highlightTypeFullMatch.
  ///
  /// In en, this message translates to:
  /// **'Full Match'**
  String get highlightTypeFullMatch;

  /// No description provided for @highlightTypePenalties.
  ///
  /// In en, this message translates to:
  /// **'Penalties'**
  String get highlightTypePenalties;

  /// No description provided for @highlightTypeCelebration.
  ///
  /// In en, this message translates to:
  /// **'Celebration'**
  String get highlightTypeCelebration;

  /// No description provided for @highlightTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get highlightTypeOther;

  /// No description provided for @highlightStatusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get highlightStatusDraft;

  /// No description provided for @highlightStatusPendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get highlightStatusPendingApproval;

  /// No description provided for @highlightStatusPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get highlightStatusPublished;

  /// No description provided for @highlightPriorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get highlightPriorityNormal;

  /// No description provided for @highlightPriorityImportant.
  ///
  /// In en, this message translates to:
  /// **'Important (No Notification)'**
  String get highlightPriorityImportant;

  /// No description provided for @highlightPriorityUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent (With Notification)'**
  String get highlightPriorityUrgent;

  /// No description provided for @highlightType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get highlightType;

  /// No description provided for @highlightPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get highlightPriority;

  /// No description provided for @highlightStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get highlightStatus;

  /// No description provided for @errorPickingImage.
  ///
  /// In en, this message translates to:
  /// **'Error picking image: {error}'**
  String errorPickingImage(String error);

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(String error);

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @addMedia.
  ///
  /// In en, this message translates to:
  /// **'Add Media'**
  String get addMedia;

  /// No description provided for @editMedia.
  ///
  /// In en, this message translates to:
  /// **'Edit Media'**
  String get editMedia;

  /// No description provided for @lineup.
  ///
  /// In en, this message translates to:
  /// **'Lineup'**
  String get lineup;

  /// No description provided for @matchDetails.
  ///
  /// In en, this message translates to:
  /// **'Match Details'**
  String get matchDetails;

  /// No description provided for @platformYouTube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get platformYouTube;

  /// No description provided for @platformX.
  ///
  /// In en, this message translates to:
  /// **'X (Twitter)'**
  String get platformX;

  /// No description provided for @platformFacebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get platformFacebook;

  /// No description provided for @platformOfficial.
  ///
  /// In en, this message translates to:
  /// **'Official Website'**
  String get platformOfficial;

  /// No description provided for @platformOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get platformOther;

  /// No description provided for @addBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Add Broadcast'**
  String get addBroadcast;

  /// No description provided for @editBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Edit Broadcast'**
  String get editBroadcast;

  /// No description provided for @platform.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get platform;

  /// No description provided for @tvChannel.
  ///
  /// In en, this message translates to:
  /// **'TV Channel'**
  String get tvChannel;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @pleaseSelectTvChannel.
  ///
  /// In en, this message translates to:
  /// **'Please select a TV Channel'**
  String get pleaseSelectTvChannel;

  /// No description provided for @pleaseSelectPlatform.
  ///
  /// In en, this message translates to:
  /// **'Please select a Platform'**
  String get pleaseSelectPlatform;

  /// No description provided for @pleaseEnterUrl.
  ///
  /// In en, this message translates to:
  /// **'Please enter URL'**
  String get pleaseEnterUrl;

  /// No description provided for @deleteBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Delete Broadcast'**
  String get deleteBroadcast;

  /// No description provided for @deleteBroadcastConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this broadcast?'**
  String get deleteBroadcastConfirmation;

  /// No description provided for @tvChannels.
  ///
  /// In en, this message translates to:
  /// **'TV Channels'**
  String get tvChannels;

  /// No description provided for @commentators.
  ///
  /// In en, this message translates to:
  /// **'Commentators'**
  String get commentators;
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
