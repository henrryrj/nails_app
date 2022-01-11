import 'package:flutter/material.dart';
import 'package:nails_app/screens/rutas.dart';
import 'package:nails_app/services/usuario_services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<ClienteService>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xff4fb3bf),
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData)
              return Text('Cargando...',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blueGrey));

            if (snapshot.data == '') {
              Future.microtask(() {
                print(snapshot.data);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => SigninScreem(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomePage(title: 'NaillsApp'),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
