import 'package:alex_news/components/customListTile.dart';
import 'package:alex_news/components/searchListTile.dart';
import 'package:alex_news/model/article_model.dart';
import 'package:alex_news/pages/search_page.dart';
import 'package:alex_news/services/api_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApiService client;
  late List<Article> searchArticles;

  @override
  void initState() {
    super.initState();
    client = ApiService();
    searchArticles = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              'App',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Article>>(
        future: client.getArticle(),
        builder: (BuildContext cotext, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article>? articles = snapshot.data;
            return ListView.builder(
              itemCount: articles?.length,
              itemBuilder: (context, index) =>
                  customListTile(articles![index], context),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
          ).then((value) {
            if (value != null && value.isNotEmpty) {}
          });
        },
        tooltip: 'Search',
        child: Icon(Icons.search),
      ),
    );
  }
}
