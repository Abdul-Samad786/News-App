import 'package:ui/Model.dart';
import 'package:ui/news_repository/Repository.dart';

class View_Model {
  Future<News_model> Fetch_api_data(String channel_name) async {
    News_Repository repo = News_Repository();
    var response = await repo.Fetch_news_api_data(channel_name);
    return response;
  }
}
