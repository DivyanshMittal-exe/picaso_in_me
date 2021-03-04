import 'dart:io';

import 'package:flutter/material.dart';
class Drawing{
  String title="";
  Drawing(String title){
    this.title=title;
  }

}

int count = 2;

List<Widget> getWidgetList(List<Drawing> listItems){
  List<ListTile> widgets = [];
  for(int i=0;i<listItems.length;i++){
    widgets.add(ListTile(title:Text(listItems[i].title)));
  }
    return widgets;

}

String val="";







class PicasoScreen extends StatefulWidget {
  @override
  _PicasoScreenState createState() => _PicasoScreenState();
}

class _PicasoScreenState extends State<PicasoScreen> {

  List<Drawing> listItems =[Drawing("Sample 1"),Drawing("Sample 2"),Drawing("Sample 3")];

  void addDrawing(String title){
    setState(() {
      listItems.add(Drawing(title));
    });

  }



  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                addDrawing(_textFieldController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Picaso In Me"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listItems[index].title),
            );
          },

          separatorBuilder: (context, index){

            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
         onPressed: () { _displayTextInputDialog(context); },
      ),
    );

  }


  void addItem(){

    setState(() {
      listItems.add(listItems[count]);
    });

  }

}

