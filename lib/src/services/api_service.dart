import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String baseUrl = dotenv.env['API_BASE_URL']!;

  /// Uploads three dental images for analysis.
  Future<Map<String, dynamic>> uploadDentalImages(
      File frontImage, File upperImage, File lowerImage, String memberId) async {
    final uri = Uri.parse("$baseUrl/upload_images");
    var request = http.MultipartRequest('POST', uri);
    request.fields['memberId'] = memberId;
    request.files.add(await http.MultipartFile.fromPath('front_image', frontImage.path));
    request.files.add(await http.MultipartFile.fromPath('upper_image', upperImage.path));
    request.files.add(await http.MultipartFile.fromPath('lower_image', lowerImage.path));
    request.headers['Authorization'] = 'Bearer ${dotenv.env['API_KEY']}';

    var response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } else {
      throw Exception('Failed to upload images. Status code: ${response.statusCode}');
    }
  }

  /// Optionally, fetch analysis by image ID.
  Future<Map<String, dynamic>> fetchAnalysis(String imageId) async {
    final uri = Uri.parse("$baseUrl/analysis/$imageId");
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer ${dotenv.env['API_KEY']}'
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load analysis');
    }
  }
}
