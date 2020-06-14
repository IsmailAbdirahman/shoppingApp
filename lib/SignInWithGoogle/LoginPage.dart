import 'package:flutter/material.dart';
import '../DisplayData.dart';
import 'SignInWithGoogle.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                margin: EdgeInsets.only(top: 2),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Color.fromARGB(255, 238, 238, 238),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 10),
                      color: Color.fromARGB(80, 0, 0, 0),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                        offset: Offset(-10, -10),
                        color: Color.fromARGB(150, 255, 255, 255),
                        blurRadius: 10)
                  ],
                ),
                child: FlatButton(
                  splashColor: Colors.blueAccent,
                  onPressed: ()  {
                    signInWithGoogle().whenComplete(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DisplayData();
                          },
                        ),
                      );
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}