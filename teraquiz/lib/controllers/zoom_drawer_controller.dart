
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:teraquiz/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/login/login_screen.dart';

class MyZoomDrawerController extends GetxController{

  final zoomDrawerController= ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value= Get.find<AuthController>().getUser();
    super.onReady();
  }
  void toggleDrawer(){
    zoomDrawerController.toggle?.call();
    update();
  }


  void signOut(){
   Get.find<AuthController>().signOut();
  }

  void signIn(){
    Get.toNamed(LoginScreen.routeName);
  }

  void website(){
    _launch("https://www.linkedin.com/in/anshvarshney");
  }

  void facebook(){
    _launch("https://www.facebook.com");
  }

  void email(){
    final Uri emailLaunchUri= Uri(
      scheme: 'mailto',
      path: 'anshvarshney792@gmail.com'
    );
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    if( !await launch(url)){
      throw 'could not launch $url';
    }
  }

}