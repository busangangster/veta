import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settingpage.dart';

class nameinput extends StatefulWidget {
  @override
  State<nameinput> createState() => _nameinputState();
}

class _nameinputState extends State<nameinput> {
  final myController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Inform =
      FirebaseFirestore.instance.collection('ToDo').doc('ToDoo2').get();
  var title = "??";
  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MainPage",
        home: Material(
          child: Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/back.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: 400,
              width: 200,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('ToDo')
                        .orderBy("priority")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final docs = snapshot.data!.docs;
                      final List<Color> colors = [
                        Color(0xffb003399),
                        Color(0xffb1F62C7),
                        Color(0xffb7C91DB),
                        Color(0xffbC6CEF8),
                        Color(0xffbDCE4FF)
                      ];
                      return Container(child: SingleChildScrollView(
                        child: StreamBuilder<DocumentSnapshot>(
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            final getdata = snapshot.data;
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  //  itemCount: docs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        //    color: colors[docs[index]['priority']],
                                        color: colors[getdata?["priority"]],
                                        padding: EdgeInsets.all(8),
                                        //   child: Text(docs[index]['Title']),
                                        child: Text(
                                          '${getdata?["Title"]}',
                                        ));
                                  });
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ));
                    },
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Settingpage()),
                        );
                      },
                      child: Icon(Icons.add)),

                  // Container(
                  //   margin: EdgeInsets.only(top: 20),
                  //   child: FloatingActionButton(
                  //       onPressed: () async {
                  //         DocumentSnapshot data = await firestore
                  //             .collection('ToDo')
                  //             .doc('ToDoo2')
                  //             .get();
                  //         print(data['Title']);
                  //         setState(() {
                  //           title = data['Title'];
                  //         });
                  //       },
                  //       child: Icon(Icons.arrow_forward_ios_sharp)),
                  // ),
                ],
              )),
            ),
          ),
        ));
  }
}
