import 'package:fake_assigment_1/Hive/storage.dart';
import 'package:fake_assigment_1/cubit/news_state.dart';
import 'package:fake_assigment_1/news/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class NewsCubit extends Cubit<NewsState> {
  final ReadStorage readStorage = ReadStorage();
  final NewsStorage newsStorage = NewsStorage();
  final NewsCacheStorage newsCacheStorage = NewsCacheStorage();
  List<NewsItem> newsItems = [];
  List<NewsItem> savedNewsItems = [];
  final NewsDatabase newsDatabase = NewsDatabase();


  NewsCubit() : super(NewsInitial());

//create singleton for database
  Future <void> databaseSingleton() async {
     
    try {
      emit(NewsLoading());
      
      await readStorage.init();
      await newsStorage.init();
      await newsCacheStorage.init();

      newsCacheStorage.upToDate(Date: DateTime.now());
      savedNewsItems = newsStorage.getNews();
      newsItems = newsCacheStorage.getNews();

      if (!(newsItems.isEmpty && savedNewsItems.isEmpty)) {
        checkReadedNews();
        emit(NewsLoaded(newsItems, savedNewsItems)); 
      }

      newsItems = await newsDatabase.getNewsItems();
      newsCacheStorage.saveNews(newsItems);
      checkReadedNews();
      emit(NewsLoaded(newsItems, savedNewsItems));


    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
  Future<void> refreshNews() async {
    try {
      emit(NewsLoading(),); 
      newsItems = await newsDatabase.getNewsItems();
      newsCacheStorage.saveNews(newsItems);
      checkReadedNews();
      emit(NewsLoaded(newsItems, savedNewsItems));
    } catch (e) {
      if (newsItems.isNotEmpty || savedNewsItems.isNotEmpty) {
        emit(NewsLoaded(newsItems, savedNewsItems));
      } else {
        emit(NewsError(e.toString()));
      }
    }
  }
  bool newInCache(NewsItem news) {
    if(newsItems.contains(news)){
      return true;
    }else{
      return false;
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
  Future<void> clearNewsCache() async {
  newsCacheStorage.clearNews();
  newsItems = [];
  emit(NewsLoaded(newsItems, savedNewsItems));
}

Future<void> clearSavedArticles() async {
  newsStorage.clearNews();
  savedNewsItems = [];
  emit(NewsLoaded(newsItems, savedNewsItems));
}

Future<void> clearReadHistory() async {
  readStorage.clearRead();
  checkReadedNews();
  emit(NewsLoaded(newsItems, savedNewsItems));
}
Future<void> clearImageCache() async {
  await DefaultCacheManager().emptyCache();
  imageCache.clear();
  imageCache.clearLiveImages();
  emit(NewsLoaded(newsItems, savedNewsItems));
}
}