import 'package:flutter/material.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:ladhiifshopj/ProductList/ProductList.dart';
import '../ConfigScreen.dart';


class SearchProduct extends SearchDelegate {
  final List<ProductModel> searchProductName;

  SearchProduct({this.searchProductName});

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Color(0Xff24202b),
      backgroundColor: Colors.black,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear, color: Colors.white70),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white70,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final List suggestionList = query.isEmpty
        ? searchProductName
        : searchProductName
            .where((element) => element.productName
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();
    return Container(
      child: ListView.builder(
          primary: false,
          itemCount: suggestionList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return SlideCard(
              productModel: suggestionList[index],
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionList = query.isEmpty
        ? searchProductName
        : searchProductName
            .where((element) => element.productName
                .toString()
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();
    return Container(
      color: Color(0Xff24202b),
      child: ListView.builder(
          primary: false,
          itemCount: suggestionList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return SlideCard(productModel: suggestionList[index]);
          }),
    );
  }
}
