import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/article_model.dart';

class ApiService {
  final endPointUrl = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=4590aab7121447c3a85bc7757cc4586a');

  Future<List<Article>> getArticle() async {
    http.Response res = await http.get(endPointUrl);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      // this line will allow us to get the different articles from the json file and putting them into a list
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }

  Future<List<Article>> searchArticle(String keyword) async {
  final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=$keyword&apiKey=4590aab7121447c3a85bc7757cc4586a');

  final res = await http.get(url);

  if (res.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(res.body);

    List<dynamic> body = json['articles'];

    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();

    return articles;
  } else {
    throw ("Can't get the Articles");
  }
}
}