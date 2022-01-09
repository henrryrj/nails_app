import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nails_app/providers/image_handler.dart';
import 'package:nails_app/services/usuario_services.dart';
import 'package:nails_app/utilities/themes/colors/MyColors.dart';
import 'package:nails_app/widgets/general/appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Uint8List image = Uint8List(0);
  bool isImagePicked = false;
  int selectedIndex = 1;

  List<Widget> widgetOptions = <Widget>[
    //Index 0: Saved Designs
    Center(child: Text('Saved Designs')),
    //Index 1: Home
    Center(child: Text('Home')),
    //Index 2: My Places
    Center(child: Text('My Places')),
  ];

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<ClienteService>(context, listen: false);
    return Scaffold(
      backgroundColor: MyColors.DividerColor,
      appBar: MyAppBar(title: widget.title, height: 55),
      body: selectedIndex == 1
          ? imageBody(context)
          : widgetOptions.elementAt(selectedIndex),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_a_photo_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          _showPicker(context);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_rounded),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list_rounded),
            label: 'Mis Solicitudes',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void setImage(context, bool fromGallery) async {
    Uint8List bytes = await ImageHandler.im.getImage(fromGallery);
    setState(() {
      this.image = bytes;
      this.isImagePicked = true;
    });
    Navigator.of(context).pop();
  }

  Widget imageBody(BuildContext context) {
    return Center(
      child: isImagePicked
          ? Container(
              width: 250,
              height: 250,
              padding: new EdgeInsets.all(5.0),
              margin: new EdgeInsets.all(2.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Column(children: [
                    Container(
                      padding: new EdgeInsets.all(20.0),
                      child: Image.memory(
                        this.image,
                        width: 150,
                        height: 150,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    getPrice(context)
                  ])),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15)),
              width: 250,
              height: 250,
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey[800],
              ),
            ),
    );
  }

  Widget getPrice(context) {
    return FutureBuilder<dynamic>(
      future: ImageHandler.im.getPrice(image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot);
          return Text(snapshot.data.toString(),
              style: TextStyle(fontSize: 18.0));
        } else {
          print("No hay información");
          return snapshot.data;
        }
      },
      initialData: Center(child: CircularProgressIndicator()),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Gallery'),
                      onTap: () {
                        setImage(context, true);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      setImage(context, false);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
