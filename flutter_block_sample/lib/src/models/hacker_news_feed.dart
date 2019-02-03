import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter_block_sample/src/models/hacker_news.dart';
import 'package:flutter_block_sample/src/models/serializers.dart';

import 'package:http/http.dart' as http;


class HackerNewsFeed {
  static const baseURL = 'https://hacker-news.firebaseio.com/v0/';

  static Future<List<int>> fetchTopStories() async {
    final response = await http.get(Uri.parse(baseURL + 'topstories.json'));
    //print('response: ${response.body}');
    final parsed = convert.jsonDecode(response.body);
    List<int> topStoriesID = List<int>.from(parsed);
    return topStoriesID; 
  }

  static Future<HackerNews> fetchNewsItem(int newsID) async {
    final response = await http.get(Uri.parse(baseURL + 'item/$newsID.json'));
    print('response: ${response.body}');
    final parsed = convert.jsonDecode(response.body);
    HackerNews newsItem = serializers.deserializeWith(HackerNews.serializer, parsed);
    print('newsItem= $newsItem');
    return newsItem;
  }
}