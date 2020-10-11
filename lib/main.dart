import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DataModel/UserInfoModel.dart';
import 'SignInWithGoogle/SignInWithGoogle.dart';
import 'Wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      value: user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper()),
    );
  }
}
