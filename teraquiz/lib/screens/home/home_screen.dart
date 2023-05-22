import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:teraquiz/configs/themes/app_colors.dart';
import 'package:teraquiz/configs/themes/custom_text_styles.dart';
import 'package:teraquiz/configs/themes/ui_parameters.dart';
import 'package:teraquiz/controllers/zoom_drawer_controller.dart';
import 'package:teraquiz/screens/home/menu_screen.dart';
import 'package:teraquiz/screens/home/question_card.dart';
import 'package:teraquiz/widgets/app_circle_button.dart';
import 'package:teraquiz/widgets/app_icon.dart';
import 'package:teraquiz/widgets/content_area.dart';
import '../../controllers/question_paper/question_paper_controller.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);
   static const String routeName= "/home";

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_){
        return ZoomDrawer(
          borderRadius: 50.0,
          controller: _.zoomDrawerController,
          showShadow: true,
          angle: 0.0,
          backgroundColor: Colors.white.withOpacity(0.5),
          slideWidth: MediaQuery.of(context).size.width*0.6,
          style: DrawerStyle.DefaultStyle,
          menuScreen: const MenuScreen(),
          mainScreen: Container(
              decoration: BoxDecoration(
                gradient: mainGradient(),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: controller.toggleDrawer ,
                              child: const Icon(AppIcons.menuLeft,)
                          ),
                          const  SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children:[
                                const Icon(AppIcons.peace,),
                                const SizedBox(width: 5,),
                                Text("Hello Friend",
                                  style: detailText.copyWith(
                                    color: onSurfaceTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text("What do you want to learn today?",
                            style: headerText,)

                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8 ),
                        child: ContentAread(
                          addPadding: false,
                          child: Obx(()=> ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemBuilder: (BuildContext context, int index){
                                return QuestionCard(
                                  model: _questionPaperController.allPapers[index],
                                );
                              },
                              separatorBuilder:  (BuildContext context, int index){
                                return const SizedBox(height: 20,);
                              },
                              itemCount: _questionPaperController.allPapers.length)),
                        ),
                      ),
                    ),
                   
                  ],
                ),
              )
          ),

        );
      },),
    );
  }
}
