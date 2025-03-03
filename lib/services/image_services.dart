import 'dart:io';
import 'package:http/http.dart' as http;

class ImageServices {
  Future<String?> uploadImage(File imageFile) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dgb8kndnz/image/upload',
      );

      var request =
          http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = 'images'
            ..files.add(
              await http.MultipartFile.fromPath('file', imageFile.path),
            );

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Upload successful: $responseData');
        return responseData;
      } else {
        print('Upload failed: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
