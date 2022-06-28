import 'dart:convert';

import 'package:http/http.dart' as http;

import '../articles.dart';

class NetworkService {
  List<Articles> articles = [];

  Future<List<Articles>> getData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      articles = (data["articles"] as List)
          .map((json) => Articles.fromJson(json))
          .toList();
    } else {
      print("Error in URL");
    }
    return articles;
  }
}
