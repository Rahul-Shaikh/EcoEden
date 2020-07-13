import 'dart:async';
import 'package:ecoeden/screens/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecoeden/models/feedsArticle.dart';
import 'package:ecoeden/services/webservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedsPageState extends State<FeedsPage> {

  List<FeedsArticle> _newsArticles = List<FeedsArticle>();
  bool disliked = false;
  bool showHeartOverlay  = false;
  bool isLoading = false;
  bool trashed = false;

  ScrollController _scrollController = new ScrollController();
  static String nextPage =  'https://api.ecoeden.xyz/photos/';
  static final String NEWS_PLACEHOLDER_IMAGE_ASSET_URL = 'assets/placeholder.png';
  @override
  void initState() {
    super.initState();
    nextPage =  'https://api.ecoeden.xyz/photos/';
    _populateNewsArticles();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          FeedsPageState.nextPage!=null) {
        _populateNewsArticles();
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
                          disliked: disliked,
                          showHeartOverlay:showHeartOverlay,
                          trashed: trashed,
                          description: _newsArticles[index].description,
                          imageUrl: _newsArticles[index].image,
                          upvotes: _newsArticles[index].upvotes,
                          downvotes: _newsArticles[index].downvotes,
                          lat: _newsArticles[index].lat,
                          lng: _newsArticles[index].lng
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

class Post extends StatefulWidget {
  bool disliked ;
  bool showHeartOverlay ;
  bool trashed;
  final String description;
  final String imageUrl;
  final String lat;
  final String lng;
   int upvotes;
   int downvotes;
  Post({@required this.disliked,this.showHeartOverlay,this.lat,this.lng,this.upvotes,this.downvotes,this.trashed,this.description,this.imageUrl});

  @override
  _PostState createState() => _PostState();
}
class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    //print(widget.upvotes.runtimeType);
    return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            PostHeader(),
            ListTile(
              //contentPadding: EdgeInsets.all(20.0),
              leading: Text(
                widget.description,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                setState(() {
                  widget.upvotes = widget.trashed ? widget.upvotes  :widget.upvotes + 1 ;
                  widget.trashed = true;
                  widget.disliked = widget.disliked ? !widget.disliked : false;
                  widget.showHeartOverlay = true;
                  widget.downvotes = widget.downvotes>0 ? widget.downvotes - 1 : 0;
                  if (widget.showHeartOverlay) {
                    Timer(const Duration(
                        milliseconds: 180), () {
                      setState(() {
                        widget.showHeartOverlay = false;
                      });
                    }
                    );
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  //Image.asset('assets/profile.jpg'),
                   widget.imageUrl== null
                      ? Image.asset('assets/profile.jpg')
                      : Image.network(
                      widget.imageUrl),
                  widget.showHeartOverlay ?
                  Icon(
                    FontAwesomeIcons.solidTrashAlt, color: Colors.white54,
                    size: 80.0,)
                      : Container(),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.0 , vertical: 2.0),
                  leading: Wrap(
                    spacing: 6.0,
                    children: <Widget>[
                      Text(" ${widget.upvotes} upvotes",style: TextStyle(fontWeight: FontWeight.w400),),
                      Text(" ${widget.downvotes} downvotes",style: TextStyle(fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.0,
                  child: Divider(
                    color: Color(0xff4E4F50),
                  ),
                ),
                ListTile(
                  leading: Wrap(
                    //mainAxisSize: MainAxisSize.min,
                    spacing: 1.0,
                    children: <Widget>[
                      IconButton(
                          iconSize: 25.0,
                          icon: Icon(widget.trashed ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp,
                              color: widget.trashed ? Colors.green : Colors.grey),
                          onPressed: () {
                            setState(() {
                              widget.upvotes = widget.trashed ? widget.upvotes - 1 :widget.upvotes + 1 ;
                              widget.downvotes = widget.downvotes>0 ? widget.downvotes - 1 : 0;
                              widget.trashed = !widget.trashed;
                              widget.disliked = widget.disliked ? !widget.disliked : false;
                            });
                          }),
                      IconButton(
                          iconSize: 25.0,
                          icon: Icon(widget.disliked ? FontAwesomeIcons.solidThumbsDown : FontAwesomeIcons.thumbsDown,
                              color: widget.disliked ? Colors.red : Colors.grey),
                          onPressed: () {
                            setState(() {
                              widget.downvotes = widget.disliked ? widget.downvotes - 1 :widget.downvotes + 1 ;
                              widget.upvotes = widget.upvotes>0 ? widget.upvotes - 1 : 0;
                              widget.disliked = !widget.disliked;
                              widget.trashed = widget.trashed ? !widget.trashed : false;
                            });
                          }),
                    ],
                  ),
                  trailing: IconButton(
                      iconSize: 27.0,
                      icon: Icon(Icons.location_on,color:Colors.red) ,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapPage(lat: widget.lat,lng: widget.lng,)),
                        );
                      },
                      ),
                ),
              ],
            )
          ],
        )
    );
  }
}

class PostHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          CircleImage(),
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Text('Harami Ghosh Dost',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/profile.jpg'),
          )
      ),
    );
  }
}


class FeedsPage extends StatefulWidget {
//  final String apikey;
//  FeedsPage(this.apikey);
  @override
  createState() => FeedsPageState();
}