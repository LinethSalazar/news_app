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
      emit(NewsLoaded(newsItems, savedNewsItems));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
  
//mark news as read
  void readNew(NewsItem newsItem) {
    int index;
    if (newsItems.contains(newsItem)) {
      index = newsItems.indexOf(newsItem);
      //store it in the read news box, to later check if it is read or not
      readStorage.saveReadNew(newsItem);
      //save the readed version of the news item
      final NewsItem newItem = newsItems[index].readVersion();
      newsItems[index] = newItem;

    }

    if (savedNewsItems.contains(newsItem)) {
      index = savedNewsItems.indexOf(newsItem);
      //store in the readed box
      readStorage.saveReadNew(newsItem);
      //save the readed version in the saved news list
      final NewsItem newItem = savedNewsItems[index].readVersion();
      savedNewsItems[index] = newItem;
    }
    emit(NewsLoaded(newsItems, savedNewsItems));
  }
  //add news, to later save
  void addNew(NewsItem newsItem) {
    if (!savedNewsItems.contains(newsItem)) {
      newsStorage.saveNewsItem(newsItem); 
      savedNewsItems.add(newsItem);
      emit(NewsLoaded(newsItems, savedNewsItems));
    }
  }
  
  //check readed news
  void checkReadedNews() {
    for (int i = 0; i < newsItems.length; i++) {
      if (readStorage.isReadNew(newsItems[i])) {
        newsItems[i] = newsItems[i].readVersion();
      }
    }
    for (int i = 0; i < savedNewsItems.length; i++) {
      if (readStorage.isReadNew(savedNewsItems[i])) {
        savedNewsItems[i] = savedNewsItems[i].readVersion();
      }
    }
    emit(NewsLoaded(newsItems, savedNewsItems));
  }
  

}