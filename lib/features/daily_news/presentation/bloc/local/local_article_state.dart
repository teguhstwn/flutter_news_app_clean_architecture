part of 'local_article_bloc.dart';

sealed class LocalArticleState extends Equatable {
  const LocalArticleState();

  @override
  List<Object> get props => [];
}

class LocalArticleInitial extends LocalArticleState {}

class LocalArticleEmpty extends LocalArticleState {}

class LocalArticleLoading extends LocalArticleState {}

class LocalArticleLoaded extends LocalArticleState {
  final List<ArticleEntity> result;
  const LocalArticleLoaded({required this.result});

  @override
  List<Object> get props => [result];
}

class LocalArticleError extends LocalArticleState {
  final String message;
  const LocalArticleError({required this.message});

  @override
  List<Object> get props => [message];
}

class LocalArticleStatus extends LocalArticleState {
  final bool isAdded;
  final String message;

  const LocalArticleStatus({required this.isAdded, required this.message});

  @override
  List<Object> get props => [isAdded, message];
}
