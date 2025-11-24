// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get alostora => 'Alostora';

  @override
  String get appName => 'Alostora Panel';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get matches => 'Matches';

  @override
  String get match => 'Match';

  @override
  String get overview => 'Overview';

  @override
  String get settings => 'Settings';

  @override
  String get search => 'Search';

  @override
  String get searchHint => 'Search for teams, leagues, or matches...';

  @override
  String get live => 'Live';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get finished => 'Finished';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get noMatchesToday => 'No matches scheduled for today.';

  @override
  String get noMatchesYesterday => 'No matches were played yesterday.';

  @override
  String get noMatchesTomorrow => 'No matches scheduled for tomorrow.';

  @override
  String get noLiveMatches => 'No live matches at the moment.';

  @override
  String get noUpcomingMatches => 'No upcoming matches in the selected date.';

  @override
  String get noFinishedMatches => 'No matches finished in the selected date.';

  @override
  String get failedToLoadMatches => 'Failed to load matches.';

  @override
  String get retry => 'Retry';

  @override
  String get leagues => 'Leagues';

  @override
  String get matchDetail => 'Match Detail';

  @override
  String get summary => 'Summary';

  @override
  String get lineUp => 'Line-up';

  @override
  String get stats => 'Stats';

  @override
  String get h2h => 'H2H';

  @override
  String get standings => 'Standings';

  @override
  String get chat => 'Chat';

  @override
  String get odds => 'Odds';

  @override
  String get about => 'About';

  @override
  String get incidents => 'Incidents';

  @override
  String get referee => 'Referee';

  @override
  String get stadium => 'Stadium';

  @override
  String get capacity => 'Capacity';

  @override
  String get shakingHands => 'Shaking Hands';

  @override
  String get heads => 'Heads';

  @override
  String get tails => 'Tails';

  @override
  String get selectCoin => 'Select Coin';

  @override
  String get toss => 'Toss';

  @override
  String get home => 'Home';

  @override
  String get away => 'Away';

  @override
  String get bestPlayer => 'Best Player';

  @override
  String get onThePitch => 'On the pitch';

  @override
  String get onTheBench => 'On the bench';

  @override
  String get highlights => 'Highlights';

  @override
  String get events => 'Events';

  @override
  String get media => 'Media';

  @override
  String get details => 'Details';

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
  String get changeTheme => 'Change Theme';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get logout => 'Logout';

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
  String get matchesTiles => 'Matches Tiles';

  @override
  String get matchesList => 'Matches List';

  @override
  String get addNewCompetition => 'Add New Competition';

  @override
  String get competitionId => 'Competition ID';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get pleaseEnterCompetitionId => 'Please enter a competition ID';

  @override
  String get deleteCompetition => 'Delete Competition';

  @override
  String get deleteCompetitionConfirmation => 'Are you sure you want to delete this competition?';

  @override
  String get delete => 'Delete';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get typeToSearch => 'Type to search for competitions';

  @override
  String get searchCompetition => 'Search Competition';

  @override
  String inXDays(int days) {
    return 'In $days days';
  }

  @override
  String xDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get liveFilter => 'Live';

  @override
  String get sortByImportance => 'Sort by Importance';

  @override
  String get sortByTime => 'Sort by Time';

  @override
  String get matchStatusAbnormal => 'Abnormal';

  @override
  String get matchStatusNotStarted => 'Not started';

  @override
  String get matchStatusFirstHalf => 'First half';

  @override
  String get matchStatusHalfTime => 'Half-time';

  @override
  String get matchStatusSecondHalf => 'Second half';

  @override
  String get matchStatusOvertime => 'Overtime';

  @override
  String get matchStatusOvertimeDeprecated => 'Overtime (deprecated)';

  @override
  String get matchStatusPenaltyShootout => 'Penalty Shoot-out';

  @override
  String get matchStatusEnded => 'End';

  @override
  String get matchStatusDelayed => 'Delayed';

  @override
  String get matchStatusInterrupted => 'Interrupted';

  @override
  String get matchStatusCutInHalf => 'Cut in half';

  @override
  String get matchStatusCancelled => 'Cancelled';

  @override
  String get matchStatusTBD => 'To be determined';

  @override
  String get matchStatusUnknown => 'Unknown';

  @override
  String get weatherUnknown => 'Unknown';

  @override
  String get weatherPartiallyCloudy => 'Partially cloudy';

  @override
  String get weatherCloudy => 'Cloudy';

  @override
  String get weatherPartiallyCloudyRain => 'Partially cloudy/rain';

  @override
  String get weatherSnow => 'Snow';

  @override
  String get weatherSunny => 'Sunny';

  @override
  String get weatherOvercastRainThunderstorm => 'Overcast Rain/partial thunderstorm';

  @override
  String get weatherOvercast => 'Overcast';

  @override
  String get weatherMist => 'Mist';

  @override
  String get weatherOvercastWithRain => 'Overcast with rain';

  @override
  String get weatherCloudyWithRain => 'Cloudy with rain';

  @override
  String get weatherCloudyRainThunderstorm => 'Cloudy with rain/partial Thunderstorms';

  @override
  String get weatherCloudsRainThunderstormLocal => 'Clouds/rains and thunderstorms locally';

  @override
  String get weatherFog => 'Fog';

  @override
  String get statTypeUnknown => 'Unknown';

  @override
  String get statTypeGoal => 'Goal';

  @override
  String get statTypeCorner => 'Corner';

  @override
  String get statTypeYellowCard => 'Yellow card';

  @override
  String get statTypeRedCard => 'Red card';

  @override
  String get statTypeOffside => 'Offside';

  @override
  String get statTypeFreeKick => 'Free kick';

  @override
  String get statTypeGoalKick => 'Goal kick';

  @override
  String get statTypePenalty => 'Penalty';

  @override
  String get statTypeSubstitution => 'Substitution';

  @override
  String get statTypeStart => 'Start';

  @override
  String get statTypeMidfield => 'Midfield';

  @override
  String get statTypeEnd => 'End';

  @override
  String get statTypeHalftimeScore => 'Halftime score';

  @override
  String get statTypeCardUpgradeConfirmed => 'Card upgrade confirmed';

  @override
  String get statTypePenaltyMissed => 'Penalty missed';

  @override
  String get statTypeOwnGoal => 'Own goal';

  @override
  String get statTypeInjuryTime => 'Injury time';

  @override
  String get statTypeShotsOnTarget => 'Shots on target';

  @override
  String get statTypeShotsOffTarget => 'Shots off target';

  @override
  String get statTypeAttacks => 'Attacks';

  @override
  String get statTypeDangerousAttack => 'Dangerous Attack';

  @override
  String get statTypeBallPossession => 'Ball possession';

  @override
  String get statTypeOvertimeIsOver => 'Overtime is over';

  @override
  String get statTypePenaltyKickEnded => 'Penalty kick ended';

  @override
  String get statTypeVAR => 'VAR';

  @override
  String get statTypePenaltyShootout => 'Penalty (Penalty Shoot-out)';

  @override
  String get statTypePenaltyMissedShootout => 'Penalty missed (Penalty Shoot-out)';

  @override
  String get incidentPositionNeutral => 'Neutral';

  @override
  String get incidentPositionHome => 'Home';

  @override
  String get incidentPositionAway => 'Away';

  @override
  String get incidentVARReasonOther => 'Other';

  @override
  String get incidentVARReasonGoalAwarded => 'Goal awarded';

  @override
  String get incidentVARReasonGoalNotAwarded => 'Goal not awarded';

  @override
  String get incidentVARReasonPenaltyAwarded => 'Penalty awarded';

  @override
  String get incidentVARReasonPenaltyNotAwarded => 'Penalty not awarded';

  @override
  String get incidentVARReasonRedCardGiven => 'Red card given';

  @override
  String get incidentVARReasonCardUpgrade => 'Card upgrade';

  @override
  String get incidentVARReasonMistakenIdentity => 'Mistaken identity';

  @override
  String get incidentVARResultUnknown => 'Unknown';

  @override
  String get incidentVARResultGoalConfirmed => 'Goal confirmed';

  @override
  String get incidentVARResultGoalCancelled => 'Goal cancelled';

  @override
  String get incidentVARResultPenaltyConfirmed => 'Penalty confirmed';

  @override
  String get incidentVARResultPenaltyCancelled => 'Penalty cancelled';

  @override
  String get incidentVARResultRedCardConfirmed => 'Red card confirmed';

  @override
  String get incidentVARResultRedCardCancelled => 'Red card cancelled';

  @override
  String get incidentVARResultCardUpgradeConfirmed => 'Card upgrade confirmed';

  @override
  String get incidentVARResultCardUpgradeCancelled => 'Card upgrade cancelled';

  @override
  String get incidentVARResultOriginalDecision => 'Original decision';

  @override
  String get incidentVARResultOriginalDecisionChanged => 'Original decision changed';

  @override
  String get incidentReasonTypeUnknown => 'Unknown';

  @override
  String get incidentReasonTypeFoul => 'Foul';

  @override
  String get incidentReasonTypeProfessionalFoul => 'Professional foul';

  @override
  String get incidentReasonTypeEncroachmentOrInjurySub => 'Encroachment / Injury substitution';

  @override
  String get incidentReasonTypeTacticalFoulOrSub => 'Tactical Foul / Tactical substitution';

  @override
  String get incidentReasonTypeRecklessOffence => 'Reckless Offence';

  @override
  String get incidentReasonTypeOffBallFoul => 'Off the ball foul';

  @override
  String get incidentReasonTypePersistentFouling => 'Persistent fouling';

  @override
  String get incidentReasonTypePersistentInfringement => 'Persistent Infringement';

  @override
  String get incidentReasonTypeViolentConduct => 'Violent conduct';

  @override
  String get incidentReasonTypeDangerousPlay => 'Dangerous play';

  @override
  String get incidentReasonTypeHandball => 'Handball';

  @override
  String get incidentReasonTypeSeriousFoul => 'Serious Foul';

  @override
  String get incidentReasonTypeProfessionalFoulLastMan => 'Professional foul last man';

  @override
  String get incidentReasonTypeDeniedGoalScoringOpportunity => 'Denied goal-scoring opportunity';

  @override
  String get incidentReasonTypeTimeWasting => 'Time wasting';

  @override
  String get incidentReasonTypeVideoSyncDone => 'Video sync done';

  @override
  String get incidentReasonTypeRescindedCard => 'Rescinded Card';

  @override
  String get incidentReasonTypeArgument => 'Argument';

  @override
  String get incidentReasonTypeDissent => 'Dissent';

  @override
  String get incidentReasonTypeFoulAndAbusiveLanguage => 'Foul and Abusive Language';

  @override
  String get incidentReasonTypeExcessiveCelebration => 'Excessive celebration';

  @override
  String get incidentReasonTypeNotRetreating => 'Not Retreating';

  @override
  String get incidentReasonTypeFight => 'Fight';

  @override
  String get incidentReasonTypeExtraFlagToChecker => 'Extra flag to checker';

  @override
  String get incidentReasonTypeOnBench => 'On bench';

  @override
  String get incidentReasonTypePostMatch => 'Post match';

  @override
  String get incidentReasonTypeOtherReason => 'Other reason';

  @override
  String get incidentReasonTypeUnallowedFieldEntering => 'Unallowed field entering';

  @override
  String get incidentReasonTypeEnteringField => 'Entering field';

  @override
  String get incidentReasonTypeLeavingField => 'Leaving field';

  @override
  String get incidentReasonTypeUnsportingBehaviour => 'Unsporting behaviour';

  @override
  String get incidentReasonTypeNotVisible => 'Not visible';

  @override
  String get incidentReasonTypeFlop => 'Flop';

  @override
  String get incidentReasonTypeExcessiveUsageOfReviewSignal => 'Excessive usage of review signal';

  @override
  String get incidentReasonTypeEnteringRefereeReviewArea => 'Entering referee review area';

  @override
  String get incidentReasonTypeSpitting => 'Spitting';

  @override
  String get incidentReasonTypeViral => 'Viral';

  @override
  String get playerPositionForward => 'Forward';

  @override
  String get playerPositionMidfielder => 'Midfielder';

  @override
  String get playerPositionDefender => 'Defender';

  @override
  String get playerPositionGoalkeeper => 'Goalkeeper';

  @override
  String get playerPositionUnknown => 'Unknown';

  @override
  String get teamSideHome => 'Home';

  @override
  String get teamSideAway => 'Away';

  @override
  String get injuryTypeUnknown => 'Unknown';

  @override
  String get injuryTypeInjured => 'Injured';

  @override
  String get injuryTypeSuspended => 'Suspended';

  @override
  String get injuryTypeQuestionable => 'Questionable';
}
