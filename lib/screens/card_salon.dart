import 'package:flutter/material.dart';
import 'package:nails_app/models/salon.dart';
import 'package:nails_app/screens/card_container.dart';

class CardSalon extends StatefulWidget {
  final Salon salon;

  const CardSalon({required this.salon});

  @override
  _CardSalonState createState() =>
      _CardSalonState();
}

class _CardSalonState extends State<CardSalon> {
  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: titulo(widget.salon.descripcion!)),            ],
          ),
          greenLine(),
          descripcion(widget.salon.direccion!),
          /* Row(
            children: [
              //Expanded(child: verEncuestaButton(context)),
              SizedBox(
                width: 5.0,
              ),
              //Expanded(child: aplicarEncuestaButton(context)),
            ],
          ) */
        ],
      ),
    );
  }

  Widget titulo(String titulo) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          titulo,
          style:
              TextStyle(color: Color.fromRGBO(44, 44, 44, 1.0), fontSize: 20.0),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget greenLine() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: 1.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color(0xff00838f),
        ),
      ),
    );
  }

  Widget descripcion(String descripcion) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            descripcion,
            style: TextStyle(
                fontSize: 15.0, color: Color.fromRGBO(123, 123, 123, 1.0)),
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget seccionesText(int n) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Secciones: $n',
            style: TextStyle(
              color: Color.fromRGBO(59, 210, 127, 1.0),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  /* Widget verUbicacion(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          primary: Color.fromRGBO(61, 61, 61, 1.0),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'encuestaNoRelacional',
              arguments: widget.encuesta);
          final aplicacionService =
              Provider.of<AplicacionService>(context, listen: false);
          aplicacionService.aplicacionMode = false;
        },
        child: Center(
          child: Text(
            'Ver Encuesta',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ),
    );
  }  */

}
