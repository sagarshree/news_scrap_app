import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_khabar/models/news.dart';
import 'package:online_khabar/pages/show_image.dart';

class SingleNewsPage extends StatelessWidget {
  final News news;

  SingleNewsPage({this.news});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffa549eb),
        centerTitle: true,
        title: Text(
          news.source,
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Laila',
          ),
        ),
      ),
      body: Container(
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                title: Center(
                  child: Text(
                    news.newsTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Laila'),
                  ),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ShowImage(
                      url: news.imageUrl,
                    );
                  }));
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 7, 10, 10),
                        height: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.3
                            : MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: news != null
                                ? CachedNetworkImageProvider(news.imageUrl)
                                : CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 7, 10, 20),
                        child: Text(
                          news.newsContent,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Laila',
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
