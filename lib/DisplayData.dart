import 'package:flutter/material.dart';
import 'package:ladhiifshopj/OrderedList/OrderedList.dart';
import 'package:ladhiifshopj/ProductList/ProductList.dart';


class DisplayData extends StatefulWidget {
  DisplayData({Key key}) : super(key: key);

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
    Text("Profile")
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
          icon: Icon(Icons.search),
          title: SizedBox.shrink(),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
