import 'dart:async';

import 'package:flutter_block_sample/src/bloc/internal/block_base.dart';
import 'package:flutter_block_sample/src/models/hacker_news.dart';
import 'package:flutter_block_sample/src/models/hacker_news_feed.dart';

class HackerNewsBloc implements BaseBloc {
  List<HackerNews> _cachedNewsFeed = [];
  StreamController<List<HackerNews>> _hackerNewsStreamController = new StreamController.broadcast();

  Stream<List<HackerNews>> get hackerNewsStream => _hackerNewsStreamController.stream;
  
  HackerNewsBloc() {
    HackerNewsFeed.fetchTopStories()
    .then((storyIDs){
      List<Future<HackerNews>> futures = storyIDs.map((storyID) => HackerNewsFeed.fetchNewsItem(storyID)).toList();
      Future.wait(futures).then((hackerNews) {
        _cachedNewsFeed = List<HackerNews>.from(hackerNews);
        _hackerNewsStreamController.add(_cachedNewsFeed);
      });
    });
  }


  @override
  void dispose() {
    _hackerNewsStreamController.close();
  }

}