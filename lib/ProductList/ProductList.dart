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
      icon: Icon(
        Icons.search,
        color: Colors.white70,
        size: 27,
      ),
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
      child: Container(
        // height: SizeConfig.blockSizeVertical *10,
        width: SizeConfig.blockSizeHorizontal * 80,
        child: Padding(
          padding: const EdgeInsets.only(top: 40,bottom: 20),
          child: Card(
            color: Color(0xff18171b),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                priceWidget(),
                Expanded(child: imageWidget()),
                // Text("kakakaka",style: TextStyle(color: Colors.white),),
                nameWidget(),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget priceWidget(){
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: SizeConfig.blockSizeVertical * 6.5,
        width: SizeConfig.blockSizeHorizontal * 15,
        padding: const EdgeInsets.all(17),
        margin: const EdgeInsets.only(left: 8,top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0Xff24202b)),
        child: Text(
          '\$' '${productModel.productPrice}',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
  Widget imageWidget(){
    return Hero(
      tag: productModel.productImage,
      child: Container(
//          height: SizeConfig.screenHeight = 107,
//          width: SizeConfig.blockSizeHorizontal * 66,
        child: Image(
          image: NetworkImage(productModel.productImage),

        ),
      ),
    );
  }
  Widget nameWidget(){
    return Align(
      alignment: Alignment.bottomLeft,
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
    );
  }
}
