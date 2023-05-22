
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:teraquiz/configs/themes/custom_text_styles.dart';
import 'package:teraquiz/configs/themes/ui_parameters.dart';
import 'package:teraquiz/controllers/question_paper/questions_controller_extension.dart';
import 'package:teraquiz/controllers/questions_controller.dart';
import 'package:teraquiz/screens/home/question_card.dart';
import 'package:teraquiz/screens/question/answer_check_screen.dart';
import 'package:teraquiz/widgets/common/background_decoration.dart';
import 'package:teraquiz/widgets/common/custom_app_bar.dart';
import 'package:teraquiz/widgets/common/main_button.dart';
import 'package:teraquiz/widgets/content_area.dart';
import 'package:teraquiz/widgets/question/answer_card.dart';
import 'package:teraquiz/widgets/question/question_number_card.dart';

class ResultScreen extends GetView<QuestionController>{
  const ResultScreen({Key? key}) : super(key: key);
  static const String routeName = "/resultscreen";
  @override
  Widget build(BuildContext context) {
    Color _textColor = Get.isDarkMode?
        Colors.white:
        Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: const SizedBox(height: 80,),
        title: controller.correctAnsweredQuestions,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
                child: ContentAread(
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/images/bulb.svg",),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 5),
                        child: Text("Congratulations", style: headerText.copyWith(color: _textColor),),
                      ),
                      Text(
                        "You have ${controller.points} points",
                        style: TextStyle(color: _textColor),
                      ),
                      const SizedBox(height: 25,),
                      const Text(
                          "Tap below question numbers to view correct answers",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25,),
                      Expanded(
                          child: GridView.builder(
                            itemCount: controller.allQuestions.length,
                            shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Get.width~/75,
                                childAspectRatio: 1,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder:(_, index) {
                                final _questions = controller
                                    .allQuestions[index];
                                AnswerStatus _status = AnswerStatus.notanswered;
                                final _selectedAnswer = _questions
                                    .selectedAnswer;
                                final _correctAnswer = _questions.correctAnswer;
                                if (_selectedAnswer == _correctAnswer) {
                                  _status = AnswerStatus.correct;
                                } else if (_questions.selectedAnswer == null) {
                                  _status = AnswerStatus.wrong;
                                } else {
                                  _status = AnswerStatus.wrong;
                                }
                                return QuestionNumberCard(
                                    index: index + 1,
                                    status: _status,
                                    onTap: () {
                                      controller.jumpToQuestion(index, isGoBack: false);
                                          Get.toNamed(AnswerCheckScreen.routeName);
                                    }

                                );
                              }
                      ),
                      )
                    ],
                  ),
                )),
            ColoredBox(color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: UIParameters.mobileScreenPadding,
              child: Row(
                children: [
                  Expanded(
                    child: MainButton(
                      onTap: (){
                        controller.tryAgain();
                      },
                      color: Colors.blueGrey,
                    title: 'Try again',),
                  ),
                  SizedBox(width: 3,),
                  Expanded(
                    child: MainButton(
                      onTap: (){
                        controller.saveTestResults();
                      },
                      color: Colors.grey.withOpacity(0.2),
                      title: 'Home',),
                  ),
                ],
              ),
            ),),
          ],
        ),
      )
    );
  }
}
