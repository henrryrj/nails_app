import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nails_app/models/nail_design.dart';
import 'package:nails_app/providers/api_connection.dart';

class ImageHandler {
  final ImagePicker imagePicker = ImagePicker();

  //Singleton Pattern para el constructor
  ImageHandler();
  static final ImageHandler im = ImageHandler();

  Future<Uint8List> getImage(bool fromGallery) async {
    XFile? fotito;
    try {
      if (fromGallery) {
        fotito = (await imagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: 50));
      } else {
        fotito = (await imagePicker.pickImage(
            source: ImageSource.camera,
            imageQuality: 50,
            preferredCameraDevice: CameraDevice.rear));
      }
      if (fotito == null) {
        print('HUBO PROBLEMAS AL CARGAR LA FOTO');
        return Uint8List(0);
      }
      return fotito.readAsBytes();
    } catch (e) {}
    return Uint8List(0); //convertir al string :c
  }

  Future<NailDesign> getPrice(Uint8List image) async {
    NailDesign nail = new NailDesign(imageId: 0, price: 0.0);
    try {
      dynamic response = await ApiConnection.api.getPrice(image);
      if (response.toString() != '0') {
        nail = response;
      }
      return nail;
    } catch (e) {
      print(e);
      return nail;
    }
  }
}
