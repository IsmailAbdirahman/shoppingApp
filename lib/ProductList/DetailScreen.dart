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

  DetailScreen({this.productModel,this.userID});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FireStoreService dataBaseService = FireStoreService();

  List<String> sizeperShoeList = ['40', '41', '42', '43', '44'];
  String orderedImage = '';
  String orderedPrice = '';
  int totalPrice = 0;
  int _counter = 1;
  static int prce = 0;
  int _selectedIndex = 0;

  Widget _diffSizeOfShoes(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
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
              sizeperShoeList[index],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: _selectedIndex == index ? Colors.white : Colors.grey,
              ),
            ),
          )),
    );
  }

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
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return StreamBuilder<UserData>(
      stream: FireStoreService(uid:widget.userID).userInfo,
      builder: (BuildContext context,snapshot){
        UserData userData = snapshot.data;
        if(snapshot.hasData){

          return Scaffold(
//      backgroundColor: Color(0xFF7A9BEE),
//      appBar: AppBar(
//        leading: IconButton(
//          onPressed: () {
//            Navigator.of(context).pop();
//          },
//          icon: Icon(Icons.arrow_back_ios),
//          color: Colors.white,
//        ),
//        backgroundColor: Colors.transparent,
//        elevation: 0.0,
//        title: Text(' Details'),
//        centerTitle: true,
//      ),
//      body: ListView(
//        children: <Widget>[
//          Stack(
//            children: <Widget>[
//              Container(
//                height: MediaQuery.of(context).size.height - 82.0,
//                width: MediaQuery.of(context).size.width,
//                color: Colors.transparent,
//              ),
//              Positioned(
//                top: 75,
//                child: Container(
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.only(
//                      topLeft: Radius.circular(35.0),
//                      topRight: Radius.circular(35.0),
//                      //color:Colors.white ,
//                    ),
//                    color: Colors.white,
//                  ),
//                  height: MediaQuery.of(context).size.height - 100.0,
//                  width: MediaQuery.of(context).size.width,
//                ),
//              ),
//
//              /// INCREMENT AND DECREMENT BUTTONS
//
//              Positioned(
//                top: 563.0,
//                left: 70,
//                child: Container(
//                  margin: EdgeInsets.all(12),
//                  child: IconButton(
//                    icon: Icon(Icons.add),
//                    onPressed:_incrementCounter,
//                  ),
//                ),
//              ),
//              Positioned(
//                  top: 590.0,
//                  left: 70,
//                  child: Text('$_counter')),
//              Positioned(
//                top: 566.0,
//                left: 30,
//                child: IconButton(
//                  onPressed: _decrementCounter,
//                  icon: Icon(Icons.minimize),
//                ),
//              ),
//              Hero(
//                tag: widget.productModel.productImage,
//                child: imageDetail(),
//              ),
//              Positioned(
//                top: 652.0,
//                left: 25.0,
//                right: 25.0,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Center(
//                      child: Text(
//                        '\$' '${widget.productModel.productPrice}',
//                        style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 13.0,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(height: 90),
//              Positioned(
//                top: 466.0,
//                left: 25.0,
//                right: 25.0,
//                child: Container(
//                  child: FlatButton(
//                    color: Color(0xFF7A9BEE),
//                    child: Text(
//                      'Order',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                    onPressed: () async {
//                      orderedImage = widget.productModel.productImage;
//                      orderedPrice = widget.productModel.productPrice;
//                      await orderedItem(orderedImage, orderedPrice);
//                    },
//                  ),
//                ),
//              ),
//
//            ],
//          )
//        ],
//      ),
//    );
              backgroundColor: Color(0Xff24202b),
              body: Stack(
                children: <Widget>[
                  imageDetail(),
                  backButton(context),
                  increaseAndDecreaseButton(),
                  priceWidget(),
                  _sizeOfShoeWidget(),
                  orderButton(userData.location,userData.phone),
                  //  orderButton(),
                ],
              ));
        }else{
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
        height: SizeConfig.blockSizeVertical*60,
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

  Widget _sizeOfShoeWidget() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: sizeperShoeList
            .asMap()
            .entries
            .map((singleType) => _diffSizeOfShoes(singleType.key))
            .toList());
  }

  Widget orderButton(String location,String phoneNumber) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0Xff2b3144)),
      margin: const EdgeInsets.only(top: 670, left: 164),
      child: FlatButton(
        onPressed: () async {
          if(location==""|| location == null ||phoneNumber=="" || phoneNumber ==null){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>AlertDailogForPhoneAndLocation()));
          }else{
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
