import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:ladhiifshopj/ProductList/DetailScreen.dart';

class ProductTile extends StatelessWidget {
  final ProductModel productModel;

  ProductTile({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(35.0),
      child: Container(
        height: 120,
        width: 50,
        child: Card(
          color: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
          elevation: 0,
          child:  ListTile(
            contentPadding: EdgeInsets.all(5.0),
            leading: Hero(
              tag: productModel.productImage,
              child: Image(
                image: NetworkImage(productModel.productImage),
                fit: BoxFit.cover,
              ),
            ),
            trailing: Text(
              '\$' '${productModel.productPrice}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(productModel: productModel),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
