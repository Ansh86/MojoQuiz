
import 'package:flutter/material.dart';
import 'package:teraquiz/configs/themes/app_colors.dart';
import 'package:teraquiz/configs/themes/custom_text_styles.dart';
import 'package:teraquiz/configs/themes/ui_parameters.dart';
import 'package:teraquiz/controllers/questions_controller.dart';
import 'package:teraquiz/firebase_ref/loading_status.dart';
import 'package:teraquiz/screens/question/test_overview.dart';
import 'package:teraquiz/widgets/common/background_decoration.dart';
import 'package:get/get.dart';
import 'package:teraquiz/widgets/common/custom_app_bar.dart';
import 'package:teraquiz/widgets/common/main_button.dart';
import 'package:teraquiz/widgets/common/question_place_holder.dart';
import 'package:teraquiz/widgets/content_area.dart';
import 'package:teraquiz/widgets/question/answer_card.dart';
import 'package:teraquiz/widgets/question/countdown_timer.dart';
class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({Key? key}) : super(key: key);

  static const String routeName= "/questionScreen";

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  CustomAppBar(
       leading: Container(
         padding:const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
         decoration: const ShapeDecoration(
           shape: StadiumBorder(
             side: BorderSide(color: onSurfaceTextColor,width: 2),
           )
         ),
         child: Obx(()=>CountDownTimer(
              color: onSurfaceTextColor,
             time: controller.time.value)),
       ),
        showActionIcon: true,
        titleWidget: Obx(()=>Text('Q. ${(controller.questionIndex.value+1).
        toString().padLeft(2,'0')}', style: appBarTS,) ,)

      ),
      body:  BackgroundDecoration(

            child: Center(
              child: Obx(
                      () => Column(
                        children: [
                          if(controller.loadingStatus.value==LoadingStatus.loading)
                           const Expanded(
                               child: ContentAread(child: QuestionScreenHolder())),
                          if(controller.loadingStatus.value==LoadingStatus.completed)
                      Expanded(
                        child: ContentAread(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.only(top: Get.height*0.04),
                                  child: Column(
                                    children: [
                                       Text(
                                         controller.currentQuestion.value!.question,
                                         style: questionTS,
                                  ),
                                      GetBuilder<QuestionController>(
                                        id: 'answers_list',
                                          builder: (context){
                                        return ListView.separated(
                                          shrinkWrap: true,
                                            padding: const EdgeInsets.only(top: 25),
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context, int index){
                                            final answer =  controller.currentQuestion.value!.answers[index];
                                              return AnswerCard(
                                                  answer: '${answer.identifier}. ${answer.answer}',
                                                  onTap:(){
                                                    controller.selectedAnswer(answer.identifier);
                                                  },
                                                isSelected:
                                                answer.identifier==controller.currentQuestion.value!.selectedAnswer,
                                                  );
                                            },
                                            separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 10,),
                                            itemCount: controller.currentQuestion.value!.answers.length);
                                      }),

                                ],
                          ),
                        ),
                              ),
                      ),

                          ColoredBox(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Padding(
                              padding: UIParameters.mobileScreenPadding,
                              child: Row(
                                children: [
                                  Visibility(
                                    visible: controller.isFirstQuestion,
                                    child: SizedBox(
                                      width: 55,
                                      height: 55,
                                      child: MainButton(
                                        onTap: (){
                                          controller.prevQuestion();
                                        },
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Get.isDarkMode?onSurfaceTextColor:Theme.of(context).primaryColor,

                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5,),
                                  Expanded(
                                    child: Visibility(
                                      visible: controller.loadingStatus.value==LoadingStatus.completed,
                                        child: MainButton(
                                          onTap: (){
                                            controller.isLastquestion?Get.toNamed(TestOverView.routeName):
                                        controller.nextQuestion();
                                      },
                                      title: controller.isLastquestion?"Completed":'Next Question',
                                    )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],

                      )),
            ),

      ),
    );
  }
}
