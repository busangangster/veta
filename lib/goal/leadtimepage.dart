import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class leadtimePage extends StatelessWidget {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  var timee = "??";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[ ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              firestore.collection('ToDo').doc('ToDoo2').update({
                "time": timee
              });
            }, child: Text('Save'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: const Color(0xffb003399),
                elevation: 1, shape:BeveledRectangleBorder(),padding: EdgeInsets.all(19.0),
                // minimumSize: Size(0,0)
            )
        ),
        ],
        title: Text("Lead Time setting",
            style : TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.grey
            )),centerTitle: true,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(child: TextField(
            style: TextStyle(fontSize: 32, color: Colors.black),
            textAlign: TextAlign.center,
            decoration: InputDecoration(hintText: 'Lead time'),
            onChanged: (value) {
              timee = value;
            },
          ),
            padding: EdgeInsets.only(left: 20),
            margin: EdgeInsets.only(top : 70, left : 40),

            width: 300, height: 100,

          ),],),);
  }
}