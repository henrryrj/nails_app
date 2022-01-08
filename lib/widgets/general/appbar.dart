import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  final double height;
  final String title;
  const MyAppBar(
      {
        Key? key,
        required this.title,
        required this.height
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          tooltip: 'Login',
          onPressed: () {},
        ),
      ],
      elevation: 100.0,
      brightness: Brightness.dark,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}