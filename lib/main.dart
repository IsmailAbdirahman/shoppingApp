import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DataModel/UserInfoModel.dart';
import 'SignInWithGoogle/SignInWithGoogle.dart';
import 'Wrapper.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              backgroundColor: Colors.white
          ),
          title: 'Flutter Demo',
//          theme: ThemeData(
//            primarySwatch: Colors.green,
//          ),
          home: Wrapper()),
    );
  }
}

