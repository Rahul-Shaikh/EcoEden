import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}

class Gallery extends StatefulWidget {
  final Arguments args;
  Gallery({
    @required this.args,
});
  @override
  _GalleryState createState() => _GalleryState(args : args);
}

class _GalleryState extends State<Gallery> {
  final Arguments args;
  TextEditingController _textFieldController = TextEditingController();
  final String POST_URI = 'https://api.ecoeden.xyz/photos/';
  _GalleryState({
    @required this.args,
});
  String currentFilePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: _getAllImages(),
        builder: (context, AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Container();
          }
          print('${snapshot.data.length} ${snapshot.data}');
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('No images found.'),
            );
          }

          return PageView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              currentFilePath = snapshot.data[index].path;
              var extension = path.extension(snapshot.data[index].path);
                return Container(
                  height: 300,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.file(
                    File(snapshot.data[index].path),
                  ),
                );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.cloud_upload),
                onPressed: () => _upload,//TODO
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: _deleteFile,
              ),
            ],
          ),
        ),
      ),
    );
  }



  _upload(BuildContext context){
    var map = new Map<String, dynamic>();
    map['user']="http://api.ecoeden.xyz/users/${args.user.id}/";
    map['lat']=args.lat;
    map['lng'] =args.lon;
    map['image'] = File(currentFilePath);
    _displayDialog(context);
    map['description'] = _textFieldController.value;
    http.post(
        POST_URI ,
        body: map
    ).then( (response){
      if ( response.statusCode == 200){
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Image Uploaded Successfully'),));
        Navigator.of(context).pop();
      }
    });



  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter image description'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Description .. "),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }


  _deleteFile() {
    final dir = Directory(currentFilePath);
    dir.deleteSync(recursive: true);
    print('deleted');
    setState(() {});
  }

  Future<List<FileSystemEntity>> _getAllImages() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    List<FileSystemEntity> _images;
    _images = myDir.listSync(recursive: true, followLinks: false);
    _images.sort((a, b) {
      return b.path.compareTo(a.path);
    });
    return _images;
  }
}