
import 'package:firebase_core/firebase_core.dart';

class ProfileLogin {
  String EmailLogin; 
  String PasswoedLogin;

  ProfileLogin({required this.EmailLogin, required this.PasswoedLogin});
}

class ProfileSignin {
  String EmailSignin;
  String PasswoedSignin;
  String userNameSignin;

  ProfileSignin({required this.EmailSignin,required this.PasswoedSignin,required this.userNameSignin});
}

class ProfileForgot {
  String EmailForgot;

  ProfileForgot({required this.EmailForgot,});
}

