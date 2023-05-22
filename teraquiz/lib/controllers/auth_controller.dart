import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teraquiz/firebase_ref/references.dart';
import 'package:teraquiz/screens/home/home_screen.dart';
import 'package:teraquiz/screens/login/login_screen.dart';
import 'package:teraquiz/widgets/dialogs/dialogue_widget.dart';

import '../services/app_logger.dart';


class AuthController extends  GetxController{
  @override
  void onReady(){
    initAuth();
    super.onReady();
  }

 late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth= FirebaseAuth.instance;
    _authStateChanges= _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value=user;
    });
    navigateToIntroduction();
  }


  sigInWithGoogle() async {
    final GoogleSignIn _googleSignIn =GoogleSignIn();
    try{
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if(account!=null){
     final _authAccount = await account.authentication;
     final _credential = GoogleAuthProvider.credential(
       idToken: _authAccount.idToken,
       accessToken: _authAccount.accessToken
     );

     await _auth.signInWithCredential(_credential);
     await saveUser(account);
     navigateToHomePage();
    }
    }on Exception catch(error){
     AppLogger.e(error);
    }
  }

  User? getUser(){
    _user.value= _auth.currentUser;
    return _user.value;
  }

saveUser(GoogleSignInAccount account){
    userRF.doc(account.email).set({
      "email": account.email,
      "name" : account.displayName,
      "profilepic": account.photoUrl
    });
    print('Hey Ansh');
}

Future<void> signOut() async {
    AppLogger.d('Sign out');
    try{
      await _auth.signOut();
      navigateToHomePage();
    }on FirebaseAuthException catch(e){
      AppLogger.e(e);
    }
}

  void navigateToIntroduction(){
    Get.offAllNamed("/introduction");
  }
  navigateToHomePage(){
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlterDialogue(){
    Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      navigateToLoginPage();
    }),
    barrierDismissible: false);
  }

  void navigateToLoginPage(){
    Get.toNamed(LoginScreen.routeName);
  }

  bool isLogged(){
   return _auth.currentUser!=null;
  }

}