import 'package:flutter/material.dart';
import 'package:ladhiifshopj/OrderedList/OrderedList.dart';
import 'package:ladhiifshopj/ProductList/ProductList.dart';
import 'package:ladhiifshopj/Profile/Profile.dart';
import 'DataModel/UserInfoModel.dart';
import 'SignInWithGoogle/SignInWithGoogle.dart';

class DisplayData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<DisplayData> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ProductList(),
    OrderedList(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0Xff24202b),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: getBottomNavigationBar()));
  }

  Widget getBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color(0Xff000000),
      elevation: 0,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: SizedBox.shrink(),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
