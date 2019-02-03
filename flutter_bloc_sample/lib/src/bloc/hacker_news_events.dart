abstract class HackerNewsEvent {
  const HackerNewsEvent._();
}

class FetchTopStoriesListEvent extends HackerNewsEvent {
  const FetchTopStoriesListEvent() : super._();
}

/// Fetches the Next batch of
class FetchNextStoryBatchEvent extends HackerNewsEvent {
  final int storyLimit;
  const FetchNextStoryBatchEvent(this.storyLimit) : super._();
}
