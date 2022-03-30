import 'package:flutter/material.dart';

class FavoritesNewsPage extends StatelessWidget {
  const FavoritesNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Favorite'),
      ),
    );
  }
}
