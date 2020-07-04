

// User model 
// list of feeds


import 'package:meta/meta.dart';
import 'package:ecoeden_redux/app_routes.dart';
import 'package:ecoeden_redux/model/feeds.dart';
import 'package:ecoeden_redux/model/user.dart';


@immutable
class AppState{
   final bool isLoading;
   final User user;
   final List<Feed> feeds;
   final List<String> route;


   //constructor
   AppState({
     this.isLoading = false ,  
     this.feeds = const [] , 
     this.route = const [AppRoutes.home],
     this.user = null 
   });

   factory AppState.loading() => AppState(isLoading: true);

   AppState copyWith({
     bool isLoading, 
     User user, 
     List<Feed> feeds, 
     List<String> route
   })
   => AppState(
     isLoading : isLoading ?? this.isLoading, 
     user : user  ?? this.user , 
     feeds : feeds ?? this.feeds, 
     route : route ?? this.route 
   );

   @override 
   int get hashCode => isLoading.hashCode ^ user.hashCode ^ feeds.hashCode ^ route.hashCode;

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          user == other.user &&
          route == other.route &&
          feeds == other.feeds;



  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, feeds: $feeds, route: $route , user : $user}';
  }

}