import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/UserInfoModel.dart';
import 'package:ladhiifshopj/DataModel/UserModel.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/SignInWithGoogle/SignInWithGoogle.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserModel>(context);

    return userID != null
        ? SafeArea(
            child: StreamBuilder<UserData>(
              stream: FireStoreService(uid: userID.uid).userInfo,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  UserData userData = snapshot.data;
                  nameBeforeUpdate = userData.name;
                  locationBeforeUpdate = userData.location;
                  phoneBeforeUpdate = userData.phone;
                  return Scaffold(
                      backgroundColor: Color(0Xff24202b),
                      body: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 18),
                              child: Text(
                                "Update profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 25,
                                    letterSpacing: 1.7),
                              ),
                            ),
                            editNameWidget(userData),
                            editLocationWidget(userData),
                            editPhoneNumberWidget(userData),
                            //  updateButton(),
                          ],
                        ),
                      ));
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          )
        : CircularProgressIndicator();
  }


  //----------------------------------- shitty Code ----------------------------
  bool _isEditingText = false;
  String nameBeforeUpdate;

  Widget editNameWidget(UserData userData) {
    if (_isEditingText)
      return Container(
        width: 350,
        height: 60,
        margin: const EdgeInsets.only(left: 20,right: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xff18171b)),
        child: Center(
          child: TextField(
            onSubmitted: (newValue) {
              if (newValue == '' || newValue == null) {
                _isEditingText = true;
              } else {
                setState(() {
                  fireStoreService.updateUserInformation(
                      name: newValue,
                      phoneNumber: userData.phone,
                      location: userData.location);
                  _isEditingText = false;
                });
              }
            },
            autofocus: true,
          ),
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Container(
            width: 350,
            height: 60,
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff18171b)),
            child: RichText(
              text: TextSpan(
                  text: 'Name: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                        text: nameBeforeUpdate,
                        style: TextStyle(color: Colors.grey))
                  ]),
            )));
  }

  bool _isEditingLocation = false;
  String locationBeforeUpdate;

  Widget editLocationWidget(UserData userData) {
    if (_isEditingLocation)
      return Center(
        child: Container(
          width: 350,
          height: 60,
          margin: const EdgeInsets.only(left: 20,right: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff18171b)),
          child: TextField(
            style: TextStyle(color: Colors.white70),
            onSubmitted: (newValue) {
              if (newValue == '' || newValue == null) {
                _isEditingLocation = true;
              } else {
                setState(() {
                  fireStoreService.updateUserInformation(
                      name: userData.name,
                      phoneNumber: userData.phone,
                      location: newValue);
                  _isEditingLocation = false;
                });
              }
            },
            autofocus: true,
          ),
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingLocation = true;
          });
        },
        child: Container(
            width: 350,
            height: 160,
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff18171b)),
            child: RichText(
              text: TextSpan(
                  text: 'Location: ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                        text: locationBeforeUpdate,
                        style: TextStyle(color: Colors.grey))
                  ]),
            )));
  }

  bool _isEditingPhone = false;
  String phoneBeforeUpdate;

  Widget editPhoneNumberWidget(UserData userData) {
    if (_isEditingPhone)
      return Container(
        width: 350,
        height: 60,
        margin: const EdgeInsets.only(left: 20,right: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xff18171b)),
        child: Center(
          child: TextField(
            keyboardType: TextInputType.phone,
            onSubmitted: (newValue) {
              if (newValue == '' || newValue == null) {
                _isEditingPhone = true;
              } else {
                setState(() {
                  fireStoreService.updateUserInformation(
                      name: userData.name,
                      phoneNumber: newValue,
                      location: userData.location);
                  _isEditingPhone = false;
                });
              }
            },
            autofocus: true,
          ),
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingPhone = true;
          });
        },
        child: Container(
          width: 350,
          height: 60,
          margin: const EdgeInsets.only(left: 20,right: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xff18171b)),
          child: RichText(
            text: TextSpan(
                text: 'Phone: ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                      text: phoneBeforeUpdate,
                      style: TextStyle(color: Colors.grey))
                ]),
          ),
        ));
  }

  Widget updateButton() {
    return Container(
      height: 45,
      width: 100,
      margin: const EdgeInsets.only(top: 70),
      child: RaisedButton(
        onPressed: null,
        child: Text(
          "Update",
          style: TextStyle(color: Colors.black),
        ),
        disabledColor: const Color(0xFF1BC0C5),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
      ),
    );
  }
}
