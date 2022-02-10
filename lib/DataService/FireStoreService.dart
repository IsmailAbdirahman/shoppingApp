import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ladhiifshopj/DataModel/OrderedModel.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:ladhiifshopj/DataModel/UserModel.dart';
import 'package:ladhiifshopj/utils/user_auth.dart';

class FireStoreService {
  final CollectionReference productData =
      FirebaseFirestore.instance.collection('product');
  final CollectionReference userData =
      FirebaseFirestore.instance.collection('userData');
  final CollectionReference orderedData =
      FirebaseFirestore.instance.collection('orderedData');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String orderIdNowDateTime = new DateTime.now().toString();

  // final String uid;
  String? nameOfCustomer;
  String? phoneOfCustomer;
  String? locationOfCustomer;
  String? phoneNumber;

  //FireStoreService({this.uid});

  Future userInformation(String name, String email, String imageUrl,
      String useruid, String location, String phoneNumber) async {
    return await userData.doc(currentUserInfo!.uid).set({
      'name': name,
      'phone': email,
      'imageurl': imageUrl,
      'useruid': useruid,
      'location': location,
      'phoneNumber': phoneNumber
    });
  }

  Future updateUserInformation(
      {String? name, String? location, String? phoneNumber}) async {
    final User? userInfo = userAuth.currentUser;
    return await userData.doc(userInfo!.uid).update(
        {'name': name, 'location': location, 'phoneNumber': phoneNumber});
  }

  //  Retrive
  UserData _userInfoFromsnapshot(DocumentSnapshot snapshot) {
    return UserData(
      name: snapshot.get('name'),
      location: snapshot.get('location'),
      phone: snapshot.get('phoneNumber'),
    );
  }

  Stream<UserData> get userInfo {
    return userData
        .doc(currentUserInfo!.uid)
        .snapshots()
        .map(_userInfoFromsnapshot);
  }

  updateLocationAndPhoneNo(String location, String phoneNumber) async {
    return await userData
        .doc(currentUserInfo!.uid)
        .update({'location': location, 'phoneNumber': phoneNumber});
  }

//------------------------------------------------------------------------------------------------//

  // Product list from snapshot  ADMIN
  List<ProductModel> _productListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ProductModel(
          productPrice: doc.get('price') ?? '',
          men: doc.get('Men'),
          women: doc.get('Women'),
          productName: doc.get('nameOfProduct'),
          productDescription: doc.get('descriptionOfProduct'),
          avSize: List.from(doc['avSizes']),
          productImage: doc.get('image'));
    }).toList();
  }

// get brew streams   ADMIN
  Stream<List<ProductModel>> get productStream {
    return productData.snapshots().map(_productListFromSnapShot);
  }

  //================================================================================================//
  //store order id,ordered name, location and phone
  Future orderedProduct(
      String image,
      String price,
      String quantity,
      bool isDelivered,
      String nameOfShoe,
      selectedSizeOfShoe,
      String orderedDate) async {
    // get the information of user and store in orderedData collection
    await userData
        .doc(currentUserInfo!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      nameOfCustomer = snapshot.get('name');
      phoneOfCustomer = snapshot.get('phone');
      phoneNumber = snapshot.get('phoneNumber');
      locationOfCustomer = snapshot.get('location');
    });
    return await orderedData.doc(orderIdNowDateTime).set({
      'userId': currentUserInfo!.uid,
      'productId': orderIdNowDateTime,
      'orderedImage': image,
      'orderedPrice': price,
      'quanity': quantity,
      'isDelivered': isDelivered,
      'nameofShoe': nameOfShoe,
      'selectedShoeSize': selectedSizeOfShoe,
      'name': nameOfCustomer,
      'phone': phoneOfCustomer,
      'phoneNumber': phoneNumber,
      'location': locationOfCustomer,
      'orderedDate': orderedDate,
    });
  }

  //Store data into myOrders collection
  Future myOrders(String image, String price, String quantity, bool isDelivered,
      String nameOfShoe, selectedSizeOfShoe, String orderedDate) async {
    return await userData
        .doc(currentUserInfo!.uid)
        .collection('myOrders')
        .doc(orderIdNowDateTime)
        .set({
      'productId': orderIdNowDateTime,
      'orderedImage': image,
      'orderedPrice': price,
      'quantity': quantity,
      'nameOfShoe': nameOfShoe,
      'selectedSizeOfShoe': selectedSizeOfShoe,
      'isDelivered': isDelivered,
      'orderedDate': orderedDate
    });
  }

  // get the data as snapshot
  List<OrderedModel> myOrderSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return OrderedModel(
          orderedImage: doc.get('orderedImage') ?? '',
          orderedPrice: doc.get('orderedPrice'),
          isDelivered: doc.get('isDelivered'),
          nameOfShoe: doc.get('nameOfShoe'),
          sizeOfShoe: doc.get('selectedSizeOfShoe'),
          orderedDate: doc.get('orderedDate'),
          quantity: doc.get('quantity'));
    }).toList();
  }

  // get the snapshot as stream
  Stream<List<OrderedModel>> get orderedStream {
    return userData
        .doc(currentUserInfo!.uid)
        .collection('myOrders')
        .orderBy('productId', descending: true)
        .snapshots()
        .map(myOrderSnapShot);
  }
}
