import 'package:flutter/material.dart';
import 'package:veta/login/register.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            const Text(
              '로그인',
              style: TextStyle(fontSize: 41, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 120.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: '이메일',
                hintText: '이메일을 입력해주세요',
              ),
            ),
            const SizedBox(height: 12.0),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: '비밀번호',
                hintText: '비밀번호를 입력해주세요',
              ),
            ),
            RaisedButton(
              child: const Text("확인"),
              textColor: Colors.white,
              color: Colors.indigo,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
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
    );
  }
}

// class LoginPage extends StatefulWidget {
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final formKey = new GlobalKey<Formstate>();

//   String _email;
//   String _password;

//   void validateAndSave() {
//     final form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       print("Form is valid Email: $_email, password: $_password");
//     } else {
//       print('Form is invalid Email: $_email, password: $_password');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('login demo'),
//       ),
//       body: new Container(
//         padding: EdgeInsets.all(16),
//         child: new Form(
//             key: formKey,
//             child: new Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 new TextFormField(
//                   decoration: new InputDecoration(labelText: 'Email'),
//                   validator: (value) =>
//                       value.isEmpty ? 'Email cannot be empty' : null,
//                   onSaved: (value) => _email = value,
//                 ),
//                 new TextFormField(
//                   obscureText: true,
//                   decoration: new InputDecoration(labelText: 'Passwoed'),
//                   validator: (value) =>
//                       value.isEmpty ? 'Password cannot be empty' : null,
//                   onSaved: (value) => _password = value,
//                 ),
//                 new RaisedButton(
//                   child: new Text(
//                     'Login',
//                     style: new TextStyle(fontSize: 20.0),
//                   ),
//                   onPressed: validateAndSave,
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
