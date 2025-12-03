// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Al Ostora Panel';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get login => 'Login';

  @override
  String get loginError => 'Login failed. Please check your credentials.';

  @override
  String get loginCredentials => 'Enter your credentials to login';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get logout => 'Logout';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get overview => 'Overview';

  @override
  String get totalUsers => 'Total Users';

  @override
  String get onlineUsers => 'Online Users';

  @override
  String get todaysMatches => 'Today\'s Matches';

  @override
  String get liveMatches => 'Live Matches';

  @override
  String get tomorrowsMatches => 'Tomorrow\'s Matches';

  @override
  String get thisWeeksMatches => 'This Week\'s Matches';

  @override
  String get matches => 'Matches';

  @override
  String get matchesTiles => 'Matches (Tiles)';

  @override
  String get matchesList => 'Matches (List)';

  @override
  String get settings => 'Settings';

  @override
  String get competitionSelect => 'Select Competitions';

  @override
  String get active => 'Active';

  @override
  String get addNewCompetition => 'Add New Competition';

  @override
  String get competitionId => 'Competition ID';

  @override
  String get pleaseEnterCompetitionId => 'Please enter a competition ID';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deleteCompetition => 'Delete Competition';

  @override
  String get deleteCompetitionConfirmation => 'Are you sure you want to delete this competition?';

  @override
  String get searchCompetition => 'Search for a competition';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get typeToSearch => 'Type to search';

  @override
  String get matchStatusAbnormal => 'Abnormal';

  @override
  String get matchStatusNotStarted => 'Not Started';

  @override
  String get matchStatusFirstHalf => '1st Half';

  @override
  String get matchStatusHalfTime => 'Half Time';

  @override
  String get matchStatusSecondHalf => '2nd Half';

  @override
  String get matchStatusOvertime => 'Overtime';

  @override
  String get matchStatusOvertimeDeprecated => 'Extra Time';

  @override
  String get matchStatusPenaltyShootout => 'Penalties';

  @override
  String get matchStatusEnded => 'Ended';

  @override
  String get matchStatusDelayed => 'Delayed';

  @override
  String get matchStatusInterrupted => 'Interrupted';

  @override
  String get matchStatusCutInHalf => 'Cut in Half';

  @override
  String get matchStatusCancelled => 'Cancelled';

  @override
  String get matchStatusTBD => 'To Be Defined';

  @override
  String get matchStatusUnknown => 'Unknown Status';

  @override
  String get bestPlayer => 'Best Player';

  @override
  String get highlights => 'Highlights';

  @override
  String get events => 'Events';

  @override
  String get live => 'Live';

  @override
  String get details => 'Details';

  @override
  String get onThePitch => 'On the Pitch';

  @override
  String get onTheBench => 'On the Bench';

  @override
  String get unknownPlayer => 'Unknown Player';

  @override
  String get confirmMOTMTitle => 'Confirm Man of the Match';

  @override
  String confirmMOTMMessage(String playerName) {
    return 'Are you sure you want to set $playerName as the Man of the Match?';
  }

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get noDataFound => 'No Data Found';

  @override
  String get penalties => 'Penalties';

  @override
  String get overtime => 'Overtime';

  @override
  String get secondHalf => 'Second Half';

  @override
  String get firstHalf => 'First Half';

  @override
  String get ownGoal => '(Own Goal)';

  @override
  String get penaltyMissed => '(Penalty Missed)';

  @override
  String get varCheck => 'VAR Check';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get yesterday => 'Yesterday';

  @override
  String inXDays(int count) {
    return 'In $count days';
  }

  @override
  String xDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get liveFilter => 'Live';

  @override
  String get search => 'Search...';

  @override
  String get sortByImportance => 'Sort by Importance';

  @override
  String get sortByTime => 'Sort by Time';

  @override
  String get noMatchesFound => 'No Matches Found';

  @override
  String get importantEvents => 'Important';

  @override
  String get refresh => 'Refresh';

  @override
  String get mediaUrl => 'Media URL';

  @override
  String get mediaCover => 'Media Cover';

  @override
  String get videoTime => 'Video Time (seconds)';

  @override
  String get editIncidentMedia => 'Edit Incident Media';

  @override
  String get sendNotification => 'Send Notification';

  @override
  String get sendNotificationSubtitle => 'If enabled, priority will be set to Urgent.';

  @override
  String get approve => 'Approve';

  @override
  String get incidentApproved => 'Incident Approved';

  @override
  String get requestSent => 'Request sent';

  @override
  String get highlightTypeSummary => 'Summary';

  @override
  String get highlightTypeGoals => 'Goals';

  @override
  String get highlightTypeFullMatch => 'Full Match';

  @override
  String get highlightTypePenalties => 'Penalties';

  @override
  String get highlightTypeCelebration => 'Celebration';

  @override
  String get highlightTypeOther => 'Other';

  @override
  String get highlightStatusDraft => 'Draft';

  @override
  String get highlightStatusPendingApproval => 'Pending Approval';

  @override
  String get highlightStatusPublished => 'Published';

  @override
  String get highlightPriorityNormal => 'Normal';

  @override
  String get highlightPriorityImportant => 'Important (No Notification)';

  @override
  String get highlightPriorityUrgent => 'Urgent (With Notification)';

  @override
  String get highlightType => 'Type';

  @override
  String get highlightPriority => 'Priority';

  @override
  String get highlightStatus => 'Status';

  @override
  String errorPickingImage(String error) {
    return 'Error picking image: $error';
  }

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get hours => 'Hours';

  @override
  String get minutes => 'Minutes';

  @override
  String get seconds => 'Seconds';

  @override
  String get addMedia => 'Add Media';

  @override
  String get editMedia => 'Edit Media';

  @override
  String get lineup => 'Lineup';

  @override
  String get matchDetails => 'Match Details';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformX => 'X (Twitter)';

  @override
  String get platformFacebook => 'Facebook';

  @override
  String get platformOfficial => 'Official Website';

  @override
  String get platformOther => 'Other';

  @override
  String get addBroadcast => 'Add Broadcast';

  @override
  String get editBroadcast => 'Edit Broadcast';

  @override
  String get platform => 'Platform';

  @override
  String get tvChannel => 'TV Channel';

  @override
  String get url => 'URL';

  @override
  String get pleaseSelectTvChannel => 'Please select a TV Channel';

  @override
  String get pleaseSelectPlatform => 'Please select a Platform';

  @override
  String get pleaseEnterUrl => 'Please enter URL';

  @override
  String get deleteBroadcast => 'Delete Broadcast';

  @override
  String get deleteBroadcastConfirmation => 'Are you sure you want to delete this broadcast?';

  @override
  String get tvChannels => 'TV Channels';

  @override
  String get commentators => 'Commentators';

  @override
  String get deleteTvChannel => 'Delete TV Channel';

  @override
  String get deleteTvChannelConfirmation => 'Are you sure you want to delete this TV channel?';

  @override
  String get deleteCommentator => 'Delete Commentator';

  @override
  String get deleteCommentatorConfirmation => 'Are you sure you want to delete this commentator?';
}
