import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/feedsArticle.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ecoeden/models/user.dart';
import 'package:ecoeden/services/webservice.dart';
import 'camera_page.dart';
import 'package:ecoeden/models/feedsArticle.dart';
import 'package:ecoeden/screens/feeds_page.dart';

class Arguments {
  final User user;
  final double lat;
  final double lon;
  const Arguments({
    @required this.user,
    @required this.lat,
    @required this.lon,
  });
}

class HomePage extends StatefulWidget {
  final User user = User(
      firstName: "Titir",
      lastName: "Chutiya",
      email: "balermeye@hotmail.com",
      userName: "Titir69",
      id: 69,
      password: "sexy69",
      mobile: "8017949819");
  final String accEmail = "balermeye@hotmail.com";
  final String accName = "Titir69";

  @override
  _HomePageState createState() => _HomePageState(user: user);
}

class _HomePageState extends State<HomePage> {
  GoogleMapController _controller;
  Position position;
  Widget _child;
  List<Placemark> placemark;
  String _address;
  double _lat, _lng;
  Set<Marker> _markings = Set<Marker>();
  final User user;
  List<FeedsArticle> _newsArticles = List<FeedsArticle>();
  _HomePageState({
    @required this.user,
  });
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    await getCurrentLocation();
    print(FeedsPageState.nextPage);
    while (FeedsPageState.nextPage != null) {
      await _fetchNewsArticles();
    }
  }

  Future<void> _fetchNewsArticles() async {
    List<FeedsArticle> newsArticles = await Webservice().load(FeedsArticle.all);
    setState(() {
      _newsArticles.addAll(newsArticles);
    });
    _createMarker(newsArticles);
  }

  Future<String> getAddress(double latitude, double longitude) async {
    placemark = await Geolocator().placemarkFromCoordinates(latitude, longitude);
    String ad = placemark[0].name.toString() + ", " + placemark[0].locality.toString()
        + ", Postal Code:" + placemark[0].postalCode.toString();
    return ad;
  }

  Future<void> getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    String ad = await getAddress(res.latitude, res.longitude);
    setState(() {
      position = res;
      _lat = position.latitude;
      _lng = position.longitude;
      _address = ad;
      _markings.add(_homeMarker());
      _child = mapWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EcoEden',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.search,
            ),
            padding: EdgeInsets.only(right: 20.0),
            splashColor: Color(0xFF4285f4),
            onPressed: () {
              print('Search is pressed');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.accName),
              accountEmail: Text(widget.accEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Item 1",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context); //Push Method will be added later
              },
            ),
            ListTile(
              title: Text(
                "Item 2",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context); //Push Method will be added later
              },
            ),
            showPrimaryButton(context),
          ],
        ),
      ),
      body: _child,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          child: Icon(Icons.add_a_photo),
          onPressed: () {
            Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => new ImageInput()),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 40.0,
          color: Color(0xEF4285f4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.home),
                onPressed: () {},
              ),
              IconButton(
//                color: Colors.black,
                icon: Icon(FontAwesomeIcons.newspaper),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Marker _homeMarker() {
    return Marker(
      markerId: MarkerId('Home'),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: 'Home', snippet: _address),
    );
  }

  void _createMarker(List<FeedsArticle> articles) async {
    for (FeedsArticle x in articles) {
      String markerAddress = await getAddress(double.parse(x.lat), double.parse(x.lng));
      Marker marker = Marker(markerId: MarkerId(x.lat + "," + x.lng),
          position: LatLng(double.parse(x.lat), double.parse(x.lng)),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Location', snippet: markerAddress),
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: popUpPage(x.createdAt, x.image,x.description),)));
          });
      setState(() {
        _markings.add(marker);
        _child = mapWidget();
      });
    }
  }

  Widget popUpPage(String date, String url,String description) {
    date = date.substring(0, date.indexOf('T'));
    final String dateFormat =
    DateFormat("dd-MM-yyyy").format(DateTime.parse(date));
    DateTime dateTimeCreatedAt = DateTime.parse(date);
    DateTime dateTimeNow = DateTime.now();
    final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(description, style : TextStyle(fontSize: 26.0,fontWeight: FontWeight.bold),),
            Center(
              child: CachedNetworkImage(imageUrl: url, height: 350.0, width: 500.0,
                placeholder: (context, url) => CircularProgressIndicator(backgroundColor: Color(0xFFB4B4B4),valueColor
                    :new AlwaysStoppedAnimation<Color>(Colors.green),),
                errorWidget: (context, url, error) => Icon(Icons.error),),
            ),
            Text(
              "Created on " + dateFormat,
              style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.w900),
            ),
            Text(
              "- $differenceInDays days ago",
              style: TextStyle(
                  fontStyle: FontStyle.normal, fontWeight: FontWeight.w300),
            ),
          ],
        ),),
    );
  }

  Widget mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _markings,
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }
}

Widget showPrimaryButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
    child: SizedBox(
      width: 30.0,
      height: 50.0,
      child: RaisedButton(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.blue,
        child: Text(
          'Log Out',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      ),
    ),
  );
}
