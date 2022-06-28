import 'package:mobx/mobx.dart';
import 'package:mobx_newapp/articles.dart';
import 'package:mobx_newapp/services/services.dart';

part 'news_store.g.dart';

class NewsStore = _NewsStore with _$NewsStore;

abstract class _NewsStore with Store {
  final NetworkService httpClient = NetworkService();

  @observable
  List<Articles> articles = [];

  @observable
  List get loading => articles;

  @action
  Future<List<Articles>> fetchArticle() async {
    await httpClient
        .getData(
            'https://newsapi.org/v2/everything?q=bitcoin&apiKey=1bfba80a852a4a36b61239f758f97cb5')
        .then((articleList) {
      articles.addAll(articleList);
    });
    return articles;
  }

  void getTheArticles() {
    fetchArticle();
  }
}
