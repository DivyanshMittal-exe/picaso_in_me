import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:screenshot/screenshot.dart';


int cooler=0;
int sizes=0;

class DrawBoard extends StatefulWidget {
  @override
  _DrawBoardState createState() => _DrawBoardState();
}

class _DrawBoardState extends State<DrawBoard> {

//final _offsets =<Offset>[];
List<Offset> _offsets =[];
int _counter = 0;
File _imageFile;
List<Offset> _undo =[];





//Create an instance of ScreenshotController
ScreenshotController screenshotController = ScreenshotController();

@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Drawing Board"),
        ),
        body: GestureDetector(
        onPanDown: (details){
          final renderBox=context.findRenderObject() as RenderBox;
          final localPosition = renderBox.globalToLocal(details.globalPosition);

          setState(() {
            _offsets.add(details.localPosition);
            _undo.clear();
          });

    },
          onPanUpdate: (details){

            final renderBox=context.findRenderObject() as RenderBox;
            final localPosition = renderBox.globalToLocal(details.globalPosition);

            setState(() {
              _offsets.add(details.localPosition);
              _undo.add(details.localPosition);
            });

          },

          onPanEnd: (details){

            setState(() {
              _offsets.add(null);
            });

          },

        child: Center(
          child: CustomPaint(
             painter: PaintBoard(_offsets),
            child: Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,



              ),
          ),

    ),
    ),
       /* floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.navigate_before),
              ),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.navigate_next),
              )
            ],
          ),
        )
        */



      floatingActionButton: Column(

          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [


            RaisedButton(

              child: Icon(Icons.brush),
                color: Colors.green,

                onPressed: (){cooler=0;}),

            RaisedButton(
                child: Icon(Icons.brush),
                color: Colors.red,

                onPressed: (){cooler=1;}),
            RaisedButton(
                child: Text("3.0"),
                color: Colors.cyan,

                onPressed: (){
                  sizes=0;

                }),
            RaisedButton(
                child: Text("7.0"),
                color: Colors.cyan,

                onPressed: (){sizes=1;}),
            RaisedButton(
                child: Icon(Icons.ad_units_outlined),
                color: Colors.white,

                onPressed: (){

                    _offsets.clear();


                }),
            RaisedButton(
                child: Icon(Icons.undo),
                color: Colors.cyan,

                onPressed: (){

  for(var i=0; i< _undo.length; i++){
        var index=_offsets.length-i-1;
    _offsets.removeAt(index);
    _offsets[index]=null;
  }


                }),

          ],

      ),










    );
  }
}

class PaintBoard extends CustomPainter{

  final offsets ;

  PaintBoard(this.offsets): super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    if (cooler==0 && sizes==0){
       paint
        ..color = Colors.green
        ..isAntiAlias = true
        ..strokeWidth = 3.0;
  }else if (cooler==1 && sizes==0){
       paint
        ..color = Colors.red
        ..isAntiAlias = true
        ..strokeWidth = 3.0;
    }else if (cooler==0 && sizes==1){
      paint
        ..color = Colors.green
        ..isAntiAlias = true
        ..strokeWidth = 7.0;
    }else if (cooler==1 && sizes==1){
      paint
        ..color = Colors.red
        ..isAntiAlias = true
        ..strokeWidth = 7.0;
    }
    for(var i=0; i< offsets.length; i++){
      if(offsets[i]!=null && offsets[i+1]!=null){

        canvas.drawLine(offsets[i], offsets[i+1], paint);

      }else if(offsets[i]!=null && offsets[i+1]==null){
        canvas.drawPoints( PointMode.points, [offsets[i]], paint);
      }
    }

    for(var offsets in offsets){
      canvas.drawPoints( PointMode.points, [offsets], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>true;


}



