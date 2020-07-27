import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

// Image Upload Page
class ImageUploadPage extends StatelessWidget {

  Widget showUploadButton(BuildContext context) {
    return Column( 
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
          child: Align( 
            alignment: Alignment.centerLeft,
            child: IconButton( 
              color: Colors.white,
              icon: Icon( 
                Icons.arrow_back,
                size: 30
              ),
              onPressed: () => {},
            ),
          ),
        ),
        Padding( 
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Align( 
            alignment: Alignment.centerLeft,
            child: Text('Photos' , style: TextStyle( color: Colors.black , fontSize : 54.0,
                    fontWeight: FontWeight.bold),),
          ),
        ),
        Padding( 
          padding: EdgeInsets.fromLTRB(0, 0.0, 30.0, 4.0),
          child: Align( 
            alignment: Alignment.centerRight,
            child: Container(
              width: 50,
              height: 50,
              child: Image.asset(
                'assets/EcoEden-Logo-withoutText.png'
              ),
            ),
          ),
        ),
        Padding( 
          padding: EdgeInsets.all(0.0),
          child: Align( 
            alignment: Alignment.center,
            child: Center( 
              child: Container( 
                height: 400,
                width: 350,
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey[100]
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Container( 
                    color: Colors.transparent,
                    child: CustomPaint( 
                      painter: RectPainter(),
                      child: Stack( 
                        children: <Widget>[
                          Align(
                            heightFactor: 2.3,
                            child: Container(
                              width: 140,
                              height: 140,
                              child: Image.asset('assets/add-image-symbol.jpg'),
                            ),
                          ),
                          Align( 
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration( 
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                                ),
                                child: FlatButton( 
                                  onPressed: () => {},
                                  child: Text('+ IMAGE', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
  
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
          children: <Widget>[
            Positioned(
              child : Image.asset(
                'assets/wave.png' ,
                  fit: BoxFit.fitWidth,
              )
            ),
            showUploadButton(context),
        ]
      ),

    );
  }
}

class RectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color  = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

    Path path = Path()
    ..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(0)));

    // canvas.drawPath(path, paint);
    canvas.drawPath(dashPath(
        path, 
        dashArray: CircularIntervalList<double>(<double>[15,10.5]),
      ), 
      paint);
  }

  @override 
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override 
  bool shouldRebuildSemantics(CustomPainter oldDelegate) {
    return false;
  }
}
