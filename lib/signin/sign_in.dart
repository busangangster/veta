import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veta/signin/reset_password.dart';
import 'package:veta/signin/sign_up.dart';

import '../config.dart';
import '../controllers/auth_controller.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xffb936DFF),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40.0, 60.0, 40.0, 0.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  '로그인',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff5A5A5A)),
                ),
                SizedBox(
                  height: 20.0,
                ),

                Column(
                  children: [
                    buildTextFormFields(),
                    Padding(
                      padding: EdgeInsets.all(0),
                      // EdgeInsets.symmetric(vertical: Config.screenHeight! * 0.005),
                      child: Align(
                        alignment: Alignment(0.8, 0.0),
                        child: TextButton(
                          child: Text(
                            '비밀번호 찾기',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () => Get.to(() => const ResetPassword()),
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Container(
                        width: 287.w,
                        height: 49.h,
                        child: ElevatedButton(
                            child: Text('확인'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String email = _emailController.text.trim();
                                String password = _passwordController.text;
                                _authController.signIn(email, password);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff936DFF),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(33), // <-- Radius
                              ),
                            )))
                  ],
                ),
                // Platform.isIOS
                //     ? SignInButton(
                //         buttonType: ButtonType.google,
                //         onPressed: () => _authController.signInWithGoogle(),
                //       )
                //     : SignInButton.mini(
                //         buttonType: ButtonType.google,
                //         onPressed: () => _authController.signInWithGoogle(),
                //       ),
                // Platform.isIOS
                //     ? SizedBox(
                //         height: 10.h,
                //       )
                //     : Container(),
                // Platform.isIOS
                //     ? SignInButton(
                //         buttonType: ButtonType.appleDark,
                //         onPressed: () => _authController.signInWithApple(),
                //       )
                //     : Container(),
                // Platform.isIOS
                //     ? SizedBox(
                //         height: 30.h,
                //       )
                //     : Container(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('한 달 키우기 회원이 아니신가요? '),
                    TextButton(
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          color: Color(0xff458017),
                        ),
                      ),
                      onPressed: () => Get.to(() => const SignUp()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 8),
          height: 20.0,
          child: const Text(
            '이메일',
            style: TextStyle(color: const Color(0xffb5A5A5A)),
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: const Color(0xffbD5D5D5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: const Color(0xffb936DFF)),
              ),
              filled: true,
              fillColor: Colors.white,
              labelText: '이메일',
              labelStyle: TextStyle(color: const Color(0xffD5D5D5))),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.only(left: 8),
          height: 20.0,
          child: const Text(
            '비밀번호',
            style: TextStyle(color: const Color(0xffb5A5A5A)),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: const Color(0xffbD5D5D5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: const Color(0xffb936DFF)),
              ),
              filled: true,
              fillColor: Colors.white,
              labelText: '이메일을 입력해주세요',
              labelStyle: TextStyle(color: const Color(0xffD5D5D5))),
        ),
      ],
    );
  }
}

class RoundedTextFormField extends StatelessWidget {
  const RoundedTextFormField({
    Key? key,
    this.controller,
    this.obsecureText = false,
    @required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? obsecureText;
  final String? hintText;
  final validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(43),
      width: ScreenUtil().setWidth(287),
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText!,
        decoration: InputDecoration(
          hintText: hintText!,
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.all(15.0),
          focusedBorder: OutlineInputBorder(
            //borderSide: BorderSide(color: Colors.green),
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
