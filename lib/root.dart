import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veta/initial%20screen/description.dart';
import 'package:veta/login/sociallogin.dart';
import 'package:veta/signin/sign_in.dart';
import 'package:veta/signin/sign_up.dart';
import 'package:veta/signin/welcome_page.dart';
import '../config.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'controllers/auth_controller.dart';
import 'navigationbar.dart';

class root extends StatefulWidget {
  const root({Key? key}) : super(key: key);

  @override
  State<root> createState() => _rootState();
}

class _rootState extends State<root> {
  User? user;
  late bool isSign;

  FirebaseAuth auth = FirebaseAuth.instance;

  User? get userProfile => auth.currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((event) => updateUserState(event));
    isSign = false;
  }

  updateUserState(event) {
    user = event;
    if (user == null) {
      isSign = false;
    } else {
      isSign = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return GetBuilder<AuthController>(
      builder: (_) {
        print("root.dart");
        return isSign
            ? _.isFirstSignIn.value
                ? _.isEmailSignIn.value
                    ? SocialLogin()
                    : const SignUp()
                : NavigationPage()
            : Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Config.screenWidth! * 0.0),
                    child: OnBoardingPage(),
                  ),
                ),
              );
      },
    );
  }
}
