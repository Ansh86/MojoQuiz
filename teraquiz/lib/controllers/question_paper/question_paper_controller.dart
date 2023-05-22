import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:teraquiz/controllers/auth_controller.dart';
import 'package:teraquiz/firebase_ref/references.dart';
import 'package:teraquiz/models/question_paper_model.dart';
import 'package:teraquiz/screens/question/question_screen.dart';
import 'package:teraquiz/services/app_logger.dart';
import 'package:teraquiz/services/firebase_storage_service.dart';

class QuestionPaperController extends GetxController{

  final allPaperImages = <String>[].obs;
  final allPapers= <QuestionPaperModel>[].obs;

  @override
  void onReady(){
    getAllPapers();
    super.onReady();
  }

 Future<void> getAllPapers() async {
    List<String> imgName=["biology", "chemistry", "maths","physics"];
    try{
      QuerySnapshot<Map<String,dynamic>> data = await questionPaperRf.get();
      final paperList =data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);
      for(var paper in paperList){
       final imgUrl= await Get.find<FirebaseStorageService>().getImage(paper.title);
       paper.imageUrl=imgUrl;
      }
      allPapers.assignAll(paperList);
    }catch(e){
      AppLogger.e(e);
    }
  }

  void navigateToQuestions({required QuestionPaperModel paper, bool tryAgain = false}){
    AuthController _authcontroller = Get.find();
    if(_authcontroller.isLogged()){
      if(tryAgain){
        Get.back();
        Get.toNamed(QuestionScreen.routeName, arguments: paper,preventDuplicates: false);
      }
      else{
        print('Logged in');
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    }
    else{
      _authcontroller.showLoginAlterDialogue();
    }
  }

}