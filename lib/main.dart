import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_clean_architecture/config/routes/routes.dart';
import 'package:flutter_news_app_clean_architecture/config/theme/app_overlay.dart';
import 'package:flutter_news_app_clean_architecture/config/theme/app_themes.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/pages/bottom_nav.dart';
import 'package:flutter_news_app_clean_architecture/injection_container.dart'
    as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppOverlay.mySystemTheme,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RemoteArticleBloc>(
            create: (context) => di.locator()..add(const FetchArticle()),
          ),
          BlocProvider<LocalArticleBloc>(
            create: (context) => di.locator<LocalArticleBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: const BottomNavigation(),
        ),
      ),
    );
  }
}
