import 'dart:convert';

import 'package:aula3/models/image_model.dart';
import 'package:aula3/repositories/interfaces/iimage_repository.dart';
import 'package:http/http.dart' as http;

class ImageRepository implements IImageRepository {
  http.Client _client;
  String baseUrl;
  String apiKey = "YOUR_API_KEY_HERE";

  ImageRepository() {
    _client = http.Client();
    baseUrl = 'https://pixabay.com/api/?key=$apiKey';
  }

  @override
  Future<ImageModel> get() async {
    var response = await _client.get('$baseUrl');
    var body = response.body;
    var jsonMap = json.decode(body);

    return ImageModel.fromJson(jsonMap);
  }
}
