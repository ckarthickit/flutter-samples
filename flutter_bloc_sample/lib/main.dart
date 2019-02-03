import 'package:flutter/material.dart';

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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: StreamBuilder<List<HackerNews>>(
          stream: BlocProviderWidget.of<HackerNewsBloc>(context).bloc.hackerNewsStream,
          builder: (BuildContext context, AsyncSnapshot<List<HackerNews>> snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length ,
                itemBuilder: (BuildContext context, int index) {
                  HackerNews news = snapshot.data[index];
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
      )
    );
  }
}
