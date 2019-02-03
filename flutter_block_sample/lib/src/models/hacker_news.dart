import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hacker_news.g.dart';

abstract class HackerNews implements Built<HackerNews, HackerNewsBuilder> {
  static Serializer<HackerNews> get serializer => _$hackerNewsSerializer;
  HackerNews._();
  factory HackerNews([updates(HackerNewsBuilder b)]) = _$HackerNews;
  int get id;
  String get by;

  @nullable
  int get descendants;
  @nullable
  BuiltList<int> get kids;
  @nullable
  BuiltList<int> get parts;

  int get score;
  int get time;
  String get title;
  String get type;
  @nullable
  String get url;
  @nullable
  int get parent;
  @nullable
  String get text;
}
