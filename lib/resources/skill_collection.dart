import 'package:beco/models/skill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SkillCollection {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addSkill(Skill skill) async {
    String res = "Something went wrong";
    try {
      final snap = await _firestore
          .collection('skills')
          .where('name', isEqualTo: skill.name)
          .get();

      if (snap.docs.isEmpty) {
        await _firestore.collection('skills').add(skill.toJson());
        res = "success";
      } else {
        res = "Skill already exists";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
