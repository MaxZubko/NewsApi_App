import 'package:flutter/material.dart';
import 'package:news_api/models/news_model.dart';

import '../services/api_service.dart';
import 'news_list.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search to news...');

  ApiService client = ApiService();

  final _suggestions = [
    'blockchain',
    'bitcoin',
    'flutter',
    'apple',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: client.getArticle(query: query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return newsListWidget(snapshot);
        } else if (snapshot.hasError) {
          return _showErrorText('${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }

    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _suggestions.length,
    );
  }
}
