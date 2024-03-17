import 'dart:convert';

import 'package:ui/Model.dart';
import 'package:http/http.dart' as http;

class News_Repository {
  Future<News_model> Fetch_news_api_data(String sources) async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=$sources&apiKey=f1e3ee8ef3b64f0f9b34c7587ead2976'));
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return News_model.fromJson(body);
    }
    throw Exception('Error');
    // else{
    //   return News_model.fromJson(body);
    // }
  }
}
