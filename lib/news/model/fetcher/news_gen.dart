///News Generator
import 'package:fake_assigment_1/news/model/news_item.dart';

///Source the news
abstract class NewsSourcer {

  ///Retrieve a List of NewsItems
  Future<List<NewsItem>> getNews();

}