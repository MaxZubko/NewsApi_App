import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';

import 'package:news_api/pages/details_page.dart';

import '../models/news_model.dart';

Widget newsListWidget(AsyncSnapshot<List<ArticleModel>> snapshot) {
  List<ArticleModel>? articles = snapshot.data;
  return ListView.builder(
    itemCount: articles!.length,
    itemBuilder: (context, index) {
      String urlToImage = articles[index].urlToImage ??
          'https://mizez.com/custom/mizez/img/general/no-image-available.png';
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        articles: articles[index],
                        source: articles[index].source.name,
                      )));
        },
        child: Container(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.all(8.0),
          decoration: kBoxDecorationShadow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(urlToImage), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  articles[index].source.name,
                  style: const TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(articles[index].title, style: kTextStyle)
            ],
          ),
        ),
      );
    },
  );
}
