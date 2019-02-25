import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:rxdart/rxdart.dart';

import 'package:flutter_block_sample/src/bloc/internal/block_base.dart';
import 'hacker_news_events.dart';
import 'hacker_news_states.dart';

import 'package:flutter_block_sample/src/models/hacker_news.dart';
import 'package:flutter_block_sample/src/models/hacker_news_feed.dart';

class HackerNewsBloc implements BaseBloc {
  static const int defaultBatchSize = 10;

  List<HackerNews> _cachedNewsFeed = [];
  List<int> _topStories = [];
  HackerNewsState currentState = Uninitialized();

  int get pendingSize {
    return _topStories.length - _cachedNewsFeed.length;
  }

  int get nextFetchIndex {
    return this.pendingSize > 0 ? _cachedNewsFeed.length : -1;
  }

  int get nextFetchbatchSize {
    return this.pendingSize < defaultBatchSize
        ? this.pendingSize
        : defaultBatchSize;
  }

  StreamController<HackerNewsState> _hackerNewsStateController =
      new StreamController.broadcast();
  PublishSubject<HackerNewsEvent> _hackerNewsEventController =
      new PublishSubject<HackerNewsEvent>();

  Stream<HackerNewsState> get hackerNewsUpdateStream =>
      _hackerNewsStateController.stream.where((state) {
        return state is StoriesUpdated;
      });

  Sink<HackerNewsEvent> get hackerNewsEventSink =>
      _hackerNewsEventController.sink;

  HackerNewsBloc() {
    _bindEventAndState();
  }

  void _bindEventAndState() {
    //Doing the Wiring of Event to State
        //Doing the Wiring of Event to State
    _hackerNewsEventController.stream.listen((event) async {
      if (event is FetchTopStoriesListEvent &&
          currentState == Uninitialized()) {
        _topStories = await HackerNewsFeed.fetchTopStories();
        updateState(TopStoriesFetched(UnmodifiableListView(_topStories)));
        hackerNewsEventSink.add(FetchNextStoryBatchEvent(defaultBatchSize));
      } else if (event is FetchNextStoryBatchEvent) {
        if (currentState == Uninitialized() ||
            currentState == StoriesUpdating()){
          return;
        }
        if(currentState is StoriesUpdated && (currentState as StoriesUpdated).isUpdateComplete) {
          return;
        }
        if (_topStories.length == 0) {
          _hackerNewsStateController.sink
              .add(StoriesUpdateFailed('No Top Stories Available'));
        } else if (nextFetchIndex == -1) {
          updateState(StoriesUpdated(_cachedNewsFeed, true));
        } else {
          updateState(StoriesUpdating());
          if(this.nextFetchbatchSize <= 0) {
           updateState(StoriesUpdated(_cachedNewsFeed, true));
           return;
          }
          List<HackerNews> newsBatch = await HackerNewsFeed.fetchNewsBatch(
              _topStories.sublist(
                  this.nextFetchIndex, this.nextFetchIndex + this.nextFetchbatchSize));
          _cachedNewsFeed.addAll(newsBatch);
          updateState(StoriesUpdated(UnmodifiableListView(_cachedNewsFeed)));
          if (nextFetchIndex == -1) {
            updateState(StoriesUpdated(_cachedNewsFeed, true));
          }
        }
      }
    });
  }

  void updateState<T extends HackerNewsState>(T state) {
    currentState = state;
    _hackerNewsStateController.sink.add(state);
  }

  @override
  void dispose() {
    debugPrint('dispose');
    _hackerNewsStateController.close();
    _hackerNewsEventController.close();
  }
}
