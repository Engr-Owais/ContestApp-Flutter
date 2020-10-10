import 'package:contest_app/Screens/Add_Contest.dart';
import 'package:contest_app/Screens/ExpiredContest_LeaderBoard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../dbhelper.dart/database.dart';
import '../Model/Contest_Model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String contestName;
  String description;
  final DatabaseFire _firestore = DatabaseFire();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "ON-GOING CONTESTS",
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
                  onPressed: () {
                    Get.to(LeaderboardScreen());
                  }),
              SizedBox(width: 20),
              
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ContestModel>>(
                stream: _firestore.getUserList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ContestModel>> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text(
                        "Error Loading Data ......${querySnapshot.error}");
                  }
                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final list = querySnapshot.data;
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => list.length == null
                            ?  Container(child: Text("No Data Found" , style: GoogleFonts.aBeeZee(backgroundColor: Colors.black) ))
                            : Card(
                                child: ListTile(
                                    isThreeLine: true,
                                    leading: CachedNetworkImage(
                                      imageUrl: list[index].imageUrl,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.red,
                                                BlendMode.colorBurn),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    title: Text(
                                      list[index].content == null
                                          ? ""
                                          : list[index].content,
                                      style: GoogleFonts.balooDa(fontSize: 30),
                                    ),
                                    subtitle: Text(
                                      list[index].description == null
                                          ? ""
                                          : list[index].description,
                                      style: GoogleFonts.workSans(fontSize: 15),
                                    )),
                              ));
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
