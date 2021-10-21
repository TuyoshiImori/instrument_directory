import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:instrument_directory/my_instrument_page/save_instrument.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  File imageFile;
  String profilePath;
  ImagePicker imagePicker;


  @override
  void initState() {
    super.initState();
    //downloadImage();
    imagePicker = ImagePicker();
  }

  _imgFromGallery() async {
    final PickedFile pickedFile =
    await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    var savedFile = await SaveImage.saveLocalImage(pickedFile);
    setState(() {
      imageFile = savedFile;
    });
  }

  ///SharePreferenceに書き込まれたimageのpathを呼び出す。
  Future<Uint8List> SharedPrefRead() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String imagePath = prefs.getString('key');

    ///imageのpathをByteDataに変換
    ByteData byte = await rootBundle.load(imagePath);

    ///ByteDataをUint8List変換
    final Uint8List list = byte.buffer.asUint8List();
    return list;
  }

  Future getImage() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery,);
    setState(() {
      imageFile = File(pickedFile.path);
      print('Select image path' + imageFile.path.toString());
    });
  }

  Future downloadImage() async {
    if (profilePath != null) {
      var image = new File(profilePath);
      setState(() {
        imageFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 280.0,
                  width: double.infinity,
                ),
                Container(
                  height: 200.0,
                  width: double.infinity,
                  color: Colors.orangeAccent,
                ),
                Positioned(
                  top: 125.0,
                  left: 15.0,
                  right: 15.0,
                  child: Material(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
                    ),
                    child: Container(
                      height: 150.0,
                      /*  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.white),*/
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: (MediaQuery
                      .of(context)
                      .size
                      .width / 2 - 70.0),
                  child: Container(
                    child: new Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.0),
                          child: new Stack(
                              fit: StackFit.loose, children: [
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: FutureBuilder(
                                        future: SharedPrefRead(),
                                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData == true) {
                                            Uint8List image = snapshot.data;
                                            print(snapshot.hasError);
                                            return Center(
                                              child: CircleAvatar(
                                                radius: 65.0,
                                                backgroundImage: Image.memory(image).image,
                                              ),
                                            );
                                          } else {
                                            Container();
                                          }
                                          return Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey,
                                            size: 140,
                                          );
                                          },
                                      ),
                                    ),
                                  ],
                                ),
                            Padding(
                                padding: EdgeInsets.only(top: 90.0, left: 90.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new FloatingActionButton(
                                      foregroundColor: Colors.grey,
                                      backgroundColor: Colors.white,
                                      onPressed: _imgFromGallery,
                                      tooltip: 'Pick Image',
                                      child: Icon(Icons.add_a_photo),
                                    ),
                                  ],
                                )
                            ),
                          ]
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //TODO HERE CONTEXT ADD
          ]
        ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}