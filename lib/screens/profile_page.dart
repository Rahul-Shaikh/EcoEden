import 'package:flutter/material.dart';
import 'package:ecoeden/main.dart';
import 'package:ecoeden/screens/feeds_page.dart';
import 'package:ecoeden/models/feedsArticle.dart';
import 'package:ecoeden/services/webservice.dart';
import 'package:ecoeden/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

// Profile Page

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<FeedsArticle> _newsArticles = List<FeedsArticle>();

  @override
  void initState() {
    super.initState();
    FeedsPageState.nextPage = 'https://api.ecoeden.xyz/photos/';
    _fetch();
  }

  void _fetch() async {
    while (FeedsPageState.nextPage != null) {
      await _fetchNewsArticles();
    }
  }

  Future<void> _fetchNewsArticles() async {
    List<FeedsArticle> newsArticles = await Webservice().load(FeedsArticle.all);
    setState(() {
      _newsArticles.addAll(newsArticles);
    });
  }

  TextStyle labelStyle =
      TextStyle(color: Colors.grey, fontSize: 8, fontWeight: FontWeight.w500);
  TextStyle normalStyle =
      TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w500);

  TextStyle selectStyle(String status) {
    if (status.compareTo('verified') == 0) {
      return TextStyle(
          color: Colors.green, fontSize: 6, fontWeight: FontWeight.w300);
    } else {
      return TextStyle(
          color: Colors.red, fontSize: 6, fontWeight: FontWeight.w300);
    }
  }

//  Porny & Bati Productions
  @override
  Widget build(BuildContext context) {
    Widget showProfile() {
      print("In Profile");
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Hero(
                  tag: "profile",
                  child: CircleAvatar(
                    radius: 38.0,
                    backgroundColor: Colors.lightBlueAccent,
                    child: Text(
                      (global_store.state.user.firstName)[0].toString(),
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          global_store.state.user.firstName +
                              " " +
                              global_store.state.user.lastName,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(global_store.state.user.email),
                      Text(global_store.state.user.mobile),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ),
          Center(
            child: Text(
              "Posts",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _newsArticles.length,
              itemBuilder: (BuildContext context, int index) {
                return Post(
                  showHeartOverlay: false,
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
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Stack(
        children: <Widget>[
          showProfile(),
        ],
      ),
    );
  }
}
