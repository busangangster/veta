import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class priorityPage extends StatelessWidget {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  late var priority = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[ ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              firestore.collection('ToDo').doc('ToDoo2').update({
                "priority": priority
              });
            }, child: Text('Save'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: const Color(0xffb003399),
                elevation: 1, shape:BeveledRectangleBorder(),padding: EdgeInsets.all(19.0),
                minimumSize: Size(0,0))
        ),
        ],
        title: Text("Priority setting",
            style : TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.grey
            )),centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width : 380, height: 120,
                child :Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: FloatingActionButton(
                        child: Text(" "), backgroundColor: const Color(0xffb003399),
                        onPressed: () {
                          priority = 1;
                        },
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child: FloatingActionButton(
                        child: Text(" "), backgroundColor: const Color(0xffb1F62C7),
                        onPressed: () {
                          priority = 2;
                        },
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child: FloatingActionButton(
                        child: Text(" "), backgroundColor: const Color(0xffb7C91DB),
                        onPressed: () {
                          priority = 3;
                        },
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child: FloatingActionButton(
                        child: Text(" "), backgroundColor: const Color(0xffbC6CEF8),
                        onPressed: () {
                          priority = 4;
                        },
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child: FloatingActionButton(
                        child: Text(" "), backgroundColor: const Color(0xffbDCE4FF),
                        onPressed: () {
                          priority = 5;
                        },
                      ),
                    ),
                  ],
                )),
            Container(
              width : 380, height: 20,
              margin: EdgeInsets.only(left : 20),
              child :Row(
                children: [
                  Expanded(
                      flex :2,
                      child : Text("Very Important")
                  ),
                  Expanded(
                      flex :4,
                      child : Text(" ")
                  ),
                  Expanded(
                      flex :2,
                      child : Text("Not Important")
                  ),],),),
          ]
      ),);
  }
}


