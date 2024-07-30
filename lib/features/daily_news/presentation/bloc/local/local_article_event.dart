part of 'local_article_bloc.dart';

abstract class LocalArticleEvent extends Equatable {
  const LocalArticleEvent();

  @override
  List<Object> get props => [];
}

class SaveArticleEvent extends LocalArticleEvent {
  final ArticleEntity articleEntity;

  const SaveArticleEvent({required this.articleEntity});

  @override
  List<Object> get props => [articleEntity];
}

class RemoveArticleEvent extends LocalArticleEvent {}

class LoadArticleEvent extends LocalArticleEvent {}
