import 'package:flutter/material.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/pages/home/home_news.dart';
import 'package:flutter_news_app_clean_architecture/features/daily_news/presentation/pages/saved_article/saved_article.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  Widget customBottomNav() {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      selectedItemColor: Colors.black,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.newspaper_outlined,
            weight: 18,
            color: currentIndex == 0 ? Colors.amber : const Color(0xff808191),
          ),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark,
            weight: 18,
            color: currentIndex == 1 ? Colors.amber : const Color(0xff808191),
          ),
          label: 'Bookmark',
        ),
      ],
    );
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const SavedArticlePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
