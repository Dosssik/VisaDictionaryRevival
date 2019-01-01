import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final dataSource = <String>["fasdf", "rweroiwe", "vvvvv"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Дайте визу"),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: dataSource.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(dataSource[index]),
              subtitle: Text("Subtitle"),

            );
          }, separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
