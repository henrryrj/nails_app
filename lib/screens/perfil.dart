import 'package:flutter/material.dart';
import 'package:nails_app/services/usuario_services.dart';
import 'package:provider/provider.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<ClienteService>(context, listen: false);
    final user = userService.usuario;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle,
                size: 140, color: Theme.of(context).primaryColorLight),
            Text(
              'Nombre : ${user.nombre}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            Text(
              'Telefono : ${user.telefono}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            Text(
              'Direccion : ${user.direccion}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
            Text(
              'Email : ${user.email}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Padding(padding: const EdgeInsets.only(top: 10)),
           
          ],
        ),
      ),
    );
  }
}
