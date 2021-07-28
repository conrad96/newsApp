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
        '/NewsPage': (context) => NewsPage()
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
    var url = 'https://newsapi.org/v2/everything?q=technology&apiKey='+apiKey;
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
                  //Navigator.pushNamed(context, '/NewsPage');
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

class NewsCard extends StatefulWidget
{
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard>
{
  Widget build(BuildContext context)
  {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Image.asset('assets/images/sample.png'),
          SizedBox(height: 10),
          DropCapText('Kaseya ransomware attackers demand \$70 million, claim they infected over a million devices\n '
              'Three days after ransomware attackers hijacked a managed services platform, recovery efforts continued. The REvil group is reportedly asking for as much as \$70 million in Bitcoin to unlock the more than 1 million devices infected. \n Author: Richard Lawler\n Published: 2021-07-05T19:45:10Z'),
        ],
      )
    );
  }
}

class NewsPage extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsCard()
          ],
        ),
      ),
    );
  }
}

void main()
{
  runApp(NewsApp());
}