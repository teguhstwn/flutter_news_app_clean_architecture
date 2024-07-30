import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/pages/article_details/article_details.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/pages/home/home_news.dart';

import '../../features/daily_news/domain/entities/article.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const HomePage());

      case '/ArticleDetails':
        return _materialRoute(ArticleDetailsView(
            articleEntity: settings.arguments as ArticleEntity));

      case '/SavedArticles':
      // return _materialRoute(const SavedArticles());

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
