import 'package:flutter/material.dart';

class DemoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ConstrainedBox(
                constraints: BoxConstraints.loose(Size(double.infinity,150)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                  isThreeLine: true,
                  title: Text('Title $index\nDesription $index\nMisc $index'),
                  subtitle: Text('Subtitle $index'),
                  leading: Icon(Icons.insert_drive_file),
                  trailing: Image.network(
                    'https://picsum.photos/100?image=$index',
                    scale: 1.0,
                  ),
                  //trailing: Icon(Icons.find_in_page),
              ),
                ),
            );
          },
        ),
      ),
    );
  }
}