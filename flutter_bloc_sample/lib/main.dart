import 'package:flutter/material.dart';
import 'package:flutter_block_sample/src/bloc/hacker_news_events.dart';
import 'package:flutter_block_sample/src/bloc/hacker_news_states.dart';

import 'package:flutter_block_sample/src/bloc/internal/block_provider_widget.dart';
import 'package:flutter_block_sample/src/bloc/hacker_news_bloc.dart';
import 'package:flutter_block_sample/src/models/hacker_news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter BLoC Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: BlocProviderWidget(
        bloc: HackerNewsBloc(),
        child: MyHomePage(title: 'Flutter BLoC Demo')
        ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState(new HackerNewsBloc());
}

class _MyHomePageState extends State<MyHomePage> {
  final HackerNewsBloc _bloc;

  _MyHomePageState(this._bloc);

  @override
  void initState() {
    super.initState();
    _bloc.hackerNewsEventSink.add(const FetchTopStoriesListEvent());
    _bloc.hackerNewsEventSink.add(FetchNextStoryBatchEvent(20));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: BlocProviderWidget(
            bloc: _bloc,
            child: StreamBuilder<HackerNewsState>(
            stream: _bloc.hackerNewsUpdateStream,
            builder: (BuildContext context, AsyncSnapshot<HackerNewsState> snapshot) {
              if(snapshot.data is! StoriesUpdated || snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Loading...',
                  ),
                ));
              }else if(snapshot.hasData) {
                StoriesUpdated storiesUpdatedState = (snapshot.data as StoriesUpdated);
                return ListView.builder(
                  itemCount: storiesUpdatedState.stories.length ,
                  itemBuilder: (BuildContext context, int index) {
                    HackerNews news = storiesUpdatedState.stories[index];
                    return ListTile(
                      title: Text(news.title),
                    );
                  },
                );
              }else{
                return Center(child: Text('Empty'));
              }
            },
          ),
        ),
      )
    );
  }
}
