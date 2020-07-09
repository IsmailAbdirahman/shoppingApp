
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'DataModel/UserInfoModel.dart';
import 'DisplayData.dart';
import 'SignInWithGoogle/LoginPage.dart';




class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either LoginPage or DisplayData widget
    final user = Provider.of<UserModel>(context);
    if (user == null ) {
      return LoginPage();
    } else {
      return DisplayData();
    }
  }
}
