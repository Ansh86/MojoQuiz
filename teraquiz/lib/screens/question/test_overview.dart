
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teraquiz/configs/themes/custom_text_styles.dart';
import 'package:teraquiz/configs/themes/ui_parameters.dart';
import 'package:teraquiz/controllers/questions_controller.dart';
import 'package:teraquiz/widgets/common/background_decoration.dart';
import 'package:teraquiz/widgets/common/custom_app_bar.dart';
import 'package:teraquiz/widgets/common/main_button.dart';
import 'package:teraquiz/widgets/content_area.dart';
import 'package:teraquiz/widgets/question/answer_card.dart';
import 'package:teraquiz/widgets/question/countdown_timer.dart';
import 'package:teraquiz/widgets/question/question_number_card.dart';

class TestOverView extends GetView<QuestionController> {
  const TestOverView({Key? key}) : super(key: key);
  static const String routeName= "/testoverview";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
                child: ContentAread(
                  child: Column(
                    children: [
                      Row(

                        children: [
                          CountDownTimer(
                              color: UIParameters.isDarkMode()?
                              Theme.of(context).textTheme.bodyText1!.color:
                              Theme.of(context).primaryColor,
                              time:''),
                          Obx(() => Text(
                            '${controller.time} Remaining',
                            style: countDownTimerTS(),
                          )),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                        itemCount: controller.allQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_,  index) {
                              AnswerStatus? _answerStatus;
                              if(controller.allQuestions[index].selectedAnswer!=null){
                                _answerStatus=AnswerStatus.answered;
                              }
                          return  QuestionNumberCard(
                              index: index+1,
                              status: _answerStatus,
                              onTap: ()=>controller.jumpToQuestion(index));
                        },))
                    ],
                  ),

                )),
            ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
            child:Padding(
              padding: UIParameters.mobileScreenPadding,
              child: MainButton(
                onTap: (){
                  controller.complete();
                },
                title: "Complete",
              ),
            ),
            ),

          ],
        ),
      ),
    );
  }
}
