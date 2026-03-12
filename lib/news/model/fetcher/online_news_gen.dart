import 'dart:convert';

import 'package:fake_assigment_1/news/model/fetcher/news_gen.dart';
import 'package:fake_assigment_1/news/model/news_item.dart';
import 'package:webfeed/webfeed.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;


class OnlineNewsGen implements NewsSourcer {
  String _feedUrl = 'https://www.upei.ca/feeds/news.rss';
  final http.Client httpClient;
  
  OnlineNewsGen({http.Client? client}) : httpClient = client ?? http.Client();

  @override
  Future<List<NewsItem>> getNews() async {
    List<NewsItem> newsItems = [];
    final response = await httpClient.get(Uri.parse(_feedUrl));
    if (response.statusCode != 200) {
      throw Exception('Failed to load news feed');
    }
    var feed = RssFeed.parse(utf8.decode(response.bodyBytes));

    for (var item in feed.items!) {
      String imageUrl = "";
      if (item.link != null) { //getting the link again for the image 
        final articleResponse = await httpClient.get(Uri.parse(item.link!));
        if (articleResponse.statusCode == 200) {
          var articleDocument = parse(utf8.decode(articleResponse.bodyBytes));
          var elements = articleDocument.getElementsByClassName(
            "medialandscape",
          );
          if (elements.isNotEmpty) {
            dom.Element? img = elements[0].querySelector('img');
            imageUrl = img != null
                ? "https://upei.ca/" + (img.attributes['src'] ?? "")
                : "";
          }
        }
      }
      final rawDescription = item.description ?? 'No Description';
      final document = parse(rawDescription);
      final String cleanDescription =
          parse(document.body?.text).documentElement?.text ?? "";
      var newItem = NewsItem(
        item.title ?? 'No Title',
        cleanDescription,
        item.dc?.creator ?? 'Unknown Author',
        item.pubDate ?? DateTime.now(),
        imageUrl, 
        false, 
      );
      newsItems.add(newItem);
    
    }
    return newsItems;
  }
  
}
