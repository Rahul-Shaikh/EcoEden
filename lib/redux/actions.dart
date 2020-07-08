import 'package:ecoeden_redux/app_routes.dart';
import 'package:ecoeden_redux/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'app_state.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
        // store.dispatch(NavigatePushAction(AppRoutes.home))
        
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



 Future<User> createUser(String url, {Map body}) async {
    
  return http.post(url, body: body).then((http.Response response) {
    print('HELOOOOOOOOOO');
    print(response);
    final int statusCode = response.statusCode;
    print(statusCode);

    if (statusCode == 201) {
      print("Success");
    }else{
      throw new Exception("Error while fetching data");
    }
    return User.fromJson(json.decode(response.body));
  });
}



