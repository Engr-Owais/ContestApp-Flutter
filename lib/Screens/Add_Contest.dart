import 'dart:io';

import 'package:contest_app/Model/Contest_Model.dart';
import 'package:contest_app/dbhelper.dart/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;

class AddContest extends StatefulWidget {
  @override
  _AddContestState createState() => _AddContestState();
}

class _AddContestState extends State<AddContest> {
  String url;
  final DatabaseFire _firestore = DatabaseFire();
  File sampleimage;

  TextEditingController _contestName = TextEditingController();
  TextEditingController _contestDesc = TextEditingController();
  DateTime endDate;

  bool focusone = true;
  _imgFromGallery() async {
    //   // ignore: deprecated_member_use
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleimage = image;
    });
  }

  Future<void> uploadStatusImage() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Pictures/${Path.basename(sampleimage.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(sampleimage);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      url = fileURL;

      print(fileURL);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget enableUpload() {
      return Container(
        height: 300,
        width: 300,
        child: Column(
          children: [
            Image.file(
              sampleimage,
              height: 200,
              width: 100,
            )
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "ADMIN PANEL",
            style: GoogleFonts.aclonica(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: sampleimage == null
                    ? Text("SELECT AN IMAGE")
                    : enableUpload(),
              ),
              RaisedButton(
                onPressed: () => {_imgFromGallery()},
                child: Text("IMAGE"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _contestName,
                  decoration: InputDecoration(
                      labelText: "Contest Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _contestDesc,
                  decoration: InputDecoration(
                      labelText: "Description Of Contest",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(), onChanged: (date) {
                      setState(() {
                        endDate = date;
                      });
                      print('change $date');
                    }, onConfirm: (date) {
                      print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'show date time picker (Chinese)',
                    style: TextStyle(color: Colors.blue),
                  )),
              SizedBox(height: 20),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                elevation: 10,
                onPressed: () async {
                  final String contestName = _contestName.text;
                  final String contestDesc = _contestDesc.text;
                  await uploadStatusImage();
                  final ContestModel contestModel = ContestModel(
                    content: contestName,
                    description: contestDesc,
                    imageUrl: url,
                    startDate: endDate.toUtc().millisecondsSinceEpoch,
                  );

                  if (contestName != "" && contestDesc != "") {
                    _firestore.addContent(contestModel);
                    _contestName.text = "";
                    _contestDesc.text = "";

                    Get.snackbar(
                      "Succes",
                      "Contest Added",
                      snackPosition: SnackPosition.BOTTOM,
                      animationDuration: Duration(seconds: 3),
                      backgroundGradient: LinearGradient(
                          colors: [Colors.blue[900], Colors.blue[800]]),
                      borderRadius: 10.0,
                      barBlur: 2,
                      colorText: Colors.black,
                    );
                  } else {
                    Get.snackbar(
                      "Error",
                      "Contest Not Added",
                      snackPosition: SnackPosition.BOTTOM,
                      animationDuration: Duration(seconds: 3),
                      backgroundGradient: LinearGradient(
                          colors: [Colors.red[900], Colors.red[800]]),
                      borderRadius: 10.0,
                      barBlur: 2,
                      colorText: Colors.black,
                    );
                  }
                },
                color: Colors.black,
                child: Text(
                  "Save",
                  style: GoogleFonts.aBeeZee(color: Colors.amber, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
