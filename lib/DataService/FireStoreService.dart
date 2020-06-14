import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ladhiifshopj/DataModel/OrderedModel.dart';
import 'package:ladhiifshopj/DataModel/ProductModel.dart';
import 'package:ladhiifshopj/DataModel/UserModel.dart';

class FireStoreService {
  final CollectionReference productData =
      Firestore.instance.collection('textt');
  final CollectionReference userData =
      Firestore.instance.collection('userData');
  final CollectionReference orderedData =
      Firestore.instance.collection('orderedData');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String orderIdNowDateTime = new DateTime.now().toString();
  final String uid;
  String namee;
  String phonee;

  String locatione;

  FireStoreService({this.uid});

  Future userInformation(String name, String email, String imageUrl,
      String useruid, String searchKey) async {
    final FirebaseUser user = await _auth.currentUser();
    return await userData.document(user.uid).setData({
      'name': name,
      'phone': email,
      'location': imageUrl,
      'useruid': useruid,
      'searchKey': searchKey
    });
  }

  //  Retrive
  UserData _userInfoFromsnapshot(DocumentSnapshot snapshot) {
    return UserData(
      name: snapshot.data['name'] ?? '',
      phone: snapshot.data['phone'],
      location: snapshot.data['location'],
    );
  }

  Stream<UserData> get userInfo {
    return userData.document(uid).snapshots().map(_userInfoFromsnapshot);
  }

//------------------------------------------------------------------------------------------------//
  // store images and price in firestore  ADMIN
  Future updateProductImageAndPrice(String image, String price) async {
    return await productData.document(uid).setData({
      'image': image,
      'textEntered': price,
    });
  }

  // Product list from snapshot  ADMIN
  List<ProductModel> _productListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ProductModel(
          productPrice: doc.data['textEntered'] ?? '',
          productImage: doc.data['image']);
    }).toList();
  }

// get brew streams   ADMIN
  Stream<List<ProductModel>> get productStream {
    return productData.snapshots().map(_productListFromSnapShot);
  }

  //================================================================================================//
  //store order id,ordered name, location and phone
  Future orderedProduct(
      String image, String price, String quantity, bool isDelivered) async {
    final FirebaseUser user = await _auth.currentUser();
    // get the information of user and store in orderedData collection
    await userData.document(user.uid).get().then((DocumentSnapshot snapshot) {
      namee = snapshot.data['name'];
      phonee = snapshot.data['phone'];
      locatione = snapshot.data['location'];
    });
    return await orderedData.document(orderIdNowDateTime).setData({
      'userId': user.uid,
      'productId':orderIdNowDateTime,
      'orderedImage': image,
      'orderedPrice': price,
      'quanity': quantity,
      'isDelivered': isDelivered,
      'name': namee,
      'phone': phonee,
      'location': locatione
    });
  }

  //Store data into myOrders collection
  Future myOrders(
      String image, String price, String quantity, bool isDelivered) async {
    final FirebaseUser user = await _auth.currentUser();
    return await userData
        .document(user.uid)
        .collection('myOrders')
        .document(orderIdNowDateTime)
        .setData({
      'productId':orderIdNowDateTime,
      'orderedImage': image,
      'orderedPrice': price,
      'quantity': quantity,
      'isDelivered': isDelivered,
    });
  }

  // get the data as snapshot
  List<OrderedModel> myOrderSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      print("STORING DATA ${doc.data['orderedImage']}");

      return OrderedModel(
          orderedImage: doc.data['orderedImage'] ?? '',
          orderedPrice: doc.data['orderedPrice'],
          isDelivered: doc.data['isDelivered'],
          quantity: doc.data['quantity']);
    }).toList();
  }

  // get the snapshot as stream
  Stream<List<OrderedModel>> get orderedStream {
    return userData
        .document(uid)
        .collection('myOrders').orderBy('productId',descending: true)
        .snapshots()
        .map(myOrderSnapShot);
  }
}