import 'package:flutter/material.dart';

import 'package:news_api/pages/details_page.dart';

import '../models/news_model.dart';

Widget newsListWidget(AsyncSnapshot<List<ArticleModel>> snapshot) {
  List<ArticleModel>? articles = snapshot.data;
  return ListView.builder(
    itemCount: articles!.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        articles: articles[index],
                      )));
        },
        child: Container(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
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
                      image: NetworkImage(articles[index].urlToImage ??
                          'https://mizez.com/custom/mizez/img/general/no-image-available.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  articles[index].source.name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                articles[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
