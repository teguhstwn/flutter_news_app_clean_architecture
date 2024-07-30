import 'package:equatable/equatable.dart';
import 'package:flutter_news_app_clean_architecture/core/constant/constant.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/entities/article.dart';

class ArticleModel extends Equatable {
  int? id = 0;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  ArticleModel({
    this.id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = id! + 1;
    author = json['author'] ?? "";
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    url = json['url'] ?? "";
    urlToImage = json['urlToImage'] != null && json['urlToImage'] != ""
        ? json['urlToImage']
        : kDefaultImage;
    publishedAt = json['publishedAt'] ?? "";
    content = json['content'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "content": content,
      };

  factory ArticleModel.fromEntity(ArticleEntity news) => ArticleModel(
        id: news.id,
        author: news.author,
        title: news.title,
        description: news.description,
        url: news.url,
        urlToImage: news.urlToImage,
        publishedAt: news.publishedAt,
        content: news.content,
      );

  ArticleEntity toEntity() {
    return ArticleEntity(
      id: id,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }

  @override
  List<Object?> get props => [
        id,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
