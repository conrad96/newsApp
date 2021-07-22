import 'package:flutter/material.dart';

class News
{
  var id, url, title, content, publisher, author, image, publishedDate, description;

  News(this.id, this.url, this.title, this.content, this.publisher, this.author, this.image, this.publishedDate, this.description);

  News.fromJSON(Map<String, dynamic> json)
  {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    content = json['content'];
    publisher = json['publisher'];
    author = json['author'];
    image = json['urlToImage'];
    publishedDate = json['publishedAt'];
    description = json['description'];
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
           title: Text('News Updates'),
           centerTitle: true
         ),
       )
     ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh_sharp),
        onPressed: ()
        {

        },
        backgroundColor: Colors.green,
      ),
    );
  }
}

void main()
{
  runApp(NewsApp());
}