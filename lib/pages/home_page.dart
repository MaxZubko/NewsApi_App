import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/pages/favorites_page.dart';
import 'package:news_api/services/api_service.dart';
import 'package:news_api/widgets/news_list.dart';

import '../widgets/custom_search_delegate.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: const TextSpan(children: [
          TextSpan(
              text: 'Flutter',
              style: TextStyle(
                  color: iconColor, fontWeight: FontWeight.bold, fontSize: 20)),
          TextSpan(
              text: 'News',
              style: TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20))
        ])),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: iconColor,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.star_border),
          color: iconColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => FavoritesNewsPage())));
          },
        ),
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: client.getArticle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return newsListWidget(snapshot);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
