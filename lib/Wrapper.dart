import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfire_ui/auth.dart';
import 'DisplayData.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              SizedBox(
                height: 210,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome to Shmarket",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      wordSpacing: 2,
                      letterSpacing: 2,
                      fontSize: 18),
                ),
              ),
              Expanded(
                child: SignInScreen(
                  showAuthActionSwitch: false,
                  providerConfigs: [
                    GoogleProviderConfiguration(
                        clientId:
                            "83833412591-eam7oapvitrc09oklgqb5tte8al43r2q.apps.googleusercontent.com")
                  ],
                ),
              ),
            ],
          );
        } else {
          return DisplayData();
        }
      },
    );
  }
}
