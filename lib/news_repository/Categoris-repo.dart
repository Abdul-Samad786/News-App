import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ui/Catergries_Model.dart';

class Categories_repository {
  Future<Categories_Model> fetch_catergory_api(String category) async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=$category&apiKey=f1e3ee8ef3b64f0f9b34c7587ead2976'));
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Categories_Model.fromJson(body);
    }
    throw Exception('Error');
  }
}
