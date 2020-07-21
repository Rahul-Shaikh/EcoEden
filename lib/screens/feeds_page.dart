import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecoeden/models/post.dart';
import 'package:ecoeden/models/feedsArticle.dart';
import 'package:ecoeden/services/webservice.dart';

class FeedsPageState extends State<FeedsPage> {

  List<FeedsArticle> _newsArticles = List<FeedsArticle>();
  bool disliked = false;
  bool showHeartOverlay  = false;
  bool isLoading = false;
  bool trashed = false;

  ScrollController _scrollController = new ScrollController();
  static String nextPage =  'https://api.ecoeden.xyz/feed/';
  // ignore: non_constant_identifier_names
  static final String NEWS_PLACEHOLDER_IMAGE_ASSET_URL = 'assets/placeholder.png';
  @override
  void initState() {
    super.initState();
    nextPage =  'https://api.ecoeden.xyz/feed/';
    _populateNewsArticles();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          FeedsPageState.nextPage!=null) {
        _populateNewsArticles();
        var val = _newsArticles.map((x) => x.id).toList();
        print("It's Show Time !!!");
        print(val);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _populateNewsArticles() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    Webservice().load(FeedsArticle.all).then((newsArticles) => {
      setState(() => {
        isLoading = false,
        _newsArticles.addAll(newsArticles)
      })
    });

  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //print(_newsArticles[0].description);
    return Scaffold(
        appBar: AppBar(
          title: Text('Feeds'),
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _newsArticles.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _newsArticles.length) {
                      return _buildProgressIndicator();
                    } else {
                      return Post(
                        showHeartOverlay:showHeartOverlay,
                        description: _newsArticles[index].description,
                        imageUrl: _newsArticles[index].image,
                        upvotes: _newsArticles[index].upvotes,
                        downvotes: _newsArticles[index].downvotes,
                        lat: _newsArticles[index].lat,
                        lng: _newsArticles[index].lng,
                        id: _newsArticles[index].id,
                        user: _newsArticles[index].user,
                        activity: _newsArticles[index].activity,
                      );
                    }
                  },
                  controller: _scrollController,
                ),
              )
            ],
          ),
        )
    );
  }
}

class FeedsPage extends StatefulWidget {
//  final String apikey;
//  FeedsPage(this.apikey);
  @override
  createState() => FeedsPageState();
}