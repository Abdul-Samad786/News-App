import 'package:ui/Catergries_Model.dart';
import 'package:ui/news_repository/Categoris-repo.dart';

// ignore: camel_case_types
class Categories_View_Model {
  Future<Categories_Model> fetch_api_data(String name) async {
    final response = await Categories_repository().fetch_catergory_api(name);
    return response;
  }
}
