
import 'package:get/get.dart';
import 'package:teraquiz/controllers/question_paper/question_paper_controller.dart';
import 'package:teraquiz/controllers/questions_controller.dart';
import 'package:teraquiz/controllers/zoom_drawer_controller.dart';
import 'package:teraquiz/screens/home/home_screen.dart';
import 'package:teraquiz/screens/introduction/introduction.dart';
import 'package:teraquiz/screens/login/login_screen.dart';
import 'package:teraquiz/screens/question/answer_check_screen.dart';
import 'package:teraquiz/screens/question/question_screen.dart';
import 'package:teraquiz/screens/question/result_screen.dart';
import 'package:teraquiz/screens/question/test_overview.dart';
import 'package:teraquiz/screens/splash/splash_screen.dart';

class AppRoutes{
  static List<GetPage>routes()=>[
    GetPage(name: "/", page: ()=>const SplashScreen()),
    GetPage(name: "/introduction", page: ()=>const AppIntroduction()),
    GetPage(name: "/home", page: ()=>const HomeScreen(),
      binding: BindingsBuilder((){
        Get.put(QuestionPaperController());
        Get.put(MyZoomDrawerController());
      })
    ),

    GetPage(name: LoginScreen.routeName
        , page: ()=>const LoginScreen()),

    GetPage(name: QuestionScreen.routeName
        , page: ()=>const QuestionScreen(),
      binding: BindingsBuilder((){
        Get.put<QuestionController>(QuestionController());
      }),
    ),

    GetPage(
        name: TestOverView.routeName,
        page: ()=> const TestOverView()),

    GetPage(
        name: ResultScreen.routeName,
        page: ()=> const ResultScreen()),

    GetPage(
        name: AnswerCheckScreen.routeName,
        page: ()=> const AnswerCheckScreen()),

  ];
}