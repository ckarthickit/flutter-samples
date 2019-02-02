import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hacker_news.g.dart';

abstract class HackerNews implements Built<HackerNews, HackerNewsBuilder> {
  static Serializer<HackerNews> get serializer => _$hackerNewsSerializer;
  HackerNews._();
  factory HackerNews([updates(HackerNewsBuilder b)]) = _$HackerNews;
  String get by;
  int get descendants;
  int get id;
  List<int> get kids;
  List<int> get parts;
  int get score;
  int get time;
  String get title;
  String get type;
  String get url;
  int get parent;
  String get text;
}
