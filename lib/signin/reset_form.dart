import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../config.dart';
import '../controllers/auth_controller.dart';

class ResetForm extends StatelessWidget {
  const ResetForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();

    final _authController = Get.find<AuthController>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          RoundedTextFormField(
            hintText: '이메일 ',
            controller: _emailController,
            validator: (value) {
              bool _isEmailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (!_isEmailValid) {
                return '유효하지 않은 이메일 양식입니다.';
              }
              return null;
            },
          ),
          SizedBox(height: Config.screenHeight! * 0.03),
          ElevatedButton(
            child: Text('Reset Password'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _authController.resetPassword(_emailController.text.trim());
              }
            },
          ),
        ],
      ),
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
