import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/bloc/local/local_article_bloc.dart';

class ArticleDetailsView extends StatefulWidget {
  final ArticleEntity articleEntity;
  const ArticleDetailsView({super.key, required this.articleEntity});

  @override
  State<ArticleDetailsView> createState() => _ArticleDetailsViewState();
}

class _ArticleDetailsViewState extends State<ArticleDetailsView> {
  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          context
              .read<LocalArticleBloc>()
              .add(SaveArticleEvent(articleEntity: widget.articleEntity));
        },
        // child: const Icon(
        //   Icons.bookmark,
        //   color: Colors.white,
        // ),
        child: BlocConsumer<LocalArticleBloc, LocalArticleState>(
          listener: (context, state) {
            print(state);
            if (state is LocalArticleStatus) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(state.message.toString()),
                ),
              );
            }

            if (state is LocalArticleError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LocalArticleLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Icon(
              Icons.bookmark,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Icons.chevron_left_outlined, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.articleEntity.title!,
            style: const TextStyle(
                fontFamily: 'Butler',
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),

          const SizedBox(height: 14),
          // DateTime
          Row(
            children: [
              const Icon(Icons.access_time, size: 16),
              const SizedBox(width: 4),
              Text(
                widget.articleEntity.publishedAt!,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
        widget.articleEntity.urlToImage!,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${widget.articleEntity.description ?? ''}\n\n${widget.articleEntity.content ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildArticleTitleAndDate(),
          _buildArticleImage(),
          _buildArticleDescription(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('===== value url to image =====');
    // print(widget.articleEntity.urlToImage);
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    context
        .read<LocalArticleBloc>()
        .add(SaveArticleEvent(articleEntity: widget.articleEntity));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully.'),
      ),
    );
  }
}
