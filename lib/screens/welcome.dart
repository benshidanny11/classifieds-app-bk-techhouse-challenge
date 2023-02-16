// ignore_for_file: use_build_context_synchronously

import 'package:classfiedapp/screens/home.dart';
import 'package:classfiedapp/services/AuthService.dart';
import 'package:classfiedapp/utils/preferences_utlil.dart';
import 'package:classfiedapp/utils/theme_util.dart';
import 'package:classfiedapp/widgets/alert.dart';
import 'package:flutter/material.dart';

import '../widgets/google_button.dart';

class Welcome extends StatefulWidget {
  static String id = '/welcome';
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool waitingForAppSetup = false;
  @override
  void initState() {
    waitingForAppSetup = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSharedPreferences().then((prefs) {
        if (prefs.getBool('DontShowSignupPage')!) {
          Navigator.pushReplacementNamed(context, Home.id);
        } else {
          if (AuthService.getCurrentUser() != null) {
            Navigator.pushReplacementNamed(context, Home.id);
          } else {
            setState(() {
              waitingForAppSetup = false;
            });
          }
        }
      }).catchError((onError) {
        setState(() {
          waitingForAppSetup = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: waitingForAppSetup
          ? Container()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/applogo.png'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Classfied app',
                    style: ThemeUtil().customTextStyle(
                        Theme.of(context).primaryColor, 22, FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('To be able to add your own products(Seller)'),
                  const SizedBox(
                    height: 5,
                  ),
                  GoogleButton(
                    onTap: () async {
                      try {
                        final user = await AuthService.signInWithGoogle();
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, Home.id);
                        } else {
                          print("======> User not signed in");
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: (() async {
                        
                        showCustomAlertDialog(context, "Sign in",
                            "Don't show this again? By clicking yes, you won't see this page again",
                            onNegativeButtonClick: () async{
                          final prefs = await getSharedPreferences();
                          prefs.setBool("DontShowSignupPage", false);
                          Navigator.pushReplacementNamed(context, Home.id);
                        }, onPostiveButtonClick: () async {
                          final prefs = await getSharedPreferences();
                          prefs.setBool("DontShowSignupPage", true);
                          Navigator.pushReplacementNamed(context, Home.id);
                        });
                      }),
                      child: Text('Not now',
                          style: ThemeUtil().customTextStyle(
                              Theme.of(context).primaryColor,
                              18,
                              FontWeight.w400)))
                ],
              ),
            ),
    );
  }
}
