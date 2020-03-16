import 'package:flutter/material.dart';
import 'package:todo_app/Styling/global_styling.dart';
import 'package:todo_app/bloc/blocs/blocs.dart';

class LoginPage extends StatefulWidget {
  final newUser;
  final VoidCallback loginPressed;

  const LoginPage({Key key, this.newUser, this.loginPressed}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCont = new TextEditingController();
  TextEditingController usernameCont = new TextEditingController();
  TextEditingController firstnameCont = new TextEditingController();
  TextEditingController lastnameCont = new TextEditingController();
  TextEditingController passwordCont = new TextEditingController();
  TextEditingController unameText = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: greyColor,
        body: Center(
          child: widget.newUser ? getSignupPage() : getSignInPage(),
        ),
      ),
    );
  }

  Widget getSignInPage() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 19),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(23),
            child: Center(
              child: Text(
                'Simple app design',
                style: welcome,
              ),
            ),
          ),
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: greyColor, fontFamily: 'Sans'),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Username",
                        prefixIcon: Icon(Icons.sentiment_satisfied)
                        // icon: Icon(Icons.sentiment_satisfied)
                        ),
                    controller: unameText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black, fontFamily: 'Sans'),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock)
                        // icon: Icon(Icons.lock)
                        ),
                    controller: password,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: redColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'Sign In',
                        style: myTasksHeading,
                      ),
                      onPressed: () {
                        if (unameText.text != null || password.text != null) {
                          userBloc
                              .signInUser(unameText.text, password.text, '')
                              .then((_) {
                            widget.loginPressed();
                          });
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only( bottom: 1),
            child: Column(
              children: <Widget>[
                Text('Don\'t Have An Account Yet?', style: redTerms),
                FlatButton(
                    child: Text(
                      'Create one',
                      style: redTodoTitle,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => getSignupPage()));
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSignupPage() {
    return Material(
      color: greyColor,
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column( 
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 80.0, right: 8, left: 8, bottom: 8),
                child: TextField(
                  // obscureText: true,
                  style: TextStyle(color: Colors.black, fontFamily: 'Sans'),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(right: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Email",
                    //prefixIcon: Icon(Icons.sentiment_satisfied)
                    icon: Icon(Icons.email,),
                  ),
                  controller: emailCont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // obscureText: true,
                  style: TextStyle(color: Colors.black, fontFamily: 'Sans'),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(right: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Username",
                    //prefixIcon: Icon(Icons.sentiment_satisfied)
                    icon: Icon(Icons.person_outline),
                  ),
                  controller: usernameCont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // obscureText: true,
                  style: TextStyle(color: Colors.black, fontFamily: 'Sans'),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(right: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "First Name",
                    //prefixIcon: Icon(Icons.sentiment_satisfied)
                    icon: Icon(Icons.account_box),
                  ),
                  controller: firstnameCont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // obscureText: true,
                  style: TextStyle(color: Colors.black, fontFamily: 'Sans'),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(right: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Last Name",
                    //prefixIcon: Icon(Icons.sentiment_satisfied)
                    icon: Icon(Icons.account_box),
                  ),
                  controller: lastnameCont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // obscureText: true,
                  style: TextStyle(color: Colors.black, fontFamily: 'Sans'),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(right: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Password",
                    //prefixIcon: Icon(Icons.sentiment_satisfied)
                    icon: Icon(Icons.lock),
                  ),
                  controller: passwordCont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.only(left: 60, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: lightBlue,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text(
                        'Sign Up',
                        style: myTasksHeading,
                      ),
                      onPressed: () {
                        // User user;
                        if (passwordCont != null ||
                            usernameCont != null ||
                            firstnameCont != null ||
                            emailCont != null ||
                            lastnameCont != null) {
                          userBloc.registerUser(
                              usernameCont.text,
                              firstnameCont.text,
                              lastnameCont.text,
                              emailCont.text,
                              passwordCont.text);
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
