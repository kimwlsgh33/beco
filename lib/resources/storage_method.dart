import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 프로필, 포스팅 이미지 업로드
  Future<String> uploadImageToStorage({
    required String childName,
    required Uint8List file,
    required bool isPost,
  }) async {
    // ref() : storage의 root directory를 참조(point)
    // child() : storage의 하위 directory를 참조(point) / 업로드할 폴더 경로
    // putData() : storage에 데이터를 업로드
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // root/childName/uid

    // 만약에 포스트라면, 포스트의 고유 id를 파일 이름으로 사용
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
      // root/childName/uid/id
    }

    // putData() : storage에 데이터를 업로드 ( putFile() : storage에 파일을 업로드 - File 클래스로 바꿔야해서 사용하지 않음 )
    // UploadTask : 업로드 작업을 추적하는 클래스
    UploadTask uploadTask = ref.putData(file);

    // uploadTask.snapshot : 업로드 작업의 현재 상태를 나타내는 객체
    TaskSnapshot snap = await uploadTask;

    // snap.ref.getDownloadURL() : 업로드한 파일의 다운로드 URL을 가져옴 ( 이미지 소스로 사용 )
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
