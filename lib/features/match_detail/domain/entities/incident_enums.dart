enum MatchStatusChoices {
  abnormal(0),
  notStarted(1),
  firstHalf(2),
  halfTime(3),
  secondHalf(4),
  overtime(5),
  overtimeDeprecated(6),
  penaltyShootout(7),
  ended(8),
  delayed(9),
  interrupted(10),
  cutInHalf(11),
  cancelled(12),
  tbd(13),
  unknown(99);

  final int value;
  const MatchStatusChoices(this.value);

  static MatchStatusChoices fromValue(int? value) {
    if (value == null || value == 6) return MatchStatusChoices.unknown;
    return MatchStatusChoices.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MatchStatusChoices.unknown,
    );
  }
}

enum WeatherChoices {
  unknown(0),
  partiallyCloudy(1),
  cloudy(2),
  partiallyCloudyRain(3),
  snow(4),
  sunny(5),
  overcastRainThunderstorm(6),
  overcast(7),
  mist(8),
  overcastWithRain(9),
  cloudyWithRain(10),
  cloudyRainThunderstorm(11),
  cloudsRainThunderstormLocal(12),
  fog(13);

  final int value;
  const WeatherChoices(this.value);

  static WeatherChoices? fromValue(int? value) {
    if (value == null) return null;
    return WeatherChoices.values.firstWhere(
      (e) => e.value == value,
      orElse: () => WeatherChoices.unknown,
    );
  }
}

enum StatTypeChoices {
  unknown(0),
  goal(1),
  corner(2),
  yellowCard(3),
  redCard(4),
  offside(5),
  freeKick(6),
  goalKick(7),
  penalty(8),
  substitution(9),
  start(10),
  midfield(11),
  end(12),
  halftimeScore(13),
  cardUpgradeConfirmed(15),
  penaltyMissed(16),
  ownGoal(17),
  injuryTime(19),
  shotsOnTarget(21),
  shotsOffTarget(22),
  attacks(23),
  dangerousAttack(24),
  ballPossession(25),
  overtimeIsOver(26),
  penaltyKickEnded(27),
  varCheck(28),
  penaltyShootout(29),
  penaltyMissedShootout(30);

  final int value;
  const StatTypeChoices(this.value);
}

enum IncidentPositionChoices {
  neutral(0),
  home(1),
  away(2);

  final int value;
  const IncidentPositionChoices(this.value);
}

enum IncidentVARReasonChoices {
  other(0),
  goalAwarded(1),
  goalNotAwarded(2),
  penaltyAwarded(3),
  penaltyNotAwarded(4),
  redCardGiven(5),
  cardUpgrade(6),
  mistakenIdentity(7);

  final int value;
  const IncidentVARReasonChoices(this.value);
}

enum IncidentVARResultChoices {
  unknown(0),
  goalConfirmed(1),
  goalCancelled(2),
  penaltyConfirmed(3),
  penaltyCancelled(4),
  redCardConfirmed(5),
  redCardCancelled(6),
  cardUpgradeConfirmed(7),
  cardUpgradeCancelled(8),
  originalDecision(9),
  originalDecisionChanged(10);

  final int value;
  const IncidentVARResultChoices(this.value);
}

enum IncidentReasonTypeChoices {
  unknown(0),
  foul(1),
  professionalFoul(2),
  encroachmentOrInjurySub(3),
  tacticalFoulOrSub(4),
  recklessOffence(5),
  offBallFoul(6),
  persistentFouling(7),
  persistentInfringement(8),
  violentConduct(9),
  dangerousPlay(10),
  handball(11),
  seriousFoul(12),
  professionalFoulLastMan(13),
  deniedGoalScoringOpportunity(14),
  timeWasting(15),
  videoSyncDone(16),
  rescindedCard(17),
  argument(18),
  dissent(19),
  foulAndAbusiveLanguage(20),
  excessiveCelebration(21),
  notRetreating(22),
  fight(23),
  extraFlagToChecker(24),
  onBench(25),
  postMatch(26),
  otherReason(27),
  unallowedFieldEntering(28),
  enteringField(29),
  leavingField(30),
  unsportingBehaviour(31),
  notVisible(32),
  flop(33),
  excessiveUsageOfReviewSignal(34),
  enteringRefereeReviewArea(35),
  spitting(36),
  viral(37);

  final int value;
  const IncidentReasonTypeChoices(this.value);
}

enum PlayerPositionChoices {
  forward('F'),
  midfielder('M'),
  defender('D'),
  goalkeeper('G'),
  unknown('U');

  final String value;
  const PlayerPositionChoices(this.value);

  static PlayerPositionChoices fromValue(String? value) {
    if (value != null) {
      final upperValue = value.toUpperCase();
      return PlayerPositionChoices.values.firstWhere(
        (e) => e.value == upperValue,
        orElse: () => PlayerPositionChoices.unknown,
      );
    }
    return PlayerPositionChoices.unknown;
  }
}

enum TeamSideChoices {
  home(1),
  away(2);

  final int value;
  const TeamSideChoices(this.value);
}

enum InjuryTypeChoices {
  unknown(0),
  injured(1),
  suspended(2),
  questionable(3);

  final int value;
  const InjuryTypeChoices(this.value);

  static InjuryTypeChoices fromValue(int? value) {
    if (value == null) return InjuryTypeChoices.unknown;
    return InjuryTypeChoices.values.firstWhere(
      (e) => e.value == value,
      orElse: () => InjuryTypeChoices.unknown,
    );
  }
}
