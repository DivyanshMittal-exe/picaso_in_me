import 'package:flutter/material.dart';
class Drawing{
  String title="";
  Drawing(String title){
    this.title=title;

  }

}
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

  List<Drawing> listItems =[Drawing("Sample 1")];

  void addDrawing(String title){
    setState(() {
      listItems.add(Drawing(title));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Picaso In Me"),
      ),
      body: ListView(
        children:<Widget>  [
          TextField(
            onChanged: (String temp) {
              val = temp;
            }

          )
          //getWidgetList(listItems),
        ] + getWidgetList(listItems)
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new drawing",
        child: Icon(Icons.add),
        onPressed:(){
          print("Pressed");
          addDrawing(val);
        }
      ),
    );
  }
}
