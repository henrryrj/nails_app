
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class FilePathProvider {

  static Future<File> getFile(Uint8List bytes, String name, String fileExtension) async{
    final tempDir = await getTemporaryDirectory();
    final filename = tempDir.path + '/' + name + '.' + fileExtension;
    File file = await File(filename).create();
    file.writeAsBytesSync(bytes);
    return file;
  }
}