import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/OrderedList/OrderedList.dart';
import 'package:ladhiifshopj/OrderedList/OrderedTile.dart';
import 'package:ladhiifshopj/ProductList/ProductList.dart';
import 'package:provider/provider.dart';
import 'DataModel/ProductModel.dart';
import 'DataModel/UserInfoModel.dart';

class DisplayData extends StatefulWidget {
  DisplayData({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeState();
  }
}

class homeState extends State<DisplayData> {
  UserInfoModel userInfoModel = UserInfoModel();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    ProductList(),
    OrderedList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ProductModel>>.value(
      value: FireStoreService().productStream,
      child: Scaffold(
          backgroundColor: Color(0Xff24202b),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: getBottomNavigationBar())
      ),
    );
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


//  // getTheMessage returns "Hello, I am From Future" after 10 seconds
//
//  printMessage() async {
//    String messageFromFuture = await getMessage();
//    print(messageFromFuture);
//  }
//
//  Future<String> getMessage() async {
//    await Future.delayed(Duration(seconds: 10));
//    return "Hello, I am From Future";
//  }
}
