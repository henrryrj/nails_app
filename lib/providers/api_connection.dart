
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nails_app/utilities/general/file-path-provider.dart';


class ApiConnection {

  final String baseUrl = "nailprice.herokuapp.com";
  final String baseTest = "127.0.0.1:5500";

  //Singleton Pattern para el constructor
  ApiConnection();
  static final ApiConnection api = ApiConnection();

  //post method
  Future<dynamic> getPrice(Uint8List image) async {

    String methodUrl = "predict";
    try {

      String name = "image0001";
      String extensionFile = "jpg";
      File imageFile = await FilePathProvider.getFile(image, name, extensionFile);
      var filename = imageFile.path;

      // open a bytestream
      var stream = imageFile.readAsBytes().asStream();
      // get file length
      var length = imageFile.lengthSync();

      Uri uri = Uri.https(baseUrl, methodUrl);
      var request = http.MultipartRequest('POST', uri);

      // multipart that takes file
      var multipartFile = new http.MultipartFile(
          'image',
          stream,
          length,
          filename: filename.split("/").last,
        contentType: MediaType('multipart','form-data')
      );

      // add file to multipart
      request.files.add(multipartFile);

      var response = await request.send();
      print(response);
      if (response.statusCode == 200) print('Uploaded!');
      return response;

    } catch(e) {
      print(e);
    }
    return 0;
  }

}