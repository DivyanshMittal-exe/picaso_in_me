import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawBoard extends StatefulWidget {
  @override
  _DrawBoardState createState() => _DrawBoardState();
}

class _DrawBoardState extends State<DrawBoard> {

final _offsets =<Offset>[];


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
          });

    },
          onPanUpdate: (details){

            final renderBox=context.findRenderObject() as RenderBox;
            final localPosition = renderBox.globalToLocal(details.globalPosition);

            setState(() {
              _offsets.add(details.localPosition);
            });

          },
        child: Center(
          child: CustomPaint(
             painter: PaintBoard(_offsets),
            child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,



              ),
          ),

    ),
    )
    );
  }
}

class PaintBoard extends CustomPainter{

  final offsets ;

  PaintBoard(this.offsets): super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color=Colors.deepPurple
    ..isAntiAlias=true
    ..strokeWidth=3.0;
    for(var offsets in offsets){
      canvas.drawPoints( PointMode.points, [offsets], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>true;


}



