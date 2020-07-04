import 'package:ecoeden_redux/redux/app_state.dart';
import 'package:ecoeden_redux/redux/reducers/feed_reducer.dart';

import 'package:ecoeden_redux/redux/reducers/loading_reducer.dart';
import 'package:ecoeden_redux/redux/reducers/navigation_reducers.dart';
import 'package:ecoeden_redux/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    user : userReducer( state.user , action ), 
    route: navigationReducer(state.route, action) ,
    feeds : feedReducer( state.feeds , action ) 
  );
}