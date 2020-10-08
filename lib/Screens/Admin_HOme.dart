import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contest_app/Screens/Add_Contest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String contestName;
  String description;

  // _showDialog() {
  //   Get.defaultDialog(
  //       title: 'UPDATE YOUR CONTEST',
  //       titleStyle: GoogleFonts.adamina(),
  //       onConfirm: () {
  //         contestName = _contestName.text;
  //         description = _contestDesc.text;
  //       },
  //       actions: [
  //         TextFormField(
  //           controller: _contestName,
  //           decoration: InputDecoration(
  //               labelText: "Contest Title",
  //               border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10))),
  //         ),
  //         Divider(),
  //         TextFormField(
  //           controller: _contestDesc,
  //           decoration: InputDecoration(
  //               labelText: "Description Of Contest",
  //               border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10))),
  //         )
  //       ]);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "CONTESTS",
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(AddContest()),
        backgroundColor: Colors.black,
        label: Text(
          "Add Contest",
          style: TextStyle(color: Colors.amber),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.amber,
        ),
        elevation: 10.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        notchMargin: 3.0,
        elevation: 10.0,
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  splashColor: Colors.black,
                  iconSize: 30,
                  icon: Icon(
                    Icons.format_list_numbered,
                    color: Colors.black,
                  ),
                  onPressed: null),
              SizedBox(width: 20),
              IconButton(
                  icon: Icon(
                    Icons.done_all,
                    color: Colors.black,
                  ),
                  onPressed: null),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("contests")
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      print(querySnapshot.data.docs);                  if (querySnapshot.hasError) {
                    return Text("Error Loading Data ......");
                  }
                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final list = querySnapshot.data.docs;
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                  list[index]["content"],
                                  style: GoogleFonts.balooDa(fontSize: 30),
                                ),
                                subtitle: Text(
                                  list[index]["content"],
                                  style: GoogleFonts.workSans(fontSize: 15),
                                )),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
