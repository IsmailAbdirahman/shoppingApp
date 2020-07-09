import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final IconData succussOrderedIcon;
  final IconData noSuccussOrderedIcon;
  final String description;

  const ToastWidget(
      {this.succussOrderedIcon, this.description, this.noSuccussOrderedIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xff24202b),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              width: 890.0,
              height: 200.0,
              color: Color(0Xff2b3144),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    noSuccussOrderedIcon,
                    color: Colors.red,
                    size: 70,
                  ),
                  Icon(
                    succussOrderedIcon,
                    color: Colors.greenAccent,
                    size: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Text(
                      description,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
