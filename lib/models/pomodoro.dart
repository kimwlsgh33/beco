// 사용자의 최적의 집중시간, 휴식시간
class Pomodoro {
  final String pomodoroId;
  final String uid;
  final int focusTime; // 나에게 맞는 집중시간
  final int breakTime; // 나에게 맞는 휴식시간

  Pomodoro({
    required this.pomodoroId,
    required this.uid,
    required this.focusTime,
    required this.breakTime,
  }); 

  factory Pomodoro.fromJson(Map<String, dynamic> json) {
    return Pomodoro(
      pomodoroId: json['pomodoroId'],
      uid: json['uid'],
      focusTime: json['focusTime'],
      breakTime: json['breakTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pomodoroId': pomodoroId,
      'uid': uid,
      'focusTime': focusTime,
      'breakTime': breakTime,
    };
  }

  factory Pomodoro.fromSnap(snap) {

    var json = snap as Map<String, dynamic>;

    return Pomodoro(
      pomodoroId: json['pomodoroId'],
      uid: json['uid'],
      focusTime: json['focusTime'],
      breakTime: json['breakTime'],
    );
  }

  @override
  String toString() {
    return 'Pomodoro(pomodoroId: $pomodoroId, uid: $uid, focusTime: $focusTime, breakTime: $breakTime)';
  }
}
