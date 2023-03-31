import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/article_model.dart';
import '../services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  List<Article> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 16.0,
            fontWeight: FontWeight.bold)
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            // color: Colors.black,
            onPressed: () async {
              var keyword = _searchController.text;
              if (keyword.isNotEmpty) {
                var result = await ApiService().searchArticle(keyword);
                setState(() {
                  _searchResults = result;
                });
              }
            },
          ),
        ],
      ),
      body: Container(
        child: _searchResults.isNotEmpty
            ? ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  Article article = _searchResults[index];
                  return InkWell(
                    onTap: () async {
                      if (await canLaunch(article.url)) {
                        await launch(article.url);
                      } else {
                        throw 'Could not launch ${article.url}';
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(article.urlToImage),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            article.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            article.author,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  'Typing the key word',
                  style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                  ),
              ),
      ),
    );
  }
}
