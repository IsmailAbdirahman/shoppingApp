import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/OrderedModel.dart';
import 'package:ladhiifshopj/DataModel/UserInfoModel.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import 'package:ladhiifshopj/ProductList/DetailScreen.dart';
import 'package:provider/provider.dart';
import 'OrderedTile.dart';

class OrderedList extends StatefulWidget {
  @override
  OrderedListState createState() => OrderedListState();
}

class OrderedListState extends State<OrderedList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<List<OrderedModel>>(
        stream: FireStoreService(uid: user.uid).orderedStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderedModel> orderedModel = snapshot.data;

            return Container(
              margin: EdgeInsets.all(4.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: orderedModel.length,
                itemBuilder: (context, index) {
                  return OrderSlideCard(orderedModel: orderedModel[index]);
                },
              ),
            );
          } else {
            return Text('not orderd yet');
          }
        });
  }
}

class OrderSlideCard extends StatelessWidget {
  // final String imageUrl, price, name, type;
  final OrderedModel orderedModel;

  OrderSlideCard({this.orderedModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(50),
            width: 380,
            height: 390,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image(
                image: NetworkImage(orderedModel.orderedImage),
              ),
            ),
          ),
          Divider(
            thickness: 15,
          ),
          Positioned(
            bottom: 330,
            left: 10,
            child: Text(
              'Status:',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            bottom: 322,
            left: 60,
            child: Container(
                height: 30,
                width: 50,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff18171b)),
                child:
                    orderedModel.isDelivered != null && orderedModel.isDelivered
                        ? Icon(
                            Icons.shopping_basket,
                            color: Colors.greenAccent,
                          )
                        : Icon(
                            Icons.local_shipping,
                            color: Colors.deepOrange,
                          )),
          ),
          Positioned(
            bottom: 12,
            left: 260,
            child: Container(
              height: 50,
              width: 115,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff18171b)),
              child: Text(
                'Total:' ' ' '\$' '${orderedModel.orderedPrice}',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 20,
            child: Container(
              height: 50,
              width: 115,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff18171b)),
              child: Text(
                'Quanity:' ' ' '${orderedModel.quantity}',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
