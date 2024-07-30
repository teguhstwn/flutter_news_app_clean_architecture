import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/usecases/remove_article.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/usecases/save_article.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final SaveArticleUseCase saveArticle;
  final RemoveArticleUseCase removeArticle;

  LocalArticleBloc({
    required this.saveArticle,
    required this.removeArticle,
  }) : super(LocalArticleInitial()) {
    on<LocalArticleEvent>((event, emit) {});

    on<SaveArticleEvent>((event, emit) async {
      final article = event.articleEntity;
      emit(LocalArticleLoading());

      print(article.toString());

      final result = await saveArticle.execute(articleEntity: article);

      print('===== Local Article Bloc =====');
      print(result);

      result.fold((l) => emit(LocalArticleError(message: l.message)),
          (r) => emit(LocalArticleStatus(isAdded: true, message: r)));
    });

    on<RemoveArticleEvent>((event, emit) {});
  }
}
