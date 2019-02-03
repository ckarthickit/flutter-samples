import 'package:flutter_block_sample/src/models/hacker_news.dart';

abstract class HackerNewsState {
  const HackerNewsState._();
}

class TopStoriesFetched extends HackerNewsState {
  final List<int> topStories;
  TopStoriesFetched(this.topStories):super._();
}

class StoriesUpdated extends HackerNewsState {
  final List<HackerNews> stories;
  StoriesUpdated(this.stories):super._();
}

class StoriesUpdateFailed extends HackerNewsState {
  final String reason;
  StoriesUpdateFailed(this.reason):super._();
}

class StoriesUpdateComplete extends HackerNewsState {
  StoriesUpdateComplete():super._();
}