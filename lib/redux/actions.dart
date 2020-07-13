import 'package:ecoeden/app_routes.dart';
import 'package:ecoeden/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'app_state.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const URL = 'https://api.ecoeden.xyz/auth/';

final CREATE_POST_URL = 'https://api.ecoeden.xyz/users/';

class NavigateReplaceAction {
  final String routeName;

  NavigateReplaceAction(this.routeName);

  @override
  String toString() {
    return 'MainMenuNavigateAction{routeName: $routeName}';
  }
}

class NavigatePushAction {
  final String routeName;

  NavigatePushAction(this.routeName);

  @override
  String toString() {
    return 'NavigatePushAction{routeName: $routeName}';
  }
}

class NavigatePopAction {

  @override
  String toString() {
    return 'NavigatePopAction';
  }
}

class SignupAction{
  final User user;

  SignupAction({
    @required this.user
  });


  ThunkAction<AppState> signup( ){
    return (Store<AppState> store) async {

      createUser( CREATE_POST_URL , body: user.toMap() ).then((user) => {
        store.dispatch(NavigatePushAction(AppRoutes.login))

      }).catchError((e){
        print(e);
      });
    };
  }




  @override
  String toString(){
    return "SignupAction";
  }
}


class LoginAction{
  final String username;
  final String password;

  LoginAction({
    @required this.username,
    @required this.password
  });


  ThunkAction<AppState> login( ){
    return (Store<AppState> store) async {

      await attemptLogIn(username, password).then((String jwt) => {
        store.dispatch(NavigatePushAction(AppRoutes.home))
      }).catchError((e){
        print(e);
      });
    };
  }


  @override
  String toString(){
    return "LoginAction";
  }
}


Future<User> createUser(String url, {Map body}) async {

  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode == 201) {
      print("Success");
    }else{
      throw new Exception("Error while fetching data");
    }
    return User.fromJson(json.decode(response.body));
  });
}

Future<String> attemptLogIn(String username, String password) async {
  print(username);
  print(password);
  var res = await http.post(
      URL,
      body: {
        "username": username,
        "password": password
      }
  );
  print(res.statusCode);
  print(json.decode(res.body)['token']);
  if (res.statusCode == 200) return json.decode(res.body)["token"];
  return null;
}


