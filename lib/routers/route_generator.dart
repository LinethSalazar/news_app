import 'package:fake_assigment_1/views/saved_news_screen.dart';
import 'package:fake_assigment_1/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:fake_assigment_1/news/news.dart';
import 'package:fake_assigment_1/views/homepage_screen.dart';
import 'package:fake_assigment_1/views/new_screen.dart';
import 'package:fake_assigment_1/views/news_screen.dart';
import 'package:fake_assigment_1/views/unknown_screen.dart';

class RouteGenetaror {
  static const String home = '/';
  static const String news = '/news';
  static const String newDetails = '/newsDetails';
  static const String savedNews = '/savedNews';
  static const String sesett = '/settings';

  RouteGenetaror._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomepageScreen());
      case news:
        return MaterialPageRoute(builder: (_) => News());
      case newDetails:
        return MaterialPageRoute(builder: (_) => NewView(newsItem: settings.arguments as NewsItem));
      case savedNews:
        return MaterialPageRoute(builder: (_) => SavedNewsScreen());
      case sesett:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      default:
        return MaterialPageRoute(builder: (_) => UnknownScreen());
    }
  }
}