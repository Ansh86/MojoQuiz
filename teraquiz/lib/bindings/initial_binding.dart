import 'package:get/get.dart';
import 'package:teraquiz/controllers/auth_controller.dart';
import 'package:teraquiz/controllers/theme_controller.dart';

import '../services/firebase_storage_service.dart';


class InitialBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.lazyPut(() =>  FirebaseStorageService());
    Get.put(AuthController(), permanent: true);

  }

}