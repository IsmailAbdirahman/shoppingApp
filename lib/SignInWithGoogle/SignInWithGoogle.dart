import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:ladhiifshopj/DataModel/UserInfoModel.dart';
import 'package:ladhiifshopj/DataService/FireStoreService.dart';





FireStoreService fireStoreService = new FireStoreService();
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String userUid;
String name;
String email;
String imageUrl;
String searchKey;


// i created userModel class just like this: i am using this class to get the UID of the user.
// in my case i already created, so now take this code below and copy paste in new class.

//class UserModel {
//  final String uid;
//  UserModel({this.uid});
//}
//
//
//class UserInfoModel{
//  final String id;
//  final String name;
//  final String gmail;
//  final String imageUrl;
//
//
//  UserInfoModel({this.id,this.name,this.gmail,this.imageUrl});
//
//}

// in this method get the uid from googleSignIng()
UserModel _userFromFirebaseUser(FirebaseUser user) {
  return user != null ? UserModel(uid: user.uid) : null;

}

// use this stream in main class and receive it as a streamProvider
Stream<UserModel> get user {
  return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
}

Future signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);
  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  userUid = user.uid;
  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
    searchKey = name.substring(0,1);
    print('BRO The Name is $name');
    print('BRO The email is $email');
    print('BRO The imageUrl is $imageUrl');
    // here i am storing the name email and image url in fireStore.
    await fireStoreService.userInformation(name, email, imageUrl,userUid,searchKey);
  }
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  return _userFromFirebaseUser(user);
}
void signOutGoogle() async {
  await googleSignIn.signOut();
}