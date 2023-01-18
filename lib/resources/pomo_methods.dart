import 'package:beco/models/pomo_log.dart';
import 'package:beco/models/pomodoro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class PomoMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> initPomodoro(
    String uid,
  ) async {
    String res = "Something went wrong";
    try {
      String pomodoroId = const Uuid().v1();
      Pomodoro pomodoro = Pomodoro(
        pomodoroId: pomodoroId,
        uid: uid,
        focusTime: 1500,
        breakTime: 900,
      );
      // set vs update : set은 전체를 덮어쓰고, update는 일부만 업데이트
      await _firestore.collection("pomodoros").doc(pomodoroId).set(
            pomodoro.toJson(),
          );
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<Pomodoro> getPomodoros(String uid) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("pomodoros")
        .where("uid", isEqualTo: uid)
        .get();

    Pomodoro pomodoro = Pomodoro.fromSnap(querySnapshot.docs[0].data());
    return pomodoro;
  }

  Future<String> addPomoLog({
    required String uid,
    required int totalFocus,
  }) async {
    String res = "Something went wrong";
    DateTime now = DateTime.now();
    try {
      String logId = Uuid().v1();
      await _firestore.collection("pomodoros").doc(uid).collection("logs").add({
        "logId": logId,
        'uid': uid,
        'date': "${now.year}-${now.month}-${now.day}",
        'totalCount': 1,
        'totalFocus': totalFocus,
        'totalBreak': 0,
      });
      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<PomoLog> getTodaysLog() async {
    DateTime now = DateTime.now();
    var snap = await _firestore
        .collection("pomodoros")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("logs")
        .where("date", isEqualTo: "${now.year}-${now.month}-${now.day}")
        .get();

    return PomoLog.fromJson(snap.docs.first.data());
  }

  Future<String> updatePomoLog({
    required String uid,
    required int time,
    bool isFocus = true,
  }) async {
    String res = "Something went wrong";
    try {
      QuerySnapshot snap = await _firestore
          .collection('pomodoros')
          .where('uid', isEqualTo: uid)
          .get();
      if (snap.docs.isNotEmpty) {
        DocumentSnapshot doc = snap.docs.first;
        PomoLog log = PomoLog.fromJson(doc.data() as Map<String, dynamic>);
        if (isFocus) {
          log.totalFocus += time;
        } else {
          log.totalBreak += time;
        }
        await doc.reference.update(log.toJson());
        res = "Success";
      } else {
        res = "No log found";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
