import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:veta/controllerBindings.dart';
import 'initial screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
  //
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     // theme: ThemeData(),
  //     // darkTheme: ThemeData.dark(),
  //     // initialRoute: '/',
  //     // routes: {
  //     //   '/': (context) => LoginPage(),
  //     //   '/registerpage': (context) => RegisterPage(),
  //     //   '/register2page': (context) => Register2Page()
  //     // },
  //
  //     home: LandingPage(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(376, 812),
        builder: (context, child) {
          return GetMaterialApp(
              initialBinding: ControllerBindings(),
              debugShowCheckedModeBanner: false,
              home: FutureBuilder(builder: (context, AsyncSnapshot snapshot) {
                return LandingPage();
                // return BottomNavigation();
              }));
        });
  }
}
