import 'package:flutter/material.dart';

class SavedArticlePage extends StatelessWidget {
  const SavedArticlePage({super.key});

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // leading: Builder(
      //   builder: (context) => GestureDetector(
      //     behavior: HitTestBehavior.opaque,
      //     onTap: () => _onBackButtonTapped(context),
      //     child: const Icon(Icons.chevron_left, color: Colors.black),
      //   ),
      // ),
      title: const Text(
        'Saved Articles',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return const Center(
      child: Text(
        'NO SAVED ARTICLES',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // void _onBackButtonTapped(BuildContext context) {
  //   Navigator.pop(context);
  // }
}
