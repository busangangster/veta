import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';

class my_page extends StatefulWidget {
  const my_page({Key? key}) : super(key: key);

  @override
  _my_pageState createState() => _my_pageState();
}

class _my_pageState extends State<my_page> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  User? get userProfile => auth.currentUser;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userProfile!.uid)
        .snapshots();

    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Image.asset(
        //     'assets/top_bar_logo.png',
        //     width: 100.w,
        //     height: 48.h,
        //   ),
        //   elevation: 5,
        //   backgroundColor: Colors.white,
        // ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 56.h,
            ),
            Container(
                //  padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
                alignment: Alignment.topRight,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: _userStream,
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    final getdata = snapshot.data;
                    if (snapshot.hasData) {
                      return Text(
                        '${getdata?["email"]}',
                        style: TextStyle(
                          color: Color(0xff495057),
                          fontSize: 15.sp,
                          // fontWeight: FontWeight.w500,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )),
          ],
        ))));
  }
}
