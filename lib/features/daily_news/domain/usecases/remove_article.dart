import 'package:dartz/dartz.dart';
import 'package:flutter_news_app_clean_architecture/core/resources/failure.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class RemoveArticleUseCase {
  final ArticleRepository articleRepository;

  RemoveArticleUseCase(this.articleRepository);

  Future<Either<Failure, String>> execute(ArticleEntity articleEntity) {
    return articleRepository.removeArticle(articleEntity);
  }
}
