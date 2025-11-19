// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Admin Panel';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get home => 'Dashboard';

  @override
  String get welcome => 'Welcome, Admin!';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailHint => 'Enter your email address';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get loginCredentials => 'Login with your credentials';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get settings => 'Settings';

  @override
  String get competitionSelect => 'Competition Select';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get saveOrder => 'Save Order';

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
  String get loginError => 'Login failed. Please check your credentials.';

  @override
  String get overview => 'Overview';

  @override
  String get matches => 'Matches';

  @override
  String get matchesTiles => 'Tiles View';

  @override
  String get matchesList => 'Matches List';

  @override
  String get live => 'Live';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get yesterday => 'Yesterday';

  @override
  String inXDays(Object count) {
    return 'In $count days';
  }

  @override
  String xDaysAgo(Object count) {
    return '$count days ago';
  }

  @override
  String get calendar => 'Calendar';

  @override
  String get search => 'Search';

  @override
  String get sortByImportance => 'Importance';

  @override
  String get sortByTime => 'Time';

  @override
  String get liveFilter => 'Live';

  @override
  String get matchStatusAbnormal => 'Abn';

  @override
  String get matchStatusNotStarted => 'NS';

  @override
  String get matchStatusFirstHalf => '1H';

  @override
  String get matchStatusHalfTime => 'HT';

  @override
  String get matchStatusSecondHalf => '2H';

  @override
  String get matchStatusOvertime => 'ET';

  @override
  String get matchStatusOvertimeDeprecated => 'ET';

  @override
  String get matchStatusPenaltyShootout => 'Pen';

  @override
  String get matchStatusEnded => 'FT';

  @override
  String get matchStatusDelayed => 'Dly';

  @override
  String get matchStatusInterrupted => 'Int';

  @override
  String get matchStatusCutInHalf => 'Cut';

  @override
  String get matchStatusCancelled => 'Canc';

  @override
  String get matchStatusTbd => 'TBD';

  @override
  String get matchStatusUnknown => '?';

  @override
  String get addNewCompetition => 'Add New Competition';

  @override
  String get enterCompetitionId => 'Enter Competition ID';

  @override
  String get pleaseEnterCompetitionId => 'Please enter competition ID';

  @override
  String get competitionId => 'Competition ID';

  @override
  String get add => 'Add';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get typeToSearch => 'Type to search...';

  @override
  String get searchCompetition => 'Search Competition';
}
