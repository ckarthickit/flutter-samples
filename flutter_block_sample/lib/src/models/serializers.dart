import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_block_sample/src/models/hacker_news.dart';

part 'serializers.g.dart';

@SerializersFor(const [HackerNews])
//final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();