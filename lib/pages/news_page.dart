import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_khabar/pages/single_news_page.dart';
import 'package:online_khabar/pages/home.dart';

import 'package:online_khabar/models/news.dart';

class NewsPage extends StatefulWidget {
  final Function func;

  NewsPage({this.func});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  QuerySnapshot newsDataFuture;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    // getNews();
  }

  // Future<QuerySnapshot> getNews() async {
  //   var snapshot =
  //       await Firestore.instance.collection("collection").getDocuments();
  //   return snapshot;
  // }

  buildNewsProviderTiles({AssetImage image, String title}) {
    return ListTile(
      leading: Container(
        height: 55.0,
        width: 55.0,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: image,
              ),
            ),
          ),
        ),
      ),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Laila',
          ),
        ),
      ),
    );
  }

  buildNewsTiles() {
    return StreamBuilder(
      stream: newsRef.orderBy('timestamp', descending: false).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SpinKitFadingCircle(
            color: Color(0xffa549eb),
          );
        }
        List<NewsTile> newsTiles = [];
        snapshot.data.documents.forEach((doc) {
          News news = News.fromDocuments(doc);

          NewsTile newsTile = NewsTile(
            news: news,
          );
          newsTiles.add(newsTile);
        });
        return ListView(
          controller: _scrollController,
          children: newsTiles,
          shrinkWrap: true,
          reverse: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(milliseconds: 1000),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Color(0xffa549eb),
        centerTitle: true,
        title: Text(
          'समाचार',
          style: TextStyle(
            fontFamily: 'Laila',
            fontSize: 25.0,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    'ताजा खबर',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'laila',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Divider(),
            Column(
              children: <Widget>[
                buildNewsProviderTiles(
                    image: AssetImage('assets/images/onlinekhabarlogo.jpg'),
                    title: 'अनलाइनखबर'),
                Divider(),
                buildNewsProviderTiles(
                    image: AssetImage('assets/images/bbclogo.jpg'),
                    title: 'BBC नेपाली'),
                Divider(),
                buildNewsProviderTiles(
                    image: AssetImage('assets/images/setopatilogo.jpg'),
                    title: 'सेतोपाटी'),
                Divider(),
                buildNewsProviderTiles(
                    image: AssetImage('assets/images/ratopatilogo.jpg'),
                    title: 'रातोपाटी'),
                Divider(),
                buildNewsProviderTiles(
                    image: AssetImage('assets/images/kantipurlogo.png'),
                    title: 'कान्तिपुर'),
                Divider(),
                buildNewsProviderTiles(
                    image: AssetImage('assets/images/baahrakharilogo.png'),
                    title: 'बाह्रखरी'),
                Divider(),
              ],
            )
          ],
        ),
      ),
      body: buildNewsTiles(),
    );
  }
}

class NewsTile extends StatelessWidget {
  final News news;
  NewsTile({this.news});

  configureMediaPreview(String imageUrl) {
    return Container(
      height: 55.0,
      width: 55.0,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(imageUrl),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SingleNewsPage(
                      news: news,
                    );
                  }));
                },
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 2),
                  leading: configureMediaPreview(news.iconUrl),
                  title: Text(
                    news.newsTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Laila',
                        fontSize: 19),
                  ),
                  trailing: configureMediaPreview(news.imageUrl),
                  subtitle: Text(
                    news.source,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Divider(),
            ],
          )
        ],
      ),
    );
  }
}
