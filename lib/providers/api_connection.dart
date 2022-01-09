import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nails_app/utilities/general/file-path-provider.dart';

class ApiConnection {
  final String baseUrl = "137.184.192.21";
  final String baseTest = "127.0.0.1:5500";

  //Singleton Pattern para el constructor
  ApiConnection();
  static final ApiConnection api = ApiConnection();

  //post method
  Future<dynamic> getPrice(Uint8List image) async {
    String methodUrl = "predict";
    try {
      String name = "image0001";
      String extensionFile = ".jpg";
      var filename = name + extensionFile;

      //File imageFile = await FilePathProvider.getFile(image, name, extensionFile);
      //var stream = imageFile.readAsBytes().asStream();
      //var length = imageFile.lengthSync();

      //Uri uri = Uri.https(baseUrl, methodUrl);
      Uri uri = Uri.http(baseUrl, methodUrl);
      var request = http.MultipartRequest('POST', uri);

      //multipart that takes bytes
      var multipartFile = new http.MultipartFile.fromBytes('image', image,
          filename: filename, contentType: MediaType('multipart', 'form-data'));

      // add file to multipart
      request.files.add(multipartFile);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      return response.body;
    } catch (e) {
      print(e);
    }
    return 0;
  }
}
