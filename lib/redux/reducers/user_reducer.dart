import 'package:ecoeden_redux/model/user.dart';
import 'package:ecoeden_redux/redux/actions.dart';
import 'package:ecoeden_redux/redux/app_state.dart';
import 'package:redux/redux.dart';



final userReducer = combineReducers<User>([
    TypedReducer< User , SignupAction > (_signup),
]);

User _signup( User prev_user , SignupAction action ){
    return prev_user.copyWith(
      firstName :action.user.firstName ,
      lastName : action.user.lastName ,
      userName :action.user.userName , 
      email: action.user.email, 
      mobile: action.user.mobile ,
      password :action.user.password ,
      id :action.user.id
    );
}



