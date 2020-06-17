import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/UserInfoModel.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/ProductList/DetailScreen.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:provider/provider.dart';


class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: FireStoreService().productStream,
      builder: (BuildContext context, snapshot){

        if(snapshot.hasData){
          List<ProductModel> productModel = snapshot.data;
          return Scaffold(
            backgroundColor: Color(0Xff24202b),
            body: Container(
              margin: EdgeInsets.only(top: 90),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _theShopNameWidget(),
                      _userProfilePic(),
                    ],
                  ),
                  Expanded(
                    child: listViewWidget(productModel),
                  )
                ],
              ),
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      }
    );
  }

  Widget _theShopNameWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Ladhiif",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 3.6,
                color: Colors.white,
                fontSize: 28)),
        Text("Shop",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
                color: Colors.grey,
                fontSize: 12)),
      ],
    );
  }

  Widget _userProfilePic() {
    return Container(
      width: 70,
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xff18171b)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0Xff111112),
              ),
              child: Text(
                "9",
                style: TextStyle(color: Colors.white),
              )),
          Icon(Icons.shopping_cart, color: Colors.white),
          Text(
            '67 Rs',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget listViewWidget(var productModell) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: productModell.length,
        itemBuilder: (_, int index) {
          return SlideCard(
            productModel: productModell[index],
          );
        });
  }
}

class SlideCard extends StatelessWidget {
  final ProductModel productModel;

  SlideCard({this.productModel});

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<UserModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(productModel: productModel,userID: userID.uid,)));
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: productModel.productImage,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 15, right: 20, left: 30, bottom: 20),
              width: 380,
              height: 590,
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
            bottom: 297,
            left: 66,
            child: Container(
              height: 55,
              width: 55,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff18171b)),
              child: Text(
                '\$' '${productModel.productPrice}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
