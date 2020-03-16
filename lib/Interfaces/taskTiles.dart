import 'package:flutter/material.dart';
import 'package:todo_app/Styling/global_styling.dart';

class Todo extends StatefulWidget {
  final String title;
  final String note;
  final int id;

  final String keyValue;

  Todo({this.title, this.keyValue, this.id, this.note});
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      key: Key(widget.keyValue),
      padding: EdgeInsets.only(top: 7),
      height: 108,
      margin: EdgeInsets.only(left: 1, right: 5, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: redColor,
          // gradient: new LinearGradient(colors: [Colors.green, Colors.cyan]),
          boxShadow: [
            BoxShadow(
              // color: Colors.black.withOpacity(1),
              blurRadius: 0,
              // offset: Offset(5, 5)
            )
          ]),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    //margin: EdgeInsets.only(left: 5),
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      widget.title,
                      style: taskname,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(10,5,0,0 ),
                    child: Text(
                      widget.note,
                      style: myNoteStyle,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(40,10,0,5 ),
                  child: Text(
                    'Deadline:',
                    style: deadline,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Radio(
                activeColor: greyColor,
                groupValue: null,
                onChanged: (Null value) {},
                value: null,
              ),
              GestureDetector(
                child: Icon(Icons.alarm_off, color: greyColor,),
                onTap: () {
                  print('i am goign to pass the id here');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
