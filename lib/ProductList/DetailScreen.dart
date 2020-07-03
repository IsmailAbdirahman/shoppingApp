import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:ladhiifshopj/DataModel/UserModel.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/OrderedList/ToastWidget.dart';
import 'package:ladhiifshopj/SignInWithGoogle/AlertDailogForPhoneAndLocation.dart';
import 'package:oktoast/oktoast.dart';

import '../ConfigScreen.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel productModel;
  final String userID;

  DetailScreen({this.productModel, this.userID});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FireStoreService dataBaseService = FireStoreService();

  // List<String> sizeperShoeList = ['40', '41', '42', '43', '44'];
  String orderedImage = '';
  String orderedPrice = '';
  String orderedShoeName = '';
  String orderedShoeSize = '';
  int totalPrice = 0;
  int _counter = 1;
  static int prce = 0;
  int _selectedIndex = 0;
  String selectedShoeSize = '';

  DateTime now = DateTime.now();

//  Widget _diffSizeOfShoes(int index) {
//    return GestureDetector(
//      onTap: () {
//        setState(() {
//          _selectedIndex = index;
//        });
//      },
//      child: Container(
//          height: 50,
//          width: 50,
//          margin: EdgeInsets.only(top: 530),
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(60.0),
//          ),
//          child: OutlineButton(
//            disabledBorderColor: Colors.grey,
//            shape:
//                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//            onPressed: null,
//            child: Text(
//              sizeperShoeList[index],
//              style: TextStyle(
//                fontWeight: FontWeight.w500,
//                fontSize: 15,
//                color: _selectedIndex == index ? Colors.white : Colors.grey,
//              ),
//            ),
//          )),
//    );
//  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      prce = int.parse(widget.productModel.productPrice) * _counter;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;

      if (_counter < 1) {
        _counter = 1;
        prce = int.parse(widget.productModel.productPrice);
      }
    });
    prce = int.parse(widget.productModel.productPrice) * _counter;
  }

  @override
  void initState() {
    super.initState();
    prce = int.parse(widget.productModel.productPrice);
    _selectedIndex = int.parse(widget.productModel.avSize[0]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return StreamBuilder<UserData>(
      stream: FireStoreService(uid: widget.userID).userInfo,
      builder: (BuildContext context, snapshot) {
        UserData userData = snapshot.data;
        if (snapshot.hasData) {
          return OKToast(
            child: Scaffold(
                backgroundColor: Color(0Xff24202b),
                body: Column(
                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    backButton(context),
                    Expanded(child: imageDetail()),
                    increaseAndDecreaseButton(),
                    priceWidget(),
                    getIndexOfShoeSizeList(widget.productModel.avSize),
                    orderButton(userData.location, userData.phone),
                  ],
                )),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  orderedItem(
      String image, String price, String nameOfShoe, String sizeOfShoe) async {
    String orderedDate = now.day.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.year.toString() +
        " " +
        now.hour.toString() +
        ":" +
        now.minute.toString();
    totalPrice = _counter * int.parse(price);

    await dataBaseService.orderedProduct(image, totalPrice.toString(),
        _counter.toString(), false, nameOfShoe, selectedShoeSize, orderedDate);
    await dataBaseService.myOrders(image, totalPrice.toString(),
        _counter.toString(), false, nameOfShoe, selectedShoeSize, orderedDate);
  }

  Widget imageDetail() {
    return Hero(
      tag: widget.productModel.productImage,
      child: Container(
//          height: SizeConfig.blockSizeVertical * 19,
//          width: SizeConfig.blockSizeHorizontal * 100,
        child: Image(
          image: NetworkImage(widget.productModel.productImage),
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              // color: Color(0Xff111112),
              color: Color(0Xff2b3144)),
          margin: const EdgeInsets.only(top: 19.0, left: 9),
//          padding: const EdgeInsets.all(1),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
    );
  }

  Widget increaseAndDecreaseButton() {
    return Container(
//        height: SizeConfig.blockSizeVertical *19,
//        width: SizeConfig.blockSizeHorizontal *19,
      height: SizeConfig.screenHeight = 142,
      width: SizeConfig.screenWidth = 65,
      margin: const EdgeInsets.only(left: 220, bottom: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0Xff2b3144)),
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(13),
              padding: const EdgeInsets.only(top: 2, left: 8),
              height: SizeConfig.blockSizeVertical * 3.5,
              width: SizeConfig.blockSizeHorizontal * 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black26),
              child: GestureDetector(
                onTap: _incrementCounter,
                child: Text(
                  '+',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800),
                ),
              )),
          Container(
              height: SizeConfig.blockSizeVertical * 3.5,
              width: SizeConfig.blockSizeHorizontal * 7,
              padding: const EdgeInsets.only(top: 5, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: Text(_counter.toString())),
          Container(
              margin: const EdgeInsets.all(13),
              padding: const EdgeInsets.only(top: 2, left: 10),
              height: SizeConfig.blockSizeVertical * 3.5,
              width: SizeConfig.blockSizeHorizontal * 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black26),
              //     Icon(
              //   Icons.minimize,
              //   color: Colors.white,
              // )
              child: GestureDetector(
                onTap: _decrementCounter,
                child: Text(
                  '-',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800),
                ),
              )),
        ],
      ),
    );
  }

  Widget priceWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: SizeConfig.blockSizeVertical * 8,
        width: SizeConfig.blockSizeHorizontal * 22,
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: OutlineButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledBorderColor: Colors.grey,
          onPressed: null,
          child: Text(
            '\$' "${prce} ",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  //get the list of shoeSize and convert it as a index
  //pass the index value to _buildSHoeSize() and get the
  // corresponded String from avSize list which we got as a constructor
  Widget getIndexOfShoeSizeList(List shoeSize) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: shoeSize
              .asMap()
              .entries
              .map((singleType) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildSHoeSize(singleType.key),
                  ))
              .toList()),
    );
  }

  // for running diff screens i used Align widget and margin
  Widget _buildSHoeSize(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          selectedShoeSize = widget.productModel.avSize[_selectedIndex];
        });
      },
      child: Align(
        //  alignment: Alignment.bottomCenter,
        child: Container(
            height: SizeConfig.blockSizeVertical * 6.5,
            width: SizeConfig.blockSizeHorizontal * 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
            ),
            child: OutlineButton(
              disabledBorderColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: null,
              child: Text(
                widget.productModel.avSize[index].toString(),
                style: TextStyle(
                  color: _selectedIndex == index ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            )),
      ),
    );
  }

  Widget orderButton(String location, String phoneNumber) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: location == "" || phoneNumber == ""
                ? Colors.red[500]
                : Color(0Xff2b3144)),
        margin: EdgeInsets.only(bottom: 30),
        child: FlatButton(
          onPressed: () async {
            if (location == "" ||
                location == null ||
                phoneNumber == "" ||
                phoneNumber == null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlertDailogForPhoneAndLocation()));
            } else if (selectedShoeSize == '') {
              showToastWidget(
                  ToastWidget(
                    noSuccussOrderedIcon: Icons.undo,
                    description: 'Please select a size',
                  ),
                  duration: Duration(seconds: 2));
            } else {
              orderedImage = widget.productModel.productImage;
              orderedPrice = widget.productModel.productPrice;
              orderedShoeName = widget.productModel.productName;
              orderedShoeSize = selectedShoeSize;
              await orderedItem(
                  orderedImage, orderedPrice, orderedShoeName, orderedShoeSize);
              showToastWidget(
                  ToastWidget(
                    succussOrderedIcon: Icons.check,
                    description: 'Thank you for shopping with us',
                  ),
                  duration: Duration(seconds: 3));
              // Navigator.pop(context);
            }
          },
          child: location == "" || phoneNumber == ""
              ? Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  "Order now",
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
