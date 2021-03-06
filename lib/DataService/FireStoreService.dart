import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ladhiifshopj/DataModel/OrderedModel.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:ladhiifshopj/DataModel/UserModel.dart';

class FireStoreService {
  final CollectionReference productData =
      Firestore.instance.collection('product');
  final CollectionReference userData =
      Firestore.instance.collection('userData');
  final CollectionReference orderedData =
      Firestore.instance.collection('orderedData');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String orderIdNowDateTime = new DateTime.now().toString();
  final String uid;
  String nameOfCustomer;
  String phoneOfCustomer;
  String locationOfCustomer;
  String phoneNumber;

  FireStoreService({this.uid});

  Future userInformation(String name, String email, String imageUrl,
      String useruid, String location, String phoneNumber) async {
    final FirebaseUser user = await _auth.currentUser();
    return await userData.document(user.uid).setData({
      'name': name,
      'phone': email,
      'imageurl': imageUrl,
      'useruid': useruid,
      'location': location,
      'phoneNumber': phoneNumber
    });
  }

  Future updateUserInformation(
      {String name, String location, String phoneNumber}) async {
    final FirebaseUser user = await _auth.currentUser();
    return await userData.document(user.uid).updateData(
        {'name': name, 'location': location, 'phoneNumber': phoneNumber});
  }

  //  Retrive
  UserData _userInfoFromsnapshot(DocumentSnapshot snapshot) {
    return UserData(
      name: snapshot.data['name'],
      location: snapshot.data['location'],
      phone: snapshot.data['phoneNumber'],
    );
  }

  Stream<UserData> get userInfo {
    return userData.document(uid).snapshots().map(_userInfoFromsnapshot);
  }

  updateLocationAndPhoneNo(String location, String phoneNumber) async {
    final FirebaseUser user = await _auth.currentUser();
    return await userData
        .document(user.uid)
        .updateData({'location': location, 'phoneNumber': phoneNumber});
  }

//------------------------------------------------------------------------------------------------//

  // Product list from snapshot  ADMIN
  List<ProductModel> _productListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ProductModel(
          productPrice: doc.data['price'] ?? '',
          men: doc.data['Men'],
          women: doc.data['Women'],
          productName: doc.data['nameOfProduct'],
          productDescription: doc.data['descriptionOfProduct'],
          avSize: List.from(doc['avSizes']),
          productImage: doc.data['image']);
    }).toList();
  }

// get brew streams   ADMIN
  Stream<List<ProductModel>> get productStream {
    return productData.snapshots().map(_productListFromSnapShot);
  }

  //================================================================================================//
  //store order id,ordered name, location and phone
  Future orderedProduct(String image, String price, String quantity,
      bool isDelivered, String nameOfShoe, selectedSizeOfShoe,String orderedDate) async {
    final FirebaseUser user = await _auth.currentUser();
    // get the information of user and store in orderedData collection
    await userData.document(user.uid).get().then((DocumentSnapshot snapshot) {
      nameOfCustomer = snapshot.data['name'];
      phoneOfCustomer = snapshot.data['phone'];
      phoneNumber = snapshot.data['phoneNumber'];
      locationOfCustomer = snapshot.data['location'];
    });
    return await orderedData.document(orderIdNowDateTime).setData({
      'userId': user.uid,
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
      'orderedDate':orderedDate,
    });
  }

  //Store data into myOrders collection
  Future myOrders(String image, String price, String quantity, bool isDelivered,
      String nameOfShoe, selectedSizeOfShoe,String orderedDate) async {
    final FirebaseUser user = await _auth.currentUser();
    return await userData
        .document(user.uid)
        .collection('myOrders')
        .document(orderIdNowDateTime)
        .setData({
      'productId': orderIdNowDateTime,
      'orderedImage': image,
      'orderedPrice': price,
      'quantity': quantity,
      'nameOfShoe': nameOfShoe,
      'selectedSizeOfShoe': selectedSizeOfShoe,
      'isDelivered': isDelivered,
      'orderedDate':orderedDate
    });
  }

  // get the data as snapshot
  List<OrderedModel> myOrderSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return OrderedModel(
          orderedImage: doc.data['orderedImage'] ?? '',
          orderedPrice: doc.data['orderedPrice'],
          isDelivered: doc.data['isDelivered'],
          nameOfShoe: doc.data['nameOfShoe'],
          sizeOfShoe: doc.data['selectedSizeOfShoe'],
          orderedDate:doc.data['orderedDate'],
          quantity: doc.data['quantity']);
    }).toList();
  }

  // get the snapshot as stream
  Stream<List<OrderedModel>> get orderedStream {
    return userData
        .document(uid)
        .collection('myOrders')
        .orderBy('productId', descending: true)
        .snapshots()
        .map(myOrderSnapShot);
  }
}
