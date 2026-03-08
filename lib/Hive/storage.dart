import 'package:fake_assigment_1/news/model/news_item.dart';
import 'package:hive_flutter/hive_flutter.dart';


class ReadStorage {
  late Box readBox;
  
  Future<void> init() async {
    readBox = await Hive.openBox('readBox');
  }
  //save read new
  void saveReadNew(NewsItem newsItem) {
    readBox.put(newsItem.title, true);
  }
  //check read new
  bool isReadNew(NewsItem newsItem) {
    return readBox.get(newsItem.title) == true;
  }
  //delete read new
  void deleteReadNew(NewsItem newsItem) {
    readBox.delete(newsItem.title);
  }

}
class NewsStorage {
  late Box newsBox;

 
  void saveNews(List<NewsItem> newsItems) {
    for (NewsItem oneNew in newsItems) {
      newsBox.put(oneNew.title, {
        'title': oneNew.title,
        'content': oneNew.body,
        'imageUrl': oneNew.image,
        'publishedAt': oneNew.date.toIso8601String(),
        'isRead': oneNew.isRead,
        'author': oneNew.author,
      });
    }
  } 

  List<NewsItem> getNews(){
    List<NewsItem> newsItems = [];
    newsBox.values.forEach((element) {
      
      newsItems.add(NewsItem(element['title'],
        element['content'],
        element['author'],
        DateTime.parse(element['publishedAt']),
        element['imageUrl'],
        element['isRead'],
      ));
    });
    return newsItems;
  }
  
  void deleteNews(NewsItem newsItem) {
    newsBox.delete(newsItem.title);
  }
  void clearNews() {
    newsBox.clear();
  }
   Future<void> init() async {
    newsBox = await Hive.openBox('newsBox');
  }

  void saveNewsItem(NewsItem newsItem) {
    newsBox.put(newsItem.title, {
      'title': newsItem.title,
      'content': newsItem.body,
      'imageUrl': newsItem.image,
      'publishedAt': newsItem.date.toIso8601String(),
      'isRead': newsItem.isRead,
      'author': newsItem.author,
    });
  }

}