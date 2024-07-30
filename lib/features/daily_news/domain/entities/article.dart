import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  ArticleEntity({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  int? id;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

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
