import 'package:flutter/material.dart';
import 'package:ladhiifshopj/ConfigScreen.dart';
import 'package:ladhiifshopj/DataModel/OrderedModel.dart';
import 'package:ladhiifshopj/DataModel/UserInfoModel.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';
import '../ConfigScreen.dart';

class OrderedList extends StatefulWidget {
  @override
  OrderedListState createState() => OrderedListState();
}

class OrderedListState extends State<OrderedList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OrderedModel>>(
        stream: FireStoreService().orderedStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderedModel>? orderedModel = snapshot.data;

            return Container(
              margin: EdgeInsets.all(4.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: orderedModel!.length,
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
  final OrderedModel orderedModel;

  OrderSlideCard({required this.orderedModel});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
        onTap: null,
        child: Container(
            height: 320,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Color(0xff18171b),
                elevation: 0,
                child: GestureDetector(
                  onTap: null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      statusWidget(orderedModel),
                      imageWidget(orderedModel),
                      nameAndQuantityWidgets(orderedModel),
                      sizeAndTotalPriceWidgets(orderedModel)
                    ],
                  ),
                ))));
  }

  Widget statusWidget(OrderedModel orderedModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 17, left: 17, top: 10),
      child: Row(
        children: <Widget>[
          Text(
            "Status: ",
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
          ),
          orderedModel.isDelivered == false
              ? Icon(
                  Icons.local_shipping,
                  color: Colors.deepOrange,
                )
              : Icon(
                  Icons.shopping_basket,
                  color: Colors.greenAccent,
                ),
        ],
      ),
    );
  }

  Widget imageWidget(OrderedModel orderedModel) {
    return Container(
        height: SizeConfig.blockSizeVertical * 20,
        width: SizeConfig.blockSizeHorizontal * 55,
        child: Image.network(orderedModel.orderedImage!));
  }

  Widget nameAndQuantityWidgets(OrderedModel orderedModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 17, left: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Name: ${orderedModel.nameOfShoe}",
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
          ),
          Text("quantity: ${orderedModel.quantity}",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget sizeAndTotalPriceWidgets(OrderedModel orderedModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 17, left: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Size: ${orderedModel.sizeOfShoe}",
            style:
                TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
          ),
          Text("Total:  \$${orderedModel.orderedPrice}",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.white70)),
        ],
      ),
    );
  }
}
