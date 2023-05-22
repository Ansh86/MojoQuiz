import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teraquiz/bindings/initial_binding.dart';
import 'package:teraquiz/configs/themes/app_dark_theme.dart';
import 'package:teraquiz/configs/themes/app_light_theme.dart';
import 'package:teraquiz/controllers/theme_controller.dart';
import 'package:teraquiz/data_uploader_screen.dart';
import 'package:teraquiz/firebase_options.dart';
import 'package:get/get.dart';
import 'package:teraquiz/routes/app_routes.dart';
import 'package:teraquiz/screens/introduction/introduction.dart';
import 'package:teraquiz/screens/splash/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  InitialBindings().dependencies();
  runApp(MyApp());
}

// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(GetMaterialApp(home: DataUploaderScreen(),));
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.find<ThemeController>().lightTheme,
      darkTheme: Get.find<ThemeController>().darkTheme,
     getPages: AppRoutes.routes(),
    );
  }
}





