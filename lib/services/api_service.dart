import 'dart:convert';

import 'package:http/http.dart' as http;

import '../configs/news_conf.dart';
import '../models/news_model.dart';

class ApiService {
  Future<List<ArticleModel>> getArticle({String query = 'keyword'}) async {
    final response = await http.get(
        Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['articles'];

      List<ArticleModel> articles =
          body.map((dynamic item) => ArticleModel.fromJson(item)).toList();

      return articles;
    } else {
      throw ('Failed to load articles');
    }
  }
}
