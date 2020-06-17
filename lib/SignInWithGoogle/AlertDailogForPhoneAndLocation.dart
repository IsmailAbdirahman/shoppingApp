import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/SignInWithGoogle/SignInWithGoogle.dart';

class AlertDailogForPhoneAndLocation extends StatefulWidget {
  FireStoreService fireStoreService = FireStoreService();

  @override
  _AlertDailogForPhoneAndLocationState createState() =>
      _AlertDailogForPhoneAndLocationState();
}

class _AlertDailogForPhoneAndLocationState
    extends State<AlertDailogForPhoneAndLocation> {
  @override
  Widget build(BuildContext context) {
    TextEditingController locationEditingController = TextEditingController();
    TextEditingController phoneEditingController = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: locationEditingController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Location'),
              ),
              TextField(
                controller: phoneEditingController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'PhoneNumber'),
              ),
              SizedBox(
                width: 320.0,
                child: RaisedButton(
                  onPressed: () {
                    fireStoreService.updateLocationAndPhoneNo(
                        locationEditingController.text,
                        phoneEditingController.text);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color(0xFF1BC0C5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
