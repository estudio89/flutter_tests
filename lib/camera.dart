import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyCam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Image Picker Demo',
      home: new CamHomePage(title: 'Image Picker Example'),
    );
  }
}

class CamHomePage extends StatefulWidget {
  CamHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CamHomePageState createState() => new _CamHomePageState();
}

class _CamHomePageState extends State<CamHomePage> {
  Future<File> _imageFile;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: new Center(
          child: new FutureBuilder<File>(
              future: _imageFile,
              builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.error == null) {
                  return new Image.file(snapshot.data);
                } else if (snapshot.error != null) {
                  return const Text('error picking image.');
                } else {
                  return const Text('You have not yet picked an image.');
                }
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          setState(() {
            _imageFile = ImagePicker.pickImage();
          });
        },
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}