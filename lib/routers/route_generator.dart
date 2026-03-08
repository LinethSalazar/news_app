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


  RouteGenetaror._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomepageScreen());
      case news:
        return MaterialPageRoute(builder: (_) => News());
      case newDetails:
        return MaterialPageRoute(builder: (_) => NewView(newsItem: settings.arguments as NewsItem));
      default:
        return MaterialPageRoute(builder: (_) => UnknownScreen());
    }
  }
}