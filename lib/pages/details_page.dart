import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/widgets/snack_bar.dart';

import '../repositories/firestore_repository.dart';

class DetailPage extends StatefulWidget {
  final ArticleModel articles;
  String? source;

  DetailPage({Key? key, required this.articles, this.source}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  bool _addToFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.articles.source.name,
          style: const TextStyle(color: iconColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(color: iconColor),
        actions: [
          IconButton(
            icon: Icon(_addToFavorites ? Icons.star : Icons.star_border),
            color: iconColor,
            onPressed: () {
              setState(() {
                _addToFavorites = !_addToFavorites;
                showSnackBarAddFavorites(context);
              });
              Database().addNewsToFavorite(
                  widget.articles.urlToImage ??
                      'https://mizez.com/custom/mizez/img/general/no-image-available.png',
                  widget.source,
                  widget.articles.title,
                  widget.articles.description);
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.articles.urlToImage ??
                      'https://mizez.com/custom/mizez/img/general/no-image-available.png'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Text(widget.articles.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10.0,
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[400],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.articles.description ?? 'No info',
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
