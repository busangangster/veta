import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veta/goal/prioritypage.dart';
import '../login/register.dart';
import 'leadtimepage.dart';
import 'categorypage.dart';

class Settingpage extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var title = "??";
  int time = 0;
  int priority = 0;
  var category = "??";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(actions: [
          ElevatedButton(
              onPressed: () async {
                DocumentSnapshot data =
                    await firestore.collection('ToDo').doc('ToDoo2').get();
                time = data['time'];
                category = data['category'];
                priority = data['priority'];
                Navigator.pop(context);
                firestore.collection('ToDo').doc().set({
                  "Title": title,
                  "time": time,
                  "priority": priority,
                  "category": category
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Save'),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color(0xffb003399),
                  elevation: 1,
                  shape: BeveledRectangleBorder(),
                  padding: EdgeInsets.all(19.0),
                  minimumSize: Size(0, 0))),
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
                            child: Image.asset('assets/alaem2.png'), width: 5)),
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
                            child: Image.asset('assets/work.png'), width: 5)),
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
                            child: Image.asset('assets/category.png'),
                            width: 5)),
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
