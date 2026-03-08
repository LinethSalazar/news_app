import 'package:fake_assigment_1/Hive/storage.dart';
import 'package:fake_assigment_1/cubit/news_state.dart';
import 'package:fake_assigment_1/news/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  ReadStorage readStorage = ReadStorage();
  NewsStorage newsStorage = NewsStorage();
  List<NewsItem> newsItems = [];
  List<NewsItem> savedNewsItems = [];

  NewsCubit() : super(NewsInitial());

//create singleton for database
  Future <void> databaseSingleton() async {
    final NewsDatabase newsDatabase = NewsDatabase();
    try {
      emit(NewsLoading());
      
      await readStorage.init();
      await newsStorage.init();
      newsItems = await newsDatabase.getNewsItems();
      savedNewsItems = newsStorage.getNews();
      checkReadedNews();
      emit(NewsLoaded(newsItems));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
  
//mark news as read
  void readNew(NewsItem newsItem) {
    final int index = newsItems.indexOf(newsItem);
    if (index != -1) {
      readStorage.saveReadNew(newsItem);
      final NewsItem newItem = newsItems[index].readVersion();
      newsItems[index] = newItem;
      emit(NewsLoaded(newsItems));
    }else {
      emit(NewsError("News item not found"));
    }
  }
  //add news, to later save
  void addNew(NewsItem newsItem) {
    newsStorage.saveNewsItem(newsItem);
  }
  void addNews(List<NewsItem> newsItems) {
    newsStorage.saveNews(newsItems);
  }
  //delete news, to later save
  void deleteNews(NewsItem newsItem) {
    newsStorage.deleteNews(newsItem);
    emit(NewsLoaded(newsItems));
  }
  //check readed news
  void checkReadedNews() {
    for (int i = 0; i < newsItems.length; i++) {
      if (readStorage.isReadNew(newsItems[i])) {
        newsItems[i] = newsItems[i].readVersion();
      }
    }
  }
  void displayOnlineNews() {
    if (savedNewsItems.isNotEmpty) {
      emit(NewsError("No news available"));
    }else {
      emit(NewsLoaded(newsItems));
    }
  }
  void displaySaved() {
    if (savedNewsItems.isEmpty) {
      emit(NewsError("No news saved"));
    } else {
      emit(NewsSaved(savedNewsItems));
    }
  }

}