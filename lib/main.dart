import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        primaryColor: Colors.redAccent
      ),
      home: HomePage(),
      title: 'News Application',
      initialRoute: '/',
      routes: {
        // '/NewsPage': (context) => NewsScreen()
      }
    );
  }

}

class HomePage extends StatefulWidget
{
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  static List<News> _news = <News>[];
  static List<News> _newsApp = <News>[];

  Future<List<News>> NewsUpdates() async
  {
    var apiKey = 'a1cebc277d9748609ce9526fe1f59028';
    var url = 'https://newsapi.org/v2/top-headlines?q=crypto&apiKey='+apiKey;
    var response = await http.get(Uri.parse(url));
    var newsList = <News>[];

    if(response.statusCode == 200)
    {
      var data = json.decode(response.body);

      for(var content in data['articles'])
      {
        newsList.add(News.fromJSON(content));
      }
    }

    return newsList;
  }

  void initState()
  {
    NewsUpdates().then((value) {
      setState(() {
        _news.addAll(value);
        _newsApp = _news;
      });
    }).catchError((error) => print(error));

    super.initState();
  }

  NewsTile(index)
  {
    return Card(
      elevation: 7.0,
      child: Container(
        child: Column(
          children: [
            ListTile(
                leading: Image.network(_newsApp[index].image),
                title: Text(_newsApp[index].title),
                subtitle: Text(_newsApp[index].publishedDate)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsScreen(image: _newsApp[index].image, description: _newsApp[index].content),
                    ),
                  );
                },
                    child: Row(
                      children: [
                        Text('Read More'),
                        SizedBox(width: 10),
                        Icon(Icons.read_more)
                      ],
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

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
          //refresh news feed
        },
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemBuilder: (context, index)=> NewsTile(index),
        itemCount: _newsApp.length,
      )
    );
  }
}

class NewsScreen extends StatelessWidget
{
  NewsScreen({this.image, this.description});
  var image, description;

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: Card(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.network(image),
              SizedBox(height: 10),
              DropCapText(description),
            ],
          )
      ),
    );
  }
}

void main()
{
  runApp(NewsApp());
}