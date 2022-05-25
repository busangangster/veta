import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veta/goal/prioritypage.dart';
import 'package:veta/goal/py1.dart';
import '../login/register.dart';
import '../navigationbar.dart';
import 'leadtimepage.dart';
import 'categorypage.dart';
import 'package:time_pickerr/time_pickerr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class Settingpage extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  var title = "??";
  int time = 0;
  int priority = 0;
  var category = "??";
  var title1 = "??";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            foregroundColor: const Color(0xffb936DFF),
            backgroundColor: Colors.white,
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    DocumentSnapshot data =
                        await firestore.collection('ToDo').doc('ToDoo2').get();
                    title1 = data['Title'];
                    priority = data['priority'];
                    time = data['time'];
                    category = data['category'];
                    firestore.collection(user!.uid).doc().set({
                      "Title": '$title1',
                      "priority": priority,
                      "category": category,
                      "time": time,
                      "Completion": false
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationPage()),
                    );
                  },
                  child: Text('Save'),
                  style: TextButton.styleFrom(
                    primary: const Color(0xffb936DFF),
                    backgroundColor: Colors.white,
                    elevation: 1, shape: BeveledRectangleBorder(),
                    padding: EdgeInsets.all(0.0),
                    // minimumSize: Size(0,0)
                  )),
            ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: TextField(
                style: TextStyle(fontSize: 32, color: Colors.black),
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: 'Title'),
                onChanged: (value) {
                  title = value;
                  firestore
                      .collection('ToDo')
                      .doc('ToDoo2')
                      .update({"Title": title});
                },
              ),
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(top: 40, left: 20),
              width: 300,
              height: 120,
            ),
            Container(
                width: 250,
                height: 120,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: Image.asset('assets/time.png'), width: 5)),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => leadtimePage()),
                              );
                            },
                            child: Text('Lead time'),
                            style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.white,
                                minimumSize: Size(40, 50))))
                  ],
                )),
            Container(
                width: 250,
                height: 120,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: Image.asset('assets/pri.png'), width: 5)),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => priorityPage()),
                              );
                            },
                            child: Text('Priotity'),
                            style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.white,
                                minimumSize: Size(40, 50))))
                  ],
                )),
            Container(
                width: 250,
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: Image.asset('assets/cate.png'), width: 5)),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => categoryPick()),
                              );
                            },
                            child: Text('Category'),
                            style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.white,
                                minimumSize: Size(40, 50))))
                  ],
                ))
          ],
        ));
  }
}

buildCustomTimer(BuildContext context) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  return CustomHourPicker(
    elevation: 2,
    onPositivePressed: (context, time) {
      firestore.collection('ToDo').doc('ToDoo2').update({"time": time});
      Navigator.pop(context);
    },
    onNegativePressed: (context) {
      Navigator.pop(context);
    },
  );
}

Widget hourMinute24H() {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var _dateTime = 0;
  return Container(
    color: Colors.white,
    padding: EdgeInsets.only(top: 100),
    child: new Column(
      children: <Widget>[
        new TimePickerSpinner(
            is24HourMode: true,
            onTimeChange: (time) {
              _dateTime = time as int;
            })
      ],
    ),
  );
}
