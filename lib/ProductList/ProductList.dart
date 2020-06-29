import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/UserInfoModel.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/ProductList/DetailScreen.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:ladhiifshopj/ProductList/SearchProduct.dart';
import 'package:provider/provider.dart';


import '../ConfigScreen.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  static String categoryType;
  int _selectedIndex = 0;
  List<ProductModel> male;
  List<ProductModel> female;
  List<String> categoryList = ['Men', 'Women'];

  Widget genderType(int index) {
    print("OUTSIDE ${categoryList[index]}");
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          categoryType = categoryList[index];
          print("INSIDE MALE ${categoryType}");
        });
      },
      child: Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: OutlineButton(
            disabledBorderColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: null,
            child: Text(
              categoryList[index],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: _selectedIndex == index ? Colors.white : Colors.grey,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
        stream: FireStoreService().productStream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> productModel = snapshot.data;

            return SafeArea(
              child: Scaffold(
                backgroundColor: Color(0Xff24202b),
                body: Container(
                  margin: EdgeInsets.only(top: 90),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _theShopNameWidget(),
                          searchBar(context, productModel),
                        ],
                      ),
                      categories(),
                      Expanded(
                        child: listViewWidget(productModel),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget searchBar(BuildContext context, var searchProductName) {
    return IconButton(
      icon: Icon(Icons.search,color: Colors.white70,size: 27,),
      onPressed: () {
        showSearch(
            context: context,
            delegate: SearchProduct(searchProductName: searchProductName));
      },
    );
  }

  Widget categories() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: categoryList
            .asMap()
            .entries
            .map((singleType) => genderType(singleType.key))
            .toList());
//      children: <Widget>[
//        RaisedButton(
//          onPressed: () {
//            setState(() {
//              categoryType = "male";
//            });
//          },
//          child: Text(
//            "Male",
//            style: TextStyle(color: Colors.white),
//          ),
//        ),
//        RaisedButton(
//          onPressed: () {
//            setState(() {
//              categoryType = "female";
//            });
//          },
//          child: Text(
//            "female",
//            style: TextStyle(color: Colors.white),
//          ),
//        ),
//      ],
  }

  Widget _theShopNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Welcome",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 3.6,
                color: Colors.white,
                fontSize: 28)),
        Text("",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
                color: Colors.grey,
                fontSize: 12)),
      ],
    );
  }



  Widget listViewWidget(var productModel) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: productModel.length,
        itemBuilder: (BuildContext context, int index) {
          if (productModel[index].men == categoryType) {
            return SlideCard(
              productModel: productModel[index],
            );

          } else if (productModel[index].women == categoryType) {
            return SlideCard(
              productModel: productModel[index],
            );

          } else {
            return Text(" ");
          }
        });
  }
}

class SlideCard extends StatelessWidget {
  final ProductModel productModel;

  SlideCard({this.productModel});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final userID = Provider.of<UserModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      productModel: productModel,
                      userID: userID.uid,
                    )));
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: productModel.productImage,
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff18171b),
              ),
              margin: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              padding: const EdgeInsets.only(
                  top: 40, right: 40, left: 40, bottom: 40),
              width: SizeConfig.blockSizeHorizontal *88,
              height: SizeConfig.blockSizeVertical *60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image(
                  image: NetworkImage(productModel.productImage),
                ),
              ),
            ),
          ),
          // Text("kakakaka",style: TextStyle(color: Colors.white),),
          Positioned(
            bottom: 350,
            left: 66,
            child: Container(
              height: SizeConfig.blockSizeVertical *8,
              width: SizeConfig.blockSizeHorizontal *15,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0Xff1b1a1b)),
              child: Text(
                '\$' '${productModel.productPrice}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 66,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                '${productModel.productName}',
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
