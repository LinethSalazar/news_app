import 'package:flutter/material.dart';
import 'package:fake_assigment_1/news/model/news_item.dart';
class NewView extends StatelessWidget{

  final NewsItem newsItem;
  
  NewView({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(newsItem.title), backgroundColor: const Color.fromARGB(117, 79, 255, 214),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(newsItem.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(newsItem.author, style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            Text(newsItem.date.toString(), style: TextStyle(fontSize: 12, color: Colors.indigo)),
            Image(image:  NetworkImage(newsItem.image), width: double.infinity, height: 200, fit: BoxFit.cover),
            Text(newsItem.body, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
