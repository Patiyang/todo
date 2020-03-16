import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/Interfaces/Login/Login.dart';
import 'package:todo_app/Interfaces/AllTaskView.dart';
import 'package:todo_app/Styling/global_styling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/bloc/blocs/blocs.dart';
import 'Styling/global_styling.dart';
import 'bloc/resources/repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'todo app',
        theme: ThemeData(
            primarySwatch: Colors.grey, dialogBackgroundColor: greyColor),
        home: MyHomePage());
  }
}

enum SignInState { Busy, Data, NoData }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiKey;
  TaskBloc taskBloc;
  Repository _repository = Repository();

  @override
  void initState() {
    signInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: signInUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            apiKey = snapshot.data;
            return apiKey.length > 0
                ? getHomePage()
                : LoginPage(loginPressed: login, newUser: false);
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: greyColor,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          return Container(
            color: greyColor,
            child: Center(
              child: Text(
                'something somewhere is fucked up',
                style: TextStyle(color: Colors.grey[100], fontFamily: 'Sans'),
              ),
            ),
          );
        });
  }

  void login() {
    setState(() {
      build(context);
    });
  }

  Future signInUser() async {
    apiKey = await getApiKey();
    if (apiKey != null) {
      if (apiKey.length > 0) {
        userBloc.signInUser('', '', apiKey);
        print(apiKey);
      } else {
        print('no api key present');
      }
    } else {
      apiKey = '';
    }
    return apiKey;
  }

  Widget _getInfo(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: infoUi,
      ),
    );
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('API_Token');
  }

  Widget getHomePage() {
    // Fluttertoast.showToast(
    //     msg: "login successful",
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     // timeInSecForIos: 1,
    //     // backgroundColor: Colors.white,
    //     textColor: Colors.black,
    //     fontSize: 10.0);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.grey[850],
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: Stack(
              children: [
                TabBarView(
                  children: <Widget>[
                    // Container(
                    //   color: Colors.black87,
                    //   child: Home(),
                    // ),
                    HomeTab(apiKey: apiKey),
                    Container(color: greyColor),
                    Container(
                      color: greyColor,
                      child: Center(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.lightGreen[100],
                          child: Text('Log Out'),
                          onPressed: () {
                            print(apiKey);
                            logOut();
                          },
                        ),
                      ),
                    )
                    //Container(color: Colors.blue),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  height: 147,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '10th Jan 2020',
                        style: lobbyText,
                      ),
                      Container(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 215),
                  height: 290,
                  child: FloatingActionButton(
                      child: Icon(
                        Icons.add,
                        size: 50,
                      ),
                      backgroundColor: redColor,
                      onPressed: _showDialog),
                )
              ],
            ),
            appBar: new TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.calendar_today),
                ),
                Tab(
                  icon: Icon(Icons.add),
                ),
                Tab(
                  icon: Icon(Icons.perm_identity),
                )
              ],
              labelColor: redColor,
              unselectedLabelColor: greyColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(3),
              indicatorColor: Colors.transparent,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    TextEditingController taskNameCont = new TextEditingController();
    TextEditingController noteCont = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Container(
            height: 200,
            width: 340,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                    child: Text(
                  'Add New Task',
                  style: taskHeading,
                )),
                Container(
                  child: new Theme(
                    data: new ThemeData(hintColor: Colors.white70),
                    child: TextField(
                      controller: taskNameCont,
                      style: TextStyle(color: Colors.white, fontFamily: 'Sans'),
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.sentences,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Task Name',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Theme(
                    data: new ThemeData(hintColor: Colors.white70),
                    child: TextField(
                      controller: noteCont,
                      style: TextStyle(color: Colors.white, fontFamily: 'Sans'),
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Note',
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Text('Submit', style: taskHeading),
                          color: redColor,
                          onPressed: () {
                            if (taskNameCont.text == '') {
                              Fluttertoast.showToast(
                                  msg: "the task field cannot be blank",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  // backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 13.0);
                            } else if (noteCont.text == '') {
                              Fluttertoast.showToast(
                                  toastLength: Toast.LENGTH_SHORT,
                                  msg: 'you need to enter a note',
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 7);
                            } else if (taskNameCont.text != null &&
                                noteCont.text != null) {
                              addTask(taskNameCont.text, noteCont.text);
                              Fluttertoast.showToast(
                                  msg: "task successfuly added",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  // timeInSecForIos: 1,
                                  // backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 10.0);
                              
                              Navigator.pop(context);
                            }
                          }),
                      RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Text('Cancel', style: taskHeading),
                          color: redColor,
                          onPressed: () {
                            print('the api key is ' + apiKey);
                            Navigator.pop(context);
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  addTask(String taskName, String note) async {
    await _repository.addUserTask(apiKey, taskName, note);
    setState(() {});
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', "");
    setState(() {
      build(context);
    });
  }
}
