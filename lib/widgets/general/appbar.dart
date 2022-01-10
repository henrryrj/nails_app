import 'package:flutter/material.dart';
import 'package:nails_app/services/usuario_services.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  const MyAppBar({Key? key, required this.title, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<ClienteService>(context, listen: false);
    return AppBar(
      backgroundColor: Color(0xff00838f),
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          tooltip: 'Settings',
          onPressed: () {},
        ),
        IconButton(
            icon: Icon(
              Icons.account_circle_sharp,
              color: Colors.white,
            ),
            tooltip: 'perfil',
            onPressed: () => Navigator.pushNamed(context, 'perfil')),
             IconButton(
              onPressed: () {
                userService.logout();
                Navigator.pushReplacementNamed(context, 'signin');
              },
              icon: Icon(Icons.login_outlined))
      ],
      elevation: 100.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
