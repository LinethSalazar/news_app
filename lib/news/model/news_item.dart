import 'package:equatable/equatable.dart';

//Simple class to represent NewsItems
class NewsItem extends Equatable{

  final String title;
  final String body;
  final String author;
  final DateTime date;

  //has the article been read?
  final bool isRead;

  //image url
  final String image;

  ///construct a news item
  NewsItem( this.title, this.body, this.author, this.date, this.image, this.isRead);

  ///return a copy of the newsItem but with the read flag set to true
  NewsItem readVersion() {
    return NewsItem(this.title, this.body, this.author, this.date, this.image, true);
  }

  //properties involved in the override for == and hashCode
  @override
  List<Object?> get props => [title, body, author, date, isRead];

  //Equatable library convert this object to a string
  bool get stringify => true;
}