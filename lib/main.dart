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
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              NewsTile(),
              NewsTile(),
              NewsTile(),
              NewsTile(),
              NewsTile(),
              NewsTile()
            ],
          )
        ],
      ),
    );
  }
}

class NewsTile extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Card(
      elevation: 7.0,
      child: Container(
        child: Column(
          children: [
            ListTile(
              leading: Image.asset('assets/images/sample.png'),
              title: Text('\nKaseya ransomware attackers demand \$70 million, claim they infected over a million devices\n'),
              subtitle: Text('2021-07-05T19:45:10Z')
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/NewsPage');
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
          Text('Kaseya ransomware attackers demand \$70 million, claim they infected over a million devices'),
          SizedBox(height: 10),
          Text('Three days after ransomware attackers hijacked a managed services platform, recovery efforts continued. The REvil group is reportedly asking for as much as \$70 million in Bitcoin to unlock the more than 1 million devices infected.'),
          SizedBox(height: 10),
          Text('Filed under:\r\nThe supply chain attack has reached over a thousand organizations.\r\nIllustration by Alex Castro / The Verge\r\nThree days after ransomware attackers started the holiday weekend by comprom… [+3376 chars]'),
          Text('Author: Richard Lawler\n Published: 2021-07-05T19:45:10Z')
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