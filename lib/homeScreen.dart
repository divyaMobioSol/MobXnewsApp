import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_newapp/articles.dart';
import 'package:mobx_newapp/news_store.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsStore newsStore = NewsStore();
  List<Articles> articles = [];

  getNews() async {
    await newsStore.fetchArticle();
    articles.addAll(newsStore.articles);
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News App')),
      body: Observer(
          builder: (_) => (!articles.isEmpty)
              ? ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ExpansionTile(
                        title: Text(
                          articles[i].title!,
                          style: TextStyle(fontSize: 24.0),
                        ),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("${articles[i].author} comments"),
                              IconButton(
                                onPressed: () async {
                                  if (await canLaunchUrl(
                                      Uri.parse(articles[i].url!))) {
                                    launchUrl(Uri.parse(articles[i].url!));
                                  }
                                },
                                icon: const Icon(Icons.launch),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
