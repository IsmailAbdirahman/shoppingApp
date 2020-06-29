

import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/OrderedModel.dart';


class OrderedTile extends StatelessWidget {
  final OrderedModel ordereedModel;

  OrderedTile({this.ordereedModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        elevation: 6.0,
        child: ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Image.network(ordereedModel.orderedImage,
            loadingBuilder:  (context,child,progress){
              return progress==null ?child:LinearProgressIndicator();
            },),
          subtitle: Text('your order is on the way',
            style: TextStyle(color: Colors.red,fontSize: 12.0),
          ),
          trailing: Text('${ordereedModel.quantity} * \$ ${ordereedModel.orderedPrice}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),




        ),
      ),
    );
  }
}
