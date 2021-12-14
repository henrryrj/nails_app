// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nails_app/utilities/themes/primary_theme.dart';
import 'package:nails_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final title = "NailsApp";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: PrimaryTheme.lightTheme,
        home: HomePage(title: title));
  }
}

