import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nails_app/blocs/gps/gps_bloc.dart';
import 'package:nails_app/screens/mapas/gps_access_screen.dart';
import 'package:nails_app/screens/mapas/map_screen.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        return state.isAllGranted ? MapScreen() : const GpsAccessScreen();
      },
    ));
  }
}