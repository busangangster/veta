import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:veta/signin/reset_form.dart';
import '../../config.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Config.screenWidth! * 0.04),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
            Text(
              "비밀번호 찾기",
              style:
                  TextStyle(color: Color(0xff936DFF), fontFamily: 'NotoSansKR'),
            ),
            Text(
              '비밀번호 재설정을 위한 이메일을 입력하세요.',
              style:
                  TextStyle(color: Color(0xff936DFF), fontFamily: 'NotoSansKR'),
            ),

            SizedBox(height: Config.screenHeight! * 0.1),
            //  const HeroImage(
            //      path: 'assets/resetHero.svg', sementicLabel: 'Reset Hero'),
            SizedBox(height: Config.screenHeight! * 0.03),
            const ResetForm(),
            SizedBox(height: Config.screenHeight! * 0.3),
          ],
        ),
      )),
    );
  }
}
