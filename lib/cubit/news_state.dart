import 'package:fake_assigment_1/news/model/model.dart';
import 'package:fake_assigment_1/news/news.dart';

abstract class NewsState {
  const NewsState();
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  final List<NewsItem> newsItems;
  const NewsLoaded(this.newsItems);
}

class NewsSaved extends NewsState {
  final List<NewsItem> newsSavedItems;
  const NewsSaved(this.newsSavedItems);
}

class NewsError extends NewsState {
  final String message;
  const NewsError(this.message);
}
