import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nails_app/providers/image_handler.dart';
import 'package:nails_app/screens/mapas/loading_screen.dart';
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
  bool soli = false;
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    //Index 0: Saved Designs
    LoadingScreen(),
    //Index 1: Home
    Center(child: Text('Solicitudes')),
  ];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.DividerColor,
      appBar: MyAppBar(title: widget.title, height: 55),
      body: selectedIndex == 1
          ? imageBody(context)
          : widgetOptions.elementAt(selectedIndex),
      floatingActionButton: selectedIndex == 1
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add_a_photo_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                _showPicker(context);
              },
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gps_fixed),
            label: 'Ubicacion',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list_rounded),
            label: 'Mis Solicitudes',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void setImage(context, bool fromGallery) async {
    Uint8List bytes = await ImageHandler.im.getImage(fromGallery);
    setState(() {
      if (bytes.length > 0) {
        this.image = bytes;
        this.isImagePicked = true;
      }
    });

    Navigator.of(context).pop();
  }

  Widget imageBody(BuildContext context) {
    final clienteService = Provider.of<ClienteService>(context, listen: false);
    final cliente = clienteService.usuario;
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        isImagePicked
            ? Container(
                width: 300,
                height: 320,
                padding: new EdgeInsets.all(5.0),
                margin: new EdgeInsets.all(2.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(164, 164, 166, 1.0),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: ListView(children: [
                    Container(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.memory(
                          this.image,
                          width: 600,
                          height: 600,
                        ),
                      ),
                    ), //Container(child: getPrice(context))
                  ]),
                ))
            : Container(
                padding: new EdgeInsets.all(5.0),
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
        isImagePicked
            ? ElevatedButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(15.0),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                onPressed: () async {
                  this.soli = true;
                  setState(() {});
                  await Future.delayed(Duration(seconds: 1));
                  int? precio =
                      await clienteService.getSolicitud(cliente, this.image);
                  print('PRECIO: $precio');
                  if (precio != -1) {
                    cliente.precio = precio;
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                              title: Text('Solicitud Aceptada '),
                              content: Text('Precio estimado: $precio',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blueGrey)),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text('Aceptar',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            letterSpacing: 1.5,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      this.isImagePicked = !this.isImagePicked;
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    }),
                                CupertinoDialogAction(
                                    child: Text('Ver Salones',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            letterSpacing: 1.5,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () async {
                                      Navigator.pushNamed(
                                          context, 'listaSalon');
                                    })
                              ],
                            ));
                    this.soli = false;
                    setState(() {});
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                              title: Text('Error! '),
                              content: Text('No se detectaron uñas!, debe ingresar foto de diseño de uñas',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blueGrey)),
                              actions: [
                                CupertinoDialogAction(
                                    child: Text('Aceptar',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            letterSpacing: 1.5,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      this.isImagePicked = !this.isImagePicked;
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ));
                  }
                  setState(() {});
                },
                child: Text(
                  this.soli ? 'Espere...' : 'Solicitar precio',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ))
            : Text('')
      ]),
    );
  }

  Widget getPrice(context) {
    return FutureBuilder<dynamic>(
      future: ImageHandler.im.getPrice(image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print('RESPUESTA DE GET_PRICE: ${snapshot.data.price}');
          return mostrarPrecio(snapshot.data.price);
        } else {
          return Container(child: Center(child: Text('')));
        }
      },
      initialData: Center(child: CircularProgressIndicator()),
    );
  }

  Widget mostrarPrecio(int precio) {
    return Text('\$$precio',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey));
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
