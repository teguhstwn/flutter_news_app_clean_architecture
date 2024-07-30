import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/widgets/category_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? tappedIndex;
  String? tappedCategory;

  final categorys = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

  @override
  void initState() {
    super.initState();
    tappedCategory = 'Business';
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  @override
  Widget build(BuildContext context) {
    _buildAppbar(BuildContext context) {
      return AppBar(
        title: const Text(
          'Daily News',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.flag_rounded, color: Colors.black),
            ),
          ),
        ],
      );
    }

    Widget _buildCategories() {
      return Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              color: const Color(0xfff6f8fb),
              // height: MediaQuery.of(context).size.height * 0.05,
              height: 40,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: categorys.map(
                  (ctg) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          tappedCategory = ctg;
                        });
                      },
                      child: CategoryItemWidget(
                        title: ctg,
                        isSelected: ctg == tappedCategory,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildBody() {
      return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, state) {
          if (state is RemoteArticleLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is RemoteArticleError) {
            return const Center(
              child: Icon(Icons.refresh_rounded),
            );
          }

          if (state is RemoteArticleLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ArticleWidget(
                  article: state.result[index],
                  onArticlePressed: (article) {
                    // print('Klik Detail Article ${article.title}');
                    _onArticlePressed(context, article);
                  },
                );
              },
              itemCount: state.result.length,
            );
          }

          return const SizedBox();
        },
      );
    }

    return Scaffold(
      appBar: _buildAppbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategories(),
          Expanded(child: _buildBody()),
        ],
      ),
      // body: _buildCategories(),
    );
  }
}
