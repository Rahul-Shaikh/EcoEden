import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class Resource<T> {
  String url;
  T Function(Response response) parse;

  Resource({this.url,this.parse});
}

class API_KEY extends ChangeNotifier{
  String _apikey = "";

  String get key{
    return _apikey;
  }

  void set_key(newValue){
    _apikey = newValue;
    notifyListeners();
  }
}

class Webservice {

  Future<T> load<T>(Resource<T> resource) async {
    final response = await http.get(resource.url);
    if(response.statusCode == 200) {
      return resource.parse(response);
    } else {
      print("Exception !!!");
      throw Exception('Failed to load data!');
    }
  }

}