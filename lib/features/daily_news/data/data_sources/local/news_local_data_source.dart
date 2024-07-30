import 'package:flutter_news_app_clean_architecture/core/resources/exception.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/data_sources/local/db/database_helper.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/models/article_model.dart';

abstract class NewsLocalDataSource {
  Future<String> insertArticle(ArticleModel articleModel);
  Future<String> removeArticle(ArticleModel articleModel);
  Future<ArticleModel?> getArticleById(int id);
  Future<List<ArticleModel>> getArticleBookmarks();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final DatabaseHelper databaseHelper;
  NewsLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<ArticleModel>> getArticleBookmarks() async {
    final result = await databaseHelper.getArticle();
    return result.map((data) => ArticleModel.fromJson(data)).toList();
  }

  @override
  Future<ArticleModel?> getArticleById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<String> insertArticle(ArticleModel articleModel) async {
    try {
      bool result = await databaseHelper.insertArticle(articleModel);
      if (result) {
        return 'Added to Watchlist';
      } else {
        return 'News Alredy Bookmark';
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeArticle(ArticleModel articleModel) async {
    try {
      await databaseHelper.removeArticle(articleModel);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
