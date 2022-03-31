import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/pages/favorites_details_page.dart';

Widget favoriteNewsList(AsyncSnapshot<QuerySnapshot> snapshot) {
  return ListView.builder(
    itemCount: snapshot.data?.docs.length,
    itemBuilder: (context, index) {
      QueryDocumentSnapshot<Object?> documentSnapshot =
          snapshot.data!.docs[index];
      String urlToImage = documentSnapshot['urlToImage'] ??
          'https://mizez.com/custom/mizez/img/general/no-image-available.png';
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FavoritesDetailPage(documentSnapshot: documentSnapshot)));
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
                  documentSnapshot['source'],
                  style: const TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                documentSnapshot['title'],
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
