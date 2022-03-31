import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  CollectionReference getMainCollection() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('news');
  }

  Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference mainCollection = getMainCollection();
    return mainCollection.snapshots();
  }

  Future<void> addNewsToFavorite(
    String? urlToImage,
    String? source,
    String? title,
    String? description,
  ) {
    return getMainCollection()
        .add({
          'urlToImage': urlToImage,
          'source': source,
          'title': title,
          'description': description
        })
        .then((value) => print('News Added'))
        .catchError((error) => print('Failed to add news: $error'));
  }

  Future<void> deleteNewsFromFavorite(
    String id,
  ) {
    return getMainCollection()
        .doc(id)
        .delete()
        .then((value) => print('News Deleted'))
        .catchError((error) => print('Failed to delete news: $error'));
  }
}
