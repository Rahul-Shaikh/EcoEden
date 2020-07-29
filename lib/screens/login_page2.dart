import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


//    Widget backButton() {
//      return Padding(
//          padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
//          child: Align(
//            alignment: Alignment.centerLeft,
//            child: IconButton(
//              color: Colors.white,
//              icon: Icon(
//                Icons.arrow_back,
//                size: 30
//              ),
//              onPressed: () => {},
//            ),
//          ),
//        );
//    }

    Widget showLogo() {
      return Container(
        height: height*0.5,
        width: width,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width/2,
            height: height*0.5,
            child: Image.asset('assets/EcoEden-Logo.png')
          ),
        ),
      );
    }

    Widget showUserNameInput() {
      return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextFormField(
          controller: _usernameController,
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          autofocus: false,
          decoration: InputDecoration(
//          hintText: 'Username',
            labelText: 'Username',
            labelStyle: TextStyle(
              fontWeight:FontWeight.w600,
              fontSize: 20
            ),
            suffixIcon: Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 5),child: ImageIcon(AssetImage('assets/profile-pic-icon.png')))
          ),
          validator: (value) =>
          value.isEmpty
              ? 'Email cant\'t be empty.'
              : null,
          //onSaved: (value) => _email = value.trim(),
        ),
      );
    }

    Widget showPasswordInput() {
      return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextFormField(
          controller: _passwordController,
          maxLines: 1,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          obscureText: true,
          decoration: InputDecoration(
//          hintText: 'Username',
            labelText: 'Password',
            labelStyle: TextStyle(
                fontWeight:FontWeight.w600,
                fontSize: 20
            ),
            suffixIcon: Container(padding: EdgeInsets.fromLTRB(0, 15, 0, 5),child: ImageIcon(AssetImage('assets/lock-icon.png')))
          ),
          validator: (value) =>
          value.isEmpty
              ? 'Password cant\'t be empty.'
              : null,
          //onSaved: (value) => _email = value.trim(),
        ),
      );
    }

    Widget showForgotButton() {
      return Container(
        height: 40,
        padding: EdgeInsets.fromLTRB(0, 8, 12, 8),
        child: Align(
          alignment: Alignment.centerRight,
          child: FlatButton(
            child: Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            onPressed: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => RegisterPage()),
//          );
//          StoreProvider.of<AppState>(context).dispatch(NavigatePushAction(AppRoutes.signup));
//            store.dispatch(NavigatePushAction(AppRoutes.signup));
            },
          ),
        ),
      );
    }

    Widget showPrimaryButton() {
      return Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
        width: width,
        height: 50.0,
        child: RaisedButton(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Color.fromRGBO(98, 203, 146, 1),
            child: Text(
              'LOGIN',
              style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w800),
            ),
            onPressed: () async {
            }),
      );
    }

    Widget showSecondaryButton() {
      return FlatButton(
        child: Text(
          'Create a new account',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
        ),
        onPressed: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => RegisterPage()),
//          );
//          StoreProvider.of<AppState>(context).dispatch(NavigatePushAction(AppRoutes.signup));
//            store.dispatch(NavigatePushAction(AppRoutes.signup));
        },
      );
    }

    Widget showForm() {
      return Container(
        height: height*0.46,
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            children: <Widget>[
              showUserNameInput(),
              showPasswordInput(),
              showForgotButton(),
              showPrimaryButton(),
              showSecondaryButton()
            ],
          ),
        ),
      );
    }




    Widget showScreen() {
      return Container(
        child: Form(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showForm()
            ],
          ),
        ),
      );
    }



    return Scaffold( 
      body: showScreen(),
    );
  }
}