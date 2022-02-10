// import 'package:flutter/material.dart';
// import '../DisplayData.dart';
// import 'SignInWithGoogle.dart';
//
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: Color(0Xff24202b),
//       body: Container(
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(height: 50),
//               Container(
//                 margin: EdgeInsets.only(top: 2),
//                 padding: EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   color: Color(0Xff2b3144),
//
//                 ),
//                 child: FlatButton(
//                   onPressed: ()  {
//                     signInWithGoogle().whenComplete(() {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return DisplayData();
//                           },
//                         ),
//                       );
//                     });
//                   },
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Text(
//                             'Sign in with Google',
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white70,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
// }