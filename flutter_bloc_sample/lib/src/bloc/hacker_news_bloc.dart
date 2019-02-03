import 'dart:async';

import 'package:flutter_block_sample/src/bloc/internal/block_base.dart';
import 'package:flutter_block_sample/src/models/hacker_news.dart';
import 'package:flutter_block_sample/src/models/hacker_news_feed.dart';

class HackerNewsBloc implements BaseBloc {
  List<HackerNews> _cachedNewsFeed = [];
  StreamController<List<HackerNews>> _hackerNewsStreamController = new StreamController.broadcast();
  Stream<List<HackerNews>> get hackerNewsStream => _hackerNewsStreamController.stream;
  
  HackerNewsBloc() {
    final int start = DateTime.now().millisecondsSinceEpoch;
    HackerNewsFeed.fetchTopStories()
    .then((storyIDs){
      
      print('Fetched Top Stories in ${DateTime.now().millisecondsSinceEpoch - start} msec');
      storyIDs = storyIDs.sublist(0, storyIDs.length > 20 ? 20: storyIDs.length);
      List<Future<HackerNews>> futures = storyIDs.map((storyID) => HackerNewsFeed.fetchNewsItem(storyID)).toList();
      Future.wait(futures).then((hackerNews) {
        _cachedNewsFeed = List<HackerNews>.from(hackerNews);
        _hackerNewsStreamController.add(_cachedNewsFeed);
        print('Fetched Story in ${DateTime.now().millisecondsSinceEpoch - start} msec');
      });
      //storyIDs = storyIDs.sublist(0, storyIDs.length > 10 ? 10: storyIDs.length);
      // print('storyIDs.length = ${storyIDs.length}');
      // for(int storyID in storyIDs.sublist(0, storyIDs.length > 20 ? 20: storyIDs.length)) {
      //   HackerNewsFeed.fetchNewsItem(storyID).then((HackerNews news){
      //     _cachedNewsFeed.add(news);
      //     _hackerNewsStreamController.add(List<HackerNews>.from(_cachedNewsFeed));
      //     print('Fetched Story in ${DateTime.now().millisecondsSinceEpoch - start} msec');
      //   });
      // }
    });
  }


  @override
  void dispose() {
    print('dispose');
    _hackerNewsStreamController.close();
  }

}