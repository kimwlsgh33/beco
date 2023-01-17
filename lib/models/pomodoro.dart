class Pomodoro {
  final String pomodoroId;
  final String uid;
  final int focusTime; // 나에게 맞는 집중시간
  final int breakTime; // 나에게 맞는 휴식시간
  final int totalPomodoros; // 완수한 pomodoro의 수
  final int totalSeconds; // 완수한 전체 시간

  Pomodoro({
    required this.pomodoroId,
    required this.uid,
    required this.focusTime,
    required this.breakTime,
    required this.totalPomodoros,
    required this.totalSeconds,
  }); 

  factory Pomodoro.fromJson(Map<String, dynamic> json) {
    return Pomodoro(
      pomodoroId: json['pomodoroId'],
      uid: json['uid'],
      focusTime: json['focusTime'],
      breakTime: json['breakTime'],
      totalPomodoros: json['totalPomodoros'],
      totalSeconds: json['totalSeconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pomodoroId': pomodoroId,
      'uid': uid,
      'focusTime': focusTime,
      'breakTime': breakTime,
      'totalPomodoros': totalPomodoros,
      'totalSeconds': totalSeconds,
    };
  }
}
