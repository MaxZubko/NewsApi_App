import 'package:flutter/material.dart';
import 'package:news_api/models/news_model.dart';

import '../repositories/firestore_repository.dart';

class DetailPage extends StatelessWidget {
  final ArticleModel articles;
  String? source;

  DetailPage({required this.articles, this.source});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          articles.source.name,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            color: Colors.black,
            onPressed: () {
              Database().addNewsToFavorite(
                  articles.urlToImage ??
                      'https://mizez.com/custom/mizez/img/general/no-image-available.png',
                  source,
                  articles.title,
                  articles.description);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(articles.urlToImage ??
                        'https://mizez.com/custom/mizez/img/general/no-image-available.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              articles.description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
