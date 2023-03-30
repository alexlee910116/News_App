import 'package:alex_news/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget searchListTile(Article article, BuildContext context) {
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
          ]),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(article.urlToImage), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            SizedBox(
              height: 8.0,
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
          ]),
    ),
  );
}

