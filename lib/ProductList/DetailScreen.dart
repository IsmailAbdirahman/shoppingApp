import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:ladhiifshopj/DataModel/UserModel.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/SignInWithGoogle/AlertDailogForPhoneAndLocation.dart';
import 'package:ladhiifshopj/SignInWithGoogle/SignInWithGoogle.dart';
import 'package:ladhiifshopj/Wrapper.dart';
import 'package:provider/provider.dart';

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
  int totalPrice = 0;
  int _counter = 1;
  static int prce = 0;
  int _selectedIndex = 0;

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
          return Scaffold(

              backgroundColor: Color(0Xff24202b),
              body: Stack(
                children: <Widget>[
                  imageDetail(),
                  backButton(context),
                  increaseAndDecreaseButton(),
                  priceWidget(),
                  getIndexOfShoeSizeList(widget.productModel.avSize),
                  orderButton(userData.location, userData.phone),
                  //  orderButton(),
                ],
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  orderedItem(String image, String price) async {
    totalPrice = _counter * int.parse(price);

    await dataBaseService.orderedProduct(
        image, totalPrice.toString(), _counter.toString(), false);
    await dataBaseService.myOrders(
        image, totalPrice.toString(), _counter.toString(), false);
  }

  Widget imageDetail() {
    return Hero(
      tag: widget.productModel.productImage,
      child: Container(
        //   height: MediaQuery.of(context).size.width,
        height: SizeConfig.blockSizeVertical * 60,
        width: SizeConfig.blockSizeHorizontal * 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image(
            image: NetworkImage(widget.productModel.productImage),
          ),
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
            // color: Color(0Xff111112),
            color: Color(0Xff2b3144)),
        margin: const EdgeInsets.only(top: 44.0, left: 16),
        padding: const EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }

  Widget increaseAndDecreaseButton() {
    return Container(
      height: 161,
      width: 85,
      margin: const EdgeInsets.only(top: 350, left: 285),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0Xff2b3144)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(13),
              padding: const EdgeInsets.only(top: 4, left: 10),
              height: 30,
              width: 30,
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
              height: 30,
              width: 30,
              padding: const EdgeInsets.only(top: 8, left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              child: Text(_counter.toString())),
          Container(
              margin: const EdgeInsets.all(13),
              padding: const EdgeInsets.only(top: 4, left: 11),
              height: 30,
              width: 30,
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
    return Container(
      height: 117,
      width: 117,
      margin: const EdgeInsets.only(top: 400.0, left: 170),
      padding: const EdgeInsets.all(25),
      child: OutlineButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
    );
  }

  //get the list of shoeSize and convert it as a index
  //pass the index value to _buildSHoeSize() and get the
  // corresponded String from avSize list which we got as a constructor
  Widget getIndexOfShoeSizeList(List shoeSize) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: shoeSize
            .asMap()
            .entries
            .map((singleType) => _buildSHoeSize(singleType.key))
            .toList());
  }


  Widget _buildSHoeSize(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        //  print("you selected @@@@@@@@@@ ${widget.productModel.avSize[_selectedIndex]}");

        });
      },
      child: Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.only(top: 530),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: OutlineButton(
            disabledBorderColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
    );
  }

  Widget orderButton(String location, String phoneNumber) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0Xff2b3144)),
      margin: const EdgeInsets.only(top: 670, left: 164),
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
          } else {
            orderedImage = widget.productModel.productImage;
            orderedPrice = widget.productModel.productPrice;
            await orderedItem(orderedImage, orderedPrice);

            Navigator.pop(context);
          }
        },
        child: Text(
          "Order",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
