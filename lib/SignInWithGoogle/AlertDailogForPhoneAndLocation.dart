import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/OrderedList/ToastWidget.dart';
import 'package:ladhiifshopj/SignInWithGoogle/SignInWithGoogle.dart';
import 'package:oktoast/oktoast.dart';

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
    return Scaffold(
      backgroundColor: Color(0Xff24202b),
      body: Dialog(
        elevation: 5,
        backgroundColor: Color(0Xff2b3144),
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
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Location',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneEditingController,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'PhoneNumber',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: 320.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (locationEditingController.text == "" &&
                          phoneEditingController.text == "") {
                        showToastWidget(
                            ToastWidget(
                              succussOrderedIcon: Icons.file_upload,
                              description: 'Please fill the information',
                            ),
                            duration: Duration(seconds: 3));
                      } else {
                        fireStoreService.updateLocationAndPhoneNo(
                            locationEditingController.text,
                            phoneEditingController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: const Color(0xFF1BC0C5),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
