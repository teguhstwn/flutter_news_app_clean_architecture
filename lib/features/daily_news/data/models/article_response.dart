import 'package:equatable/equatable.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/models/article_model.dart';

class ArticleResponse extends Equatable {
  final List<ArticleModel> articleList;

  const ArticleResponse({required this.articleList});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      ArticleResponse(
        articleList: List<ArticleModel>.from(
            (json["articles"] as List).map((x) => ArticleModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "articles": List<dynamic>.from(articleList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [articleList];
}
