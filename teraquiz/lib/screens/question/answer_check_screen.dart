
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teraquiz/configs/themes/custom_text_styles.dart';
import 'package:teraquiz/controllers/questions_controller.dart';
import 'package:teraquiz/screens/question/result_screen.dart';
import 'package:teraquiz/widgets/common/background_decoration.dart';
import 'package:teraquiz/widgets/common/custom_app_bar.dart';
import 'package:teraquiz/widgets/content_area.dart';
import 'package:teraquiz/widgets/question/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionController>{
  const AnswerCheckScreen({Key? key}) : super(key: key);
 static const String routeName = "/answercheckscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(()=>Text('Q.${(controller.questionIndex.value+1)
            .toString().padLeft(1,"0")}',
          style: appBarTS,
        ),
        ) ,
        showActionIcon: true,
        onMenuActionTap: (){
              Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(()=>
        Column(
          children: [
            Expanded
            (child: ContentAread(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: Get.height*0.04),
              child: Column(
                children: [
                  Text(controller.currentQuestion.value!.question,style: questionTS,),

                  GetBuilder<QuestionController>(
                    id: 'answer_review_list',
                      builder: (_){
                      return ListView.separated(
                        shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 25),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index){
                          final answer = controller.currentQuestion.
                            value!.answers[index];
                         final selectedAnswer = controller
                              .currentQuestion.value!.selectedAnswer;
                         final correctAnswer = controller.currentQuestion
                          .value!.correctAnswer;

                         final String answerText = '${answer.identifier}. ${answer.answer}';
                         if(correctAnswer==selectedAnswer && answer.identifier==selectedAnswer){
                           return CorrectAnswer(answer: answerText);
                         }else if(selectedAnswer==null){
                          return NotAnswer(answer: answerText);
                         }else if(correctAnswer!=selectedAnswer && answer.identifier==selectedAnswer){
                           return WrongAnswer(answer:  answerText);
                         }else if(correctAnswer==answer.identifier){
                           return CorrectAnswer(answer: answerText);
                         }
                         return AnswerCard(answer: answerText, onTap: (){});

                          },
                          separatorBuilder: (_, index){
                          return const SizedBox(height: 10,);
                      },
                          itemCount: controller.currentQuestion.value!.answers.length );
                      }),

                ],
              ),
            ),
         )
            ),
          ],
        )),
      ),
    );
  }
}
