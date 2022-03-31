import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/widgets/snack_bar.dart';

import '../repositories/firestore_repository.dart';

class FavoritesDetailPage extends StatelessWidget {
  QueryDocumentSnapshot<Object?> documentSnapshot;

  FavoritesDetailPage({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          documentSnapshot['source'],
          style: const TextStyle(color: iconColor),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: const BackButton(color: iconColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            color: iconColor,
            onPressed: () {
              Database().deleteNewsFromFavorite(documentSnapshot.id);
              showSnackBarDeleteFavorites(context);
              Navigator.pop(context);
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
                  image: NetworkImage(documentSnapshot['urlToImage'] ??
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
                Text(documentSnapshot['title'],
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
                  documentSnapshot['description'],
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
