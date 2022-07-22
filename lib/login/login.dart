import 'package:flutter/material.dart';
import 'package:veta/login/register.dart';
import 'package:veta/navigationbar.dart';

import 'package:veta/Goal&MainPage/mainPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          child: ListView(
            children: <Widget>[
              const Text(
                '로그인',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5A5A5A)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                height: 20.0,
                child: const Text(
                  '이메일',
                  style: TextStyle(color: const Color(0xffb5A5A5A)),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              const TextField(
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
              const SizedBox(height: 12.0),
              const TextField(
                obscureText: true,
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
                    labelText: '비밀번호를 입력해주세요',
                    labelStyle: TextStyle(color: const Color(0xffD5D5D5))),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: const Text("확인"),
                textColor: Colors.white,
                color: Color(0xff936DFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => (NavigationPage())),
                  );
                },
              ),
              // TextButton(
              //   child: Text('아이디 찾기'),
              //   onPressed: (),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
