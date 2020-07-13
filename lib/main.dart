import 'package:ecoeden/screens/home_page.dart';
import 'package:ecoeden/screens/login_page.dart';
import 'package:ecoeden/screens/signup_page.dart';
import 'package:ecoeden/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ecoeden/app_routes.dart';
import 'package:ecoeden/localization.dart';
import 'package:ecoeden/redux/app_state.dart';
import 'package:ecoeden/redux/navigation_middleware.dart';
import 'package:ecoeden/redux/reducers/app_reducer.dart';
import 'package:ecoeden/route_aware_widget.dart';
import 'package:flutter/services.dart' ;

void main() => runApp(MyApp());



final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
    middleware: createMiddleware(),
  );


  // define  all the routes here
  MaterialPageRoute _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MainRoute(HomePage(), settings: settings);
      case AppRoutes.login:
        return MainRoute(LoginPage(), settings: settings);
     case AppRoutes.signup:
       return MainRoute(RegisterPage(), settings: settings);
      default:
        return MainRoute(LoginPage(), settings: settings);
    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        navigatorObservers: [routeObserver],
        title: AppLocalizations.appTitle,
        // theme: theme,
        onGenerateRoute: (RouteSettings settings) => _getRoute(settings),
          home: SplashScreen(),
      ),
    );
  }

}


class MainRoute<T> extends MaterialPageRoute<T> {
  MainRoute(Widget widget, {RouteSettings settings})
      : super(
      builder: (_) => RouteAwareWidget(child: widget),
      settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    // return FadeTransition(opacity: animation, child: child);
    return child;
  }
}


// from bottom to top animations use this route for
//in-page widget transitions

class FabRoute<T> extends MaterialPageRoute<T> {
  FabRoute(Widget widget, {RouteSettings settings})
      : super(
      builder: (_) => RouteAwareWidget(child: widget),
      settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute) return child;
    return SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: child);
  }

}