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
  String get matchStatusAbnormal => 'Abnormal';

  @override
  String get matchStatusNotStarted => 'Not Started';

  @override
  String get matchStatusFirstHalf => 'First Half';

  @override
  String get matchStatusHalfTime => 'Half-Time';

  @override
  String get matchStatusSecondHalf => 'Second Half';

  @override
  String get matchStatusOvertime => 'Overtime';

  @override
  String get matchStatusOvertimeDeprecated => 'Overtime (Deprecated)';

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
  String get matchStatusTbd => 'To be Determined';

  @override
  String get matchStatusUnknown => 'Unknown';
}
