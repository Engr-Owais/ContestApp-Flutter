import 'package:contest_app/Model/participateusermodel.dart';
import 'package:contest_app/dbhelper.dart/database.dart';
import 'package:contest_app/varibles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VotingScreen extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  bool check = false;
  Variables variables = Variables();

  String contestName;
  String description;
  final DatabaseFire _firestore = DatabaseFire();

  @override
  Widget build(BuildContext context) {
    String userid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          "WINNERS",
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<UserContestModel>>(
                stream: _firestore.getUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserContestModel>> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text("Error Loading Data ......");
                  }
                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if(!querySnapshot.hasData)
                  { 
                    return Center(child:Text("NO PARTICIPANTS"));

                  }
                   else {
                    final list = querySnapshot.data;
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => list.length == 0
                            ? Text("No Data Found")
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CachedNetworkImage(
                                            imageUrl: list[index].imageUrlUser,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: 300,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                  alignment: Alignment.center,
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
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.red,
                                        thickness: 2,
                                        height: 2,
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(8.0),
                                          isThreeLine: true,
                                          title: Text(
                                            list[index].username == null
                                                ? ""
                                                : list[index].username,
                                            style: GoogleFonts.acme(
                                                fontSize: 30,
                                                color: Colors.black,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                                "Votes ${list[index].votes}",
                                                style: GoogleFonts.workSans(
                                                    fontSize: 15),
                                              ),
                                          trailing: FloatingActionButton(
                                            onPressed: () async => {
                                              userid = list[index].id,
                                              check = true,
                                              await _firestore.updateWinner(
                                                  variables.getContestID(),
                                                  userid),
                                              Navigator.pop(context),
                                            },
                                            child: Center(
                                                child: Icon(
                                              Icons.check,
                                              color: Colors.black,
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Colors.amber),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15))),
                                ),
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
