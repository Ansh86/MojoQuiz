import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

final fireStore = FirebaseFirestore.instance;
Reference get firebaseStorage => FirebaseStorage.instance.ref();

final userRF = fireStore.collection("users");

final questionPaperRf = fireStore.collection('questionPapers');

DocumentReference questionRF({
  required String paperId,
required String questionId,
})=>questionPaperRf.doc(paperId).collection("questions").doc(questionId);