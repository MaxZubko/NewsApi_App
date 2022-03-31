import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_api/repositories/firestore_repository.dart';
import 'package:news_api/widgets/favorite_news_list.dart';

class FavoritesNewsPage extends StatelessWidget {
  FavoritesNewsPage({Key? key}) : super(key: key);

  Stream<QuerySnapshot<Object?>> newsData = Database().getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Favorites', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: newsData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return favoriteNewsList(snapshot);
        },
      ),
    );
  }
}
