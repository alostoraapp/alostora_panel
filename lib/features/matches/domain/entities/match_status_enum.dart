enum MatchStatus {
  abnormal,
  notStarted,
  firstHalf,
  halfTime,
  secondHalf,
  overtime,
  overtimeDeprecated,
  penaltyShootout,
  ended,
  delayed,
  interrupted,
  cutInHalf,
  cancelled,
  tbd,
  unknown;

  static MatchStatus fromStatusCode(int code) {
    switch (code) {
      case 0:
        return MatchStatus.abnormal;
      case 1:
        return MatchStatus.notStarted;
      case 2:
        return MatchStatus.firstHalf;
      case 3:
        return MatchStatus.halfTime;
      case 4:
        return MatchStatus.secondHalf;
      case 5:
        return MatchStatus.overtime;
      case 6:
        return MatchStatus.overtimeDeprecated;
      case 7:
        return MatchStatus.penaltyShootout;
      case 8:
        return MatchStatus.ended;
      case 9:
        return MatchStatus.delayed;
      case 10:
        return MatchStatus.interrupted;
      case 11:
        return MatchStatus.cutInHalf;
      case 12:
        return MatchStatus.cancelled;
      case 13:
        return MatchStatus.tbd;
      case 99:
      default:
        return MatchStatus.unknown;
    }
  }
}
