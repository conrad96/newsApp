import 'package:flutter/material.dart';

class News
{
  var id, url, title, text, publisher, author, image, date;

  News(this.id, this.url, this.title, this.text, this.publisher, this.author, this.image, this.date);

  News.fromJSON(Map<String, dynamic> json)
  {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    text = json['text'];
    publisher = json['publisher'];
    author = json['author'];
    image = json['image'];
    date = json['date'];
  }

}

class NewsApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue
      ),
      home: HomePage(),
      title: 'News Application'
    );
  }

}

class HomePage extends StatefulWidget
{
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  Widget build(BuildContext context)
  {
    return Scaffold(
     appBar: PreferredSize(
       preferredSize: Size.fromHeight(70),
       child: Container(
         child: AppBar(
           title: Text('News Application'),
         ),
       )
     ),
    );
  }
}

void main()
{
  runApp(NewsApp());
}