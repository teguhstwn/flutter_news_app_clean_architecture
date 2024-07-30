import 'dart:convert';

import 'package:flutter_news_app_clean_architecture/core/constant/constant.dart';
import 'package:flutter_news_app_clean_architecture/core/resources/exception.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/models/article_model.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/models/article_response.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getNews() async {
    final response = await client.get(Uri.parse(
        '$newsAPIBaseURL/top-headlines?country=$countryQuery&category=$categoryQuery&apiKey=$newsAPIKey'));

    // print('1 ===== Remote Data Source =====');
    // print(response.request);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return ArticleResponse.fromJson(json.decode(response.body)).articleList;
    } else {
      throw ServerException();
    }
  }
}
