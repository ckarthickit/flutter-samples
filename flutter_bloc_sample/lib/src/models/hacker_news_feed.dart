import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter_block_sample/src/models/hacker_news.dart';
import 'package:flutter_block_sample/src/models/serializers.dart';

import 'package:http/http.dart' as http;

class HackerNewsFeed {
  static const baseURL = 'https://hacker-news.firebaseio.com/v0/';
  static Future<List<int>> fetchTopStories() async {
    final int start = DateTime.now().millisecondsSinceEpoch;
    final response = await http.get(Uri.parse(baseURL + 'topstories.json'));
    //print('response: ${response.body}');
    final parsed = convert.jsonDecode(response.body);
    List<int> topStoriesID = List<int>.from(parsed);
    print('fetchTopStories done in ${DateTime.now().millisecondsSinceEpoch - start} msec');
    return topStoriesID;
  }

  static Future<HackerNews> fetchNewsItem(int newsID) async {
    final response = await http.get(Uri.parse(baseURL + 'item/$newsID.json'));
    //print('response: ${response.body}');
    final parsed = convert.jsonDecode(response.body);
    HackerNews newsItem =
        serializers.deserializeWith(HackerNews.serializer, parsed);
    //print('newsItem= $newsItem');
    return newsItem;
  }

  static Future<List<HackerNews>> fetchNewsBatch(List<int> storyIDs) async {
    final int start = DateTime.now().millisecondsSinceEpoch;
    List<HackerNews> hackerNewsList = [];
    http.Client client = http.Client();
    try {
      for (int storyID in storyIDs) {
        final response =
            await client.get(Uri.parse(baseURL + 'item/$storyID.json'));
        if(response.statusCode != 200) {
          throw 'Fetch failed for $storyID with status ${response.statusCode}';
        }
        final parsed = convert.jsonDecode(response.body);  
        HackerNews newsItem =
        serializers.deserializeWith(HackerNews.serializer, parsed);
        hackerNewsList.add(newsItem);
        print('fetchStory done in ${DateTime.now().millisecondsSinceEpoch - start} msec');
      }
    } catch (e, s) {
      print('Exception $e occurred at: $s');
    } finally {
      client.close();
    }
    print('batchFetch done in ${DateTime.now().millisecondsSinceEpoch - start} msec');
    return hackerNewsList;
  }
}
