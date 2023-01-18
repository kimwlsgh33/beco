class PomoLog {
  final String logId;
  final String uid;
  final String date;
  int totalCount;
  int totalFocus;
  int totalBreak;
  int totalRest;

  PomoLog({
    required this.logId,
    required this.uid,
    required this.date,
    required this.totalCount,
    required this.totalFocus,
    required this.totalBreak,
    required this.totalRest,
  });

  factory PomoLog.fromJson(Map<String, dynamic> json) {
    return PomoLog(
      logId: json['logId'],
      uid: json['uid'],
      date: json['date'],
      totalCount: json['totalCount'],
      totalFocus: json['totalFocus'],
      totalBreak: json['totalBreak'],
      totalRest: json['totalRest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logId': logId,
      'uid': uid,
      'date': date,
      'totalCount': totalCount,
      'totalFocus': totalFocus,
      'totalBreak': totalBreak,
      'totalRest': totalRest,
    };
  }
}
