import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiConnection {

  final String baseUrl = "www.loquesea.com";
  final String apiVersion = "/v1/";

  //Singleton Pattern para el constructor
  ApiConnection();
  static final ApiConnection api = ApiConnection();

  //post method
  Future<dynamic> getPrice(Uint8List image) async {

    String methodUrl = apiVersion + "post/image/return/price";
    try {
      Future.delayed(Duration(seconds: 5));
      Uri uri = Uri.https(baseUrl, methodUrl);
      final bytes = image.toList();
      final response = await http.post(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, List<int>>{
            'image': bytes,
          }),
      );
      Map data = jsonDecode(response.body);
      print(data);
      return data;

    } catch(e) {
      print(e);
    }
    return 0;
  }

}