import 'package:fake_assigment_1/news/model/fetcher/online_news_gen.dart';

import '../model.dart';


///Singleton pattern for holding News articles
class NewsDatabase {

  static final NewsDatabase _singleton = NewsDatabase._internal();

  //change the source of the news here
  //final NewsSourcer _news = FakeNewsGenerator();
  final NewsSourcer _news = OnlineNewsGen();
  factory NewsDatabase() {
    return _singleton;
  }

  //private named constructor
  NewsDatabase._internal();

  ///get all of the news items
  Future<List<NewsItem>> getNewsItems() {
    return _news.getNews();
  }
}