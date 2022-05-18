import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class categoryPick extends StatefulWidget {
  const categoryPick({Key? key}) : super(key: key);

  @override
  State<categoryPick> createState() => _categoryPickState();
}

class _categoryPickState extends State<categoryPick> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String selected_value = "Study";
  var value_list = [
    "Study",
    "Exercise",
    "Reading",
    "Relations",
    "Hobby",
    "Job prepare"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                firestore
                    .collection('ToDo')
                    .doc('ToDoo2')
                    .update({"category": selected_value});
                Navigator.pop(context);
              },
              child: Text('Save'),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color(0xffb003399),
                  elevation: 1,
                  shape: BeveledRectangleBorder(),
                  padding: EdgeInsets.all(19.0),
                  minimumSize: Size(0, 0))),
        ],
        title: Text("Category Setting",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.grey,
            )),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton(
              value: selected_value,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: value_list.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  selected_value = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
