import 'dart:async';

import 'package:flutter_news_app_clean_architecture/features/daily_news/data/models/article_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblFavorite = 'bookmark_article';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/newsapp.db';

    print(databasePath);

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblFavorite (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT
      );
    ''');
  }

  Future<bool> insertArticle(ArticleModel news) async {
    final db = await database;

    final result = await db!
        .query(_tblFavorite, where: 'title = ?', whereArgs: [news.title]);

    if (result.isNotEmpty) {
      print('===== Insert Article Alredy Exist =====');
      return false;
    } else {
      print('===== Insert Article Success =====');
      await db.insert(_tblFavorite, news.toJson());
      return true;
    }
  }

  Future<int> removeArticle(ArticleModel news) async {
    final db = await database;
    return await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [news.id],
    );
  }

  Future<Map<String, dynamic>?> getArticleById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getArticle() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblFavorite);
    print('===== Get All Article =====');
    print(results.toString());

    return results;
  }
}
