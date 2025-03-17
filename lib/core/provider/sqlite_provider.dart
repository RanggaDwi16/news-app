import 'dart:async';
import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';

part 'sqlite_provider.g.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 2, // Upgrade ke versi 2 untuk perubahan tabel
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE news (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            source TEXT,
            author TEXT,
            title TEXT UNIQUE,
            description TEXT,
            url TEXT,
            urlToImage TEXT,
            publishedAt TEXT,
            content TEXT
          )''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("DROP TABLE IF EXISTS news");
          await _initDatabase();
        }
      },
    );
  }

  static Future<int> insertNews(NewsModel news) async {
    final db = await database;
    return await db.insert(
      'news',
      {
        'source': jsonEncode(news.source?.toJson()),
        'author': news.author,
        'title': news.title,
        'description': news.description,
        'url': news.url,
        'urlToImage': news.urlToImage,
        'publishedAt': news.publishedAt?.toIso8601String(),
        'content': news.content,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<NewsModel>> fetchNews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('news');
    return maps.map((map) {
      return NewsModel(
        source: map['source'] != null ? Source.fromJson(jsonDecode(map['source'])) : null,
        author: map['author'],
        title: map['title'],
        description: map['description'],
        url: map['url'],
        urlToImage: map['urlToImage'],
        publishedAt: map['publishedAt'] != null ? DateTime.parse(map['publishedAt']) : null,
        content: map['content'],
      );
    }).toList();
  }

  static Future<void> deleteNews(String title) async {
    final db = await database;
    await db.delete('news', where: 'title = ?', whereArgs: [title]);
  }

  static Future<bool> isFavorite(String title) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('news', where: 'title = ?', whereArgs: [title]);
    return maps.isNotEmpty;
  }
}

@riverpod
Future<List<NewsModel>> fetchFavoriteNews(FetchFavoriteNewsRef ref) async {
  return await DatabaseHelper.fetchNews();
}
