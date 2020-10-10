import 'package:cached_network_image/cached_network_image.dart';
import 'package:contest_app/Model/Contest_Model.dart';
import 'package:contest_app/dbhelper.dart/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String contestName;
  String description;
  final DatabaseFire _firestore = DatabaseFire();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ContestModel>>(
                stream: _firestore.getCompletedUserList(),
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
                    debugPrint(list.length.toString());
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => list.length == 0
                            ? Text("No Data Found")
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
