import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../app_routes.dart';
import '../main.dart';
import '../models/feedsArticle.dart';
import '../redux/actions.dart';
import 'login_page.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ecoeden/models/user.dart';
import 'package:ecoeden/services/webservice.dart';
import 'camera_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecoeden/models/feedsArticle.dart';
import 'package:ecoeden/screens/feeds_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

final get_User = 'https://api.ecoeden.xyz/users/';

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
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController _controller;
  Position position;
  Widget _child;
  List<Placemark> placemark;
  String _address;
  double _lat, _lng;
  Set<Marker> _markings = Set<Marker>();
  List<FeedsArticle> _newsArticles = List<FeedsArticle>();
  @override
  void initState() {
    super.initState();
    print("Inside home");
    FeedsPageState.nextPage = 'https://api.ecoeden.xyz/feed/';
    _fetcher();
  }

  void _fetcher() async {
    await _fetch();
  }

  Future<void> _fetch() async {
    await getValidUser();
    await getCurrentLocation();
    while (FeedsPageState.nextPage != null) {
      await _fetchNewsArticles();
    }
  }

  Future<void> getValidUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('user');

    var response = await http.get(get_User,
        headers: {HttpHeaders.authorizationHeader: "Token " + jwt});

    if (response.statusCode == 200) {
      print(response.body.toString());
      final result = json.decode(response.body);
      User user = User.fromJson(result["results"][0]);
      global_store.dispatch(new userAction(user));
      print("User" + user.id.toString());
      print("User" + user.firstName.toString());
    } else {
      print("Exception !!!");
      throw Exception('Failed to load data!');
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
    placemark =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);
    String ad = placemark[0].name.toString() +
        ", " +
        placemark[0].locality.toString() +
        ", Postal Code:" +
        placemark[0].postalCode.toString();
    return ad;
  }

  Future<void> getCurrentLocation() async {
    res = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
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

  String sendData() {
    if (global_store.state.user.firstName != "") {
      String str = global_store.state.user.firstName.substring(0, 1);
      print("Yo : " + str);
      return str;
    } else {
      return "Gaand Mereche";
    }
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
              accountName: Text(global_store.state.user.userName),
              accountEmail: Text(global_store.state.user.email),
              currentAccountPicture: GestureDetector(
                child: Hero(
                  tag: "profile",
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    child: Text(
                      sendData(),
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                onTap: () {
                  global_store
                      .dispatch(new NavigatePushAction(AppRoutes.profile));
                },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.lightBlue,
        elevation: 2.0,
        onPressed: () {
          global_store.dispatch(new NavigatePushAction(AppRoutes.camera));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 40.0,
          color: Color(0xEF4285f4),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.home),
                  onPressed: () {},
                ),
                IconButton(
//                color: Colors.black,
                  icon: Icon(
                    FontAwesomeIcons.newspaper,
                  ),
                  onPressed: () {
                    global_store
                        .dispatch(new NavigatePushAction(AppRoutes.feed));
                  },
                ),
              ],
            ),
          ),
        ),
        shape: CircularNotchedRectangle(),
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
      String markerAddress =
          await getAddress(double.parse(x.lat), double.parse(x.lng));
      Marker marker = Marker(
          markerId: MarkerId(x.lat + "," + x.lng),
          position: LatLng(double.parse(x.lat), double.parse(x.lng)),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Location', snippet: markerAddress),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: popUpPage(x.createdAt, x.image, x.description),
                ),
              ),
            );
          });
      setState(() {
        _markings.add(marker);
        _child = mapWidget();
      });
    }
  }

  Widget popUpPage(String date, String url, String description) {
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
            Text(
              description,
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            Center(
              child: CachedNetworkImage(
                imageUrl: url,
                height: 350.0,
                width: 500.0,
                placeholder: (context, url) => CircularProgressIndicator(
                  backgroundColor: Color(0xFFB4B4B4),
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(
              "Created on " + dateFormat,
              style: TextStyle(
                  fontStyle: FontStyle.normal, fontWeight: FontWeight.w900),
            ),
            Text(
              "- $differenceInDays days ago",
              style: TextStyle(
                  fontStyle: FontStyle.normal, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
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
          global_store.dispatch(new LogoutAction().logout());
//          global_store.dispatch(new NavigateClearAction());
        },
      ),
    ),
  );
}
