import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_news_app_clean_architecture/core/resources/exception.dart';
import 'package:flutter_news_app_clean_architecture/core/resources/failure.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/data_sources/local/news_local_data_source.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_remote_data_source.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/data/models/article_model.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final NewsLocalDataSource newsLocalDataSource;

  ArticleRepositoryImpl(
      {required this.newsRemoteDataSource, required this.newsLocalDataSource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> getNews() async {
    try {
      final result = await newsRemoteDataSource.getNews();
      // print('2 ===== Article Repository Impl =====');
      // print(result[0].toJson());
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Future<Either<Failure, String>> saveArticle(
      ArticleEntity articleEntity) async {
    try {
      final result = await newsLocalDataSource
          .insertArticle(ArticleModel.fromEntity(articleEntity));
      print('===== Article Repository Impl =====');
      print(result);
      return Right(result);
    } on DatabaseException catch (e) {
      return left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  Future<Either<Failure, String>> removeArticle(
      ArticleEntity articleEntity) async {
    try {
      final result = await newsLocalDataSource
          .removeArticle(ArticleModel.fromEntity(articleEntity));
      return Right(result);
    } on DatabaseException catch (e) {
      return left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}
