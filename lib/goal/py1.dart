import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class nameinput extends StatefulWidget {
  @override
  State<nameinput> createState() => _nameinputState();
}

class _nameinputState extends State<nameinput> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 35,
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: Material(
            child: Center(
                child: Column(children: [
          Container(
              margin: EdgeInsets.only(bottom: 40, top: 10),
              height: 56,
              width: 323,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(70),
                ),
                border: Border.all(
                  color: const Color(0xffb936DFF),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text("Do not try to be original"),
              )),
          Container(
            child: SizedBox(
              height: 350,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(user!.uid)
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
                        Color(0xffbFF6D6D),
                        Color(0xffbFFB36D),
                        Color(0xffbFFE86D),
                        Color(0xffb9CFF6D),
                        Color(0xffb6DA8FF)
                      ];
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            final item = docs[index];
                            return Slidable(
                              key: ValueKey(index),
                              child: buildListTile(item),
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    // An action can be bigger than the others.
                                    flex: 1,
                                    onPressed: (context) {
                                      firestore
                                          .collection(user!.uid)
                                          .doc(item.id)
                                          .update({"Completion": true});
                                    },
                                    backgroundColor: Color(0xFF7BC043),
                                    foregroundColor: Colors.white,
                                    icon: Icons.archive,
                                    label: 'Archive',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      firestore
                                          .collection(user!.uid)
                                          .doc(item.id)
                                          .delete();
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'delete',
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ],
              )),
            ),
          ),
          Container(
            height: 60,
            child: Row(
              children: [
                Expanded(flex: 5, child: Text(" ")),
                Expanded(
                  flex: 3,
                  child: FloatingActionButton(
                    backgroundColor: const Color(0xffb936DFF),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settingpage()),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          )
        ]))));
  }

  Widget buildListTile(item) => ListTile(
        leading: const CircleAvatar(
          radius: 5,
          backgroundColor: Color(0xffb936DFF),
        ),
        title: Text(
          item['Title'],
          style: TextStyle(fontSize: 16),
        ),
        onTap: () {},
      );
}

void updateArchive(item) {
  print("yes");
  print('$item');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  firestore.collection(user!.uid).doc('$item').update({"Completion": true});
}

void deleteList(BuildContext context) {
  print('$context[item]');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  firestore.collection(user!.uid).doc('$context').delete();
}
