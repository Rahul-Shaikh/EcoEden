import 'package:flutter/material.dart';


// Profile Page 
class ProfilePage extends StatelessWidget {


  TextStyle labelStyle = TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500);
  TextStyle normalStyle = TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);
  
  TextStyle selectStyle(String status) {
    if (status.compareTo('verified') == 0) {
      return TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w300);
    }
    else {
      return TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w300);
    }
  }
  @override
  Widget build(BuildContext context) {

    Widget showDP() {
      return Center(
        child: Container( 
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(           
            image: DecorationImage( 
              fit: BoxFit.cover,
              image: AssetImage('assets/profile.jpg')
            ),
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    Widget showEdit() {
      return Center(
        child: FlatButton(
          child: Text(
            'Edit Profile',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
          onPressed: ()=>{},
        ),
      );
    }

    Widget showFName(String name) {
      return Container( 
        padding: EdgeInsets.all(16.0),
        child: Container( 
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('First Name', style: labelStyle,),
              Container(height: 10),
              Text(name,style: normalStyle,)
            ],
          ),
        ),
      );
    }

    Widget showPhoneNumber(String number, String status) {
      return Container( 
        padding: EdgeInsets.all(16.0),
        child: Container( 
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Phone Number', style: labelStyle,),
                  Text(status, style: selectStyle(status))
                ],
              ),
              Container(height: 10),
              Text(number,style: normalStyle,)
            ],
          ),
        ),
      );
    }

    Widget showLName(String name) {
      return Container( 
        padding: EdgeInsets.all(16.0),
        child: Container( 
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Surname', style: labelStyle,),
              Container(height: 10),
              Text(name,style: normalStyle,)
            ],
          ),
        ),
      );
    }

    Widget showEmail(String email, String status) {
      return Container( 
        padding: EdgeInsets.all(16.0),
        child: Container( 
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Email', style: labelStyle,),
                  Text(status, style: selectStyle(status))
                ],
              ),
              Container(height: 10),
              Text(email,style: normalStyle,)
            ],
          ),
        ),
      );
    }

    Widget showProfile() {
      return Container(
        padding: EdgeInsets.all(4.0),
        child: Container(
          child: ListView(

            children: <Widget>[
              showDP(),
              showEdit(),
              Divider(color: Colors.grey, ),
              showFName('Shuvayan'),
              showLName('Ghosh Dastidar'),
              showPhoneNumber('+91 89021 78247', 'verified'),
              showEmail('shuvayan.ghosh@gmail.com', 'not verified'),
            ],
          ),
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),

      body: Stack(
        children: <Widget>[
          showProfile(),
        ],
      ),
    );
  }
}