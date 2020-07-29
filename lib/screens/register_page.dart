import 'package:ecoeden/screens/home_page.dart';
import 'package:flutter/material.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    EdgeInsets contentPadding = EdgeInsets.fromLTRB(0, 0, 0, 0);
    Widget showBackButton() {
      return Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            color: Color.fromRGBO(90, 203, 146, 1),
            icon: Icon(
                Icons.arrow_back,
                size: 25
            ),
            onPressed: () => {
            },
          ),
        ),
      );
    }

    Widget showLogo() {
      return Container(
        child: Align(
          child: Image.asset('assets/EcoEden-Logo.png'),
        ),
      );
    }

    Widget showLogoBack() {
      return Container(
        height: height*0.25,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: showBackButton(),
            ),
            Positioned.fill(
              child: showLogo(),
            )
          ],
        ),
      );
    }

    Widget showNameInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 15, 10, 0),
              child: TextFormField(
                maxLines: 1,
                autofocus: false,
                style: TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 16
                ),
                decoration: InputDecoration(
                  contentPadding: contentPadding,
                  labelText: 'First Name',
                  suffixIcon: Container(height: 0, width: 0,),
                  labelStyle: TextStyle(
                      fontWeight:FontWeight.w600,
                      fontSize: 16
                  ),
                ),
                validator: (value) => value.isEmpty ? 'First Name cant\'t be empty.' : null,
                //onSaved: (value) => firstName = value.trim(),
              ),
            ),
          ),

          Flexible(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 15, 25, 0),
              child: TextFormField(
                maxLines: 1,
                autofocus: false,
                style: TextStyle(
                    fontWeight:FontWeight.w400,
                    fontSize: 16
                ),
                decoration: InputDecoration(
                  contentPadding: contentPadding,
                  suffixIcon: Container(height: 0, width: 0,),
                  labelText: 'Last Name',
                  labelStyle: TextStyle(
                      fontWeight:FontWeight.w600,
                      fontSize: 16
                  ),
                ),
                validator: (value) => value.isEmpty ? 'First Name cant\'t be empty.' : null,
                //onSaved: (value) => firstName = value.trim(),
              ),
            ),
          ),
        ],
      );
    }

    Widget showUserNameInput() {
      return Container(
        padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
        child: TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          autofocus: false,
          decoration: InputDecoration(
              contentPadding: contentPadding,
//          hintText: 'Username',
              labelText: 'Username',
              labelStyle: TextStyle(
                  fontWeight:FontWeight.w600,
                  fontSize: 16
              ),
              suffixIcon: Container(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),child: ImageIcon(AssetImage('assets/profile-pic-icon.png')))
          ),
          validator: (value) =>
          value.isEmpty
              ? 'Email cant\'t be empty.'
              : null,
          //onSaved: (value) => _email = value.trim(),
        ),
      );
    }

    Widget showEmailInput() {
      return Padding(
        padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
        child: TextFormField(
          maxLines: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
              contentPadding: contentPadding,
            labelText: 'Email Addresss',
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            suffixIcon: Container(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),child: ImageIcon(AssetImage('assets/email-icon.png')))
          ),
          validator: (value) => value.isEmpty ? 'Email cant\'t be empty.' : null,
          //onSaved: (value) => email = value.trim(),
        ),
      );
    }

    Widget showPhoneInput() {
      return Padding(
        padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
        child: TextFormField(
          maxLines: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
              labelText: 'Phone Number',
              contentPadding: contentPadding,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              suffixIcon: Container(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),child: ImageIcon(AssetImage('assets/phone-icon.png')))
          ),
          validator: (value) => value.isEmpty ? 'Email cant\'t be empty.' : null,
          //onSaved: (value) => email = value.trim(),
        ),
      );
    }

    Widget showPasswordInput() {
        return Padding(
          padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
          child: TextFormField(
            maxLines: 1,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
                contentPadding: contentPadding,
                labelText: 'Password',
                labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                suffixIcon: Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 5),child: ImageIcon(AssetImage('assets/lock-icon.png')))
            ),
            validator: (value) => value.isEmpty ? 'Email cant\'t be empty.' : null,
            //onSaved: (value) => email = value.trim(),
          ),
        );
    }

    Widget showConfirmPasswordInput() {
      return Padding(
        padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
        child: TextFormField(
          maxLines: 1,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
              contentPadding: contentPadding,
              labelText: 'Password',
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              suffixIcon: Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 5),child: ImageIcon(AssetImage('assets/lock-icon.png')))
          ),
          validator: (value) => value.isEmpty ? 'Email cant\'t be empty.' : null,
          //onSaved: (value) => email = value.trim(),
        ),
      );
    }

    Widget showPrimaryButton() {
      return Container(
        padding: EdgeInsets.fromLTRB(25.0, 36.0, 25.0, 0),
        width: width,
        height: 90.0,
        child: RaisedButton(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Color.fromRGBO(98, 203, 146, 1),
            child: Text(
              'REGISTER',
              style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w800),
            ),
            onPressed: () async {
            }),
      );
    }


    Widget showScreen() {
      return Container(
        height: height,
        child: Form(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogoBack(),
              showNameInput(),
              showUserNameInput(),
              showEmailInput(),
              showPhoneInput(),
              showPasswordInput(),
              showConfirmPasswordInput(),
              showPrimaryButton(),
            ],
          ),
        ),
      );
    }

    return Scaffold(body: showScreen(),);
  }
}

