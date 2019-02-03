import 'package:flutter_block_sample/src/models/hacker_news.dart';
import 'package:equatable/equatable.dart';

abstract class HackerNewsState extends Equatable{

  bool get isUpdateComplete => false;
  HackerNewsState._(List props):super(props);
}

class Uninitialized extends HackerNewsState{
  Uninitialized():super._(const []);
}

class TopStoriesFetched extends HackerNewsState {
  final List<int> topStories;
  TopStoriesFetched(this.topStories):super._([topStories]);
}

class StoriesUpdating extends HackerNewsState{
  StoriesUpdating():super._(const []);
}

class StoriesUpdated extends HackerNewsState {
  final List<HackerNews> stories;
  final bool isUpdateComplete;
  StoriesUpdated(this.stories, [this.isUpdateComplete = false]):super._([stories, isUpdateComplete]);
}

class StoriesUpdateFailed extends HackerNewsState {
  final String reason;
  StoriesUpdateFailed(this.reason):super._([reason]);
}