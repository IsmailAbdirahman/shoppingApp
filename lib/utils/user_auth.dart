import 'package:firebase_auth/firebase_auth.dart';
//userUID
final FirebaseAuth userAuth = FirebaseAuth.instance;
User? currentUserInfo = userAuth.currentUser;
