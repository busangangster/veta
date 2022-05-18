import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../goal/py1.dart';
import 'login.dart';
import 'register.dart';

class SocialLogin extends StatelessWidget {
  // const SocialLogin({Key key}) : super(key: key);
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential`
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset('assets/images/logo.png', width: 100, height: 80),
            //구글 로그인
            TextButton(
                onPressed: () {
                  signInWithGoogle();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => nameinput()));
                },
                // onPressed: signInWithGoogle,
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                ),
                child: const Text('구글로 로그인하기')),
            //카카오 로그인
            // TextButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => RegisterPage()));
            //       },
            //     style: TextButton.styleFrom(
            //       primary: Colors.yellow,
            //       backgroundColor: Colors.black,
            //     ),
            //     child: Text('카카오로 로그인하기'),
            // ),
            //이메일 로그인
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.indigo,
              ),
              child: const Text('이메일로 로그인하기'),
            ),
            //이메일 회원가입
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.indigo,
              ),
              child: const Text('이메일로 회원가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}
