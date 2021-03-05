import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picaso_in_me/DrawingBoard.dart';
import 'package:flutter/foundation.dart';


class Drawing extends StatelessWidget {

  String title="";
  Drawing(String title){
    this.title=title;
  }

  // ignore: non_constant_identifier_names
  String GetTitle(){

    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FlatButton(
        color: Colors.green,
        textColor: Colors.white,
        child: Text('Flat Button',),
        onPressed: () {

        },
      ),
    );
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

  List<Drawing> listItems =[Drawing("The Old Guitarist"),Drawing("Girl Before a Mirror"),Drawing("The Weeping Woman")];

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
          title: Text('Add New'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Name"),
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


  // ignore: non_constant_identifier_names
  var CpyItems = List<String>();





  @override






  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Picaso In Me"),






      ),
      body:
      Container(
      child: Column(
      children: <Widget>[
      Padding(
      padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            //filterSearchResults(value);
          },
          decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)))),
        ),
      ),
        Expanded(
        child: ListView.separated(
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            final item = listItems[index].title;
            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
                key: Key(item),
                // Provide a function that tells the app
                // what to do after an item has been swiped away.
                onDismissed: (direction) {
                  // Remove the item from the data source.


                  setState(() {
                    listItems.removeAt(index);
                  });



                  // Then show a snackbar.
                 // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$item dismissed")));
                },
                // Show a red background as the item is swiped away.
            background: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0),
            color: Colors.redAccent,
            child: Icon(Icons.delete, color: Colors.white),
            ),



              child:  ListTile(
                       title: Text(listItems[index].title),

                       onTap: (){
                      print("Tapped");
                      Navigator.push(
                      context,
                        MaterialPageRoute(builder: (context) =>DrawBoard()),);

            },

                  onLongPress: (){
                    print("Long Pressed");
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Add New'),
                          content: TextField(
                            controller: _textFieldController,
                            decoration: InputDecoration(hintText: "Name"),
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
                                setState(() {
                                  listItems[index].title=_textFieldController.text;
                                });

                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );



                  },
              )
            );




          },

          separatorBuilder: (context, index){

            return Divider();
          },
        ),
      ),
      ]
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

