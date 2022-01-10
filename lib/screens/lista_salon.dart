import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:nails_app/models/salon.dart';
import 'package:nails_app/screens/card_salon.dart';
import 'package:nails_app/services/usuario_services.dart';
import 'package:nails_app/widgets/general/appbar.dart';
import 'package:provider/provider.dart';


class ListaSalonesScreen extends StatefulWidget {
  @override
  _ListaSalonesScreenState createState() => _ListaSalonesScreenState();
}

class _ListaSalonesScreenState extends State<ListaSalonesScreen> {
  int _paginaActual = 0;
  List<Salon> salones = [];
  List<CardSalon> _listaCardSalones = [];

  @override
  void initState() {
    super.initState();
    final clienteService =
        Provider.of<ClienteService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'NaillsApp',height: 55),
      body: listaDeSalones(context));
  }



  Widget listaDeSalones(BuildContext context) {
    final clienteService = Provider.of<ClienteService>(context, listen: false);
    return FutureBuilder(
              future: clienteService.listaDeSalones(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xff00838f)),
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children:
                        _cargarSalones(snapshot.data, context),
                  ),
                );
              },
            );
    }


  List<Widget> _cargarSalones(List<dynamic>? data, BuildContext? context) {
    List<Widget> lista = [];
    salones = [];
    for (var encuesta in data!) {
      salones.add(encuesta);
    }
    for (var salonActual in salones) {
      lista.add(CardSalon(salon: salonActual));
      lista.add(SizedBox(
        height: 20,
      ));
    }

    return lista;
  }
  /* Future<void> _recargarLista() async {
    _listaCardSalones = [];
    setState(() {});
  } */
}
