import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';

part 'remote_article_event.dart';
part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase getArticleUseCase;

  RemoteArticleBloc({required this.getArticleUseCase})
      : super(RemoteArticleInitial()) {
    on<RemoteArticleEvent>((event, emit) async {
      emit(RemoteArticleLoading());

      final result = await getArticleUseCase.execute();

      // print('3 ===== Remote Article Bloc =====');

      result
          .fold((failure) => emit(RemoteArticleError(message: failure.message)),
              (data) {
        if (data.isEmpty) {
          emit(RemoteArticleEmpty());
        } else {
          // print(data.length);
          emit(RemoteArticleLoaded(result: data));
        }
      });
    });
  }
}
