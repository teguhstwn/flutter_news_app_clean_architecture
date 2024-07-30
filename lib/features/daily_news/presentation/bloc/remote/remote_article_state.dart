part of 'remote_article_bloc.dart';

abstract class RemoteArticleState extends Equatable {
  const RemoteArticleState();

  @override
  List<Object> get props => [];
}

class RemoteArticleInitial extends RemoteArticleState {}

class RemoteArticleEmpty extends RemoteArticleState {}

class RemoteArticleLoading extends RemoteArticleState {}

class RemoteArticleLoaded extends RemoteArticleState {
  final List<ArticleEntity> result;

  const RemoteArticleLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class RemoteArticleError extends RemoteArticleState {
  final String message;

  const RemoteArticleError({required this.message});

  @override
  List<Object> get props => [message];
}
