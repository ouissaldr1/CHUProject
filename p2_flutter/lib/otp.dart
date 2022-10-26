import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p2_flutter/AppColors.dart';
import 'package:p2_flutter/quastionClass.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'package:p2_flutter/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p2_flutter/questionnaire.dart';
import 'myApp.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+212${widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.setString("numberPhone", widget.phone);
     
              if (value.additionalUserInfo!.isNewUser) {
                 preferences.setBool("isLogged",false);
                 preferences.setBool("isPuttingNumber", true);
             
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => singUpState(widget.phone)),
                    (route) => false);
              } else {
                  preferences.setBool("isPuttingNumber", true);
                 preferences.setBool("isLogged",true);
                Navigator.pushAndRemoveUntil(
                    context,
                    
                    // MaterialPageRoute(builder: (context) =>Questionnaire(widget.phone)),
                     MaterialPageRoute(builder: (context) =>MyAppp()),
                    (route) => false);
              }
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _pinPutController = TextEditingController();
    final FocusNode _pinPutFocusNode = FocusNode();
    final BoxDecoration _pinPutDecoration = BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );

    return Scaffold(
        key: _scaffoldkey,
       
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Center(
                  child: Text(
                'vérifier +212 ${widget.phone}',style: TextStyle(fontSize: 18,color: AppColors.mainColor),
              )),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),

                boxShadow: [BoxShadow(color: AppColors.mainColor,blurRadius: 10.0,spreadRadius: 0.7)]
              ),
              child: PinPut(
                fieldsCount: 6,
                onSubmit: (String pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode as String,
                            smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {
                        SharedPreferences preferences = await SharedPreferences.getInstance();
      
                          if (value.additionalUserInfo!.isNewUser) {
                     preferences.setBool("isLogged",false);
                 preferences.setBool("isPuttingNumber", true);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => singUpState(widget.phone)),
                    (route) => false);
              } else {
                preferences.setBool("isPuttingNumber", true);
                preferences.setBool("isLogged",true);
                Navigator.pushAndRemoveUntil(
                    context,
                    
                    // MaterialPageRoute(builder: (context) => Questionnaire(widget.phone)),
                      MaterialPageRoute(builder: (context) => MyAppp()),
                    (route) => false);
              }
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Login failed")));
                  }
                },
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                selectedFieldDecoration: _pinPutDecoration,
                followingFieldDecoration: _pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.deepPurpleAccent.withOpacity(.5),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
