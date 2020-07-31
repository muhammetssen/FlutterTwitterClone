import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _uploadImage();
  }
}

class _uploadImage extends State<UploadImage> {
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
    String fileName = file.path.split("/").last;
    String ServerURL = 'http://192.168.1.2:8080/setProfilePhoto';

    http.post(ServerURL, body: {
      "image": base64Image,
      "userId": prefs.getString('user_id'),
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }
}
