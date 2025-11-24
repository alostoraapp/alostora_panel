// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Alostora Panel';

  @override
  String get login => 'Login';

  @override
  String get loginCredentials => 'Login with your credentials';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get loginError => 'Invalid credentials. Please try again.';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get matches => 'Matches';

  @override
  String get matchDetails => 'Match Details';

  @override
  String get matchTime => 'Match Time';

  @override
  String get matchStatus => 'Match Status';

  @override
  String get matchActions => 'Match Actions';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get search => 'Search';

  @override
  String get logout => 'Logout';

  @override
  String get settings => 'Settings';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get home => 'Home';

  @override
  String get away => 'Away';

  @override
  String get team => 'Team';

  @override
  String get teams => 'Teams';

  @override
  String get player => 'Player';

  @override
  String get players => 'Players';

  @override
  String get competition => 'Competition';

  @override
  String get competitions => 'Competitions';

  @override
  String get channel => 'Channel';

  @override
  String get channels => 'Channels';

  @override
  String get broadcaster => 'Broadcaster';

  @override
  String get broadcasters => 'Broadcasters';

  @override
  String get name => 'Name';

  @override
  String get shortName => 'Short Name';

  @override
  String get displayName => 'Display Name';

  @override
  String get logo => 'Logo';

  @override
  String get country => 'Country';

  @override
  String get successTitle => 'Success';

  @override
  String get errorTitle => 'Error';

  @override
  String get confirmTitle => 'Confirm';

  @override
  String get deleteConfirmation => 'Are you sure you want to delete this item?';

  @override
  String get saveChangesSuccess => 'Changes saved successfully.';

  @override
  String get addSuccess => 'Added successfully.';

  @override
  String get deleteSuccess => 'Deleted successfully.';

  @override
  String get anErrorOccurred => 'An error occurred. Please try again.';

  @override
  String get selectCompetition => 'Select Competition';

  @override
  String get selectTeam => 'Select Team';

  @override
  String get selectBroadcaster => 'Select Broadcaster';

  @override
  String get selectChannel => 'Select Channel';

  @override
  String get noOptions => 'No options available';

  @override
  String get homeTeam => 'Home Team';

  @override
  String get awayTeam => 'Away Team';

  @override
  String get competitionConfig => 'Competition Config';

  @override
  String get visible => 'Visible';

  @override
  String get hidden => 'Hidden';

  @override
  String get bestPlayer => 'Best Player';

  @override
  String get summary => 'Summary';

  @override
  String get stats => 'Stats';

  @override
  String get h2h => 'H2H';

  @override
  String get standings => 'Standings';

  @override
  String get onThePitch => 'On the Pitch';

  @override
  String get onTheBench => 'On the Bench';

  @override
  String get confirmMOTMTitle => 'Confirm Man of the Match';

  @override
  String confirmMOTMMessage(String playerName) {
    return 'Are you sure you want to select $playerName as the Man of the Match?';
  }

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get unknownPlayer => 'Unknown Player';

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
  String get sortByImportance => 'Sort by Importance';

  @override
  String get sortByTime => 'Sort by Time';

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
  String get competitionSelect => 'Competition Select';

  @override
  String get active => 'Active';

  @override
  String get addNewCompetition => 'Add New Competition';

  @override
  String get competitionId => 'Competition ID';

  @override
  String get pleaseEnterCompetitionId => 'Please enter a competition ID';

  @override
  String get deleteCompetition => 'Delete Competition';

  @override
  String get deleteCompetitionConfirmation => 'Are you sure you want to delete this competition configuration?';

  @override
  String get overview => 'Overview';

  @override
  String get matchesTiles => 'Matches (Tiles)';

  @override
  String get matchesList => 'Matches (List)';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get typeToSearch => 'Type to search for competitions';

  @override
  String get searchCompetition => 'Search Competition';

  @override
  String get matchStatusAbnormal => 'Abnormal';

  @override
  String get matchStatusNotStarted => 'Not Started';

  @override
  String get matchStatusFirstHalf => 'First Half';

  @override
  String get matchStatusHalfTime => 'Half Time';

  @override
  String get matchStatusSecondHalf => 'Second Half';

  @override
  String get matchStatusOvertime => 'Overtime';

  @override
  String get matchStatusOvertimeDeprecated => 'Overtime';

  @override
  String get matchStatusPenaltyShootout => 'Penalty Shootout';

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
  String get matchStatusTBD => 'To Be Determined';

  @override
  String get matchStatusUnknown => 'Unknown';
}
