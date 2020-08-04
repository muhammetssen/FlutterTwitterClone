import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class UploadImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadImage();
  }
}

class _UploadImage extends State<UploadImage> {
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _choose,
                child: Text('Choose Image'),
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: _upload,
                child: Text('Upload Image'),
              )
            ],
          ),
          file == null
              ? Text('No Image Selected')
              : Image.file(
                  file,
                  height: 500,
                )
        ],
      ),
    );
  }

  void _choose() async {
    ImagePicker picker = new ImagePicker();
    var pickedFile = (await picker.getImage(source: ImageSource.gallery));
    file = File(pickedFile.path);
  }

  void _upload() async {
    var prefs = await SharedPreferences.getInstance();
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    // prefs.setString('profilePhoto', base64Image);
    // writeImage(base64Image);
    var path = (await getApplicationDocumentsDirectory()).path;
    final File newImage = await file.copy('$path/profilePicture.jpg');
    print(newImage.path);

    http.post(globals.serverIP + 'user/setProfilePhoto', body: {
      "image": base64Image,
      "userId": prefs.getString('user_id'),
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }
}
