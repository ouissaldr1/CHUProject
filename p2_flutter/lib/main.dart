import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart'
    as phoneInput;

import 'package:p2_flutter/admin.dart';
import 'package:p2_flutter/signUp.dart';
import 'package:p2_flutter/ajouter.dart';
import 'package:p2_flutter/questionnaire.dart';

import 'package:p2_flutter/pages/home/informations.dart';
import 'package:p2_flutter/pages/home/meets_detail.dart';

import 'package:p2_flutter/signUp.dart';
import 'package:p2_flutter/otp.dart';
import 'package:p2_flutter/ajouter.dart';
import 'package:p2_flutter/voirPlus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_fadein/flutter_fadein.dart';
import 'AppColors.dart';

import 'test.dart';
import 'myApp.dart';
import 'admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isPuttingNumber = (prefs.getBool('isPuttingNumber') == null)
      ? false
      : prefs.getBool('isPuttingNumber');
  var isLogged =
      (prefs.getBool('isLogged') == null) ? false : prefs.getBool('isLogged');
  var isSubscribed = (prefs.getBool('isSubscribed') == null)
      ? false
      : prefs.getBool('isSubscribed');
  var isAdmin = (prefs.getBool('Admin') == null)
      ? false
      : true;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isPuttingNumber as bool
        ? (isLogged as bool
            ? MyAppp()
            : (isSubscribed as bool
                ? MyAppp()
                : singUpState(prefs.getString("numberPhone") as String)))
        : (isAdmin as bool
                ? Admin()
                : MyApp()),
  ));
} //class without interaction

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: //HomePage(),
      MainPage()
           //MyApp()
      //singUpState(),


      //  MyApp()
      // Admin(),

    );
    // Questionnaire());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  bool validate = false;
  var numberPhone;
  int? num;
  void send() async {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      if (controller.text == "6123456788") {

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Admin()));

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("Admin", true);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Admin()));

        formdata.save();
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OTPScreen(controller.text)));
        formdata.save();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Container(
                  padding: EdgeInsets.all(30),
                  width: double.infinity,
                  child: Column(children: [
                    Image.asset("assets/image/login.png",
                        width: 280, fit: BoxFit.cover),
                    SizedBox(
                      height: 50,
                    ),
                    FadeIn(
                      child: Text(
                        "Bonjour!!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FadeIn(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                                "Veuiller saisir votre numéro de téléphone, aprés nous vous enyons un code de vérification",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: // Colors.grey.shade700
                                        AppColors.paraColor)))),
                    SizedBox(
                      height: 30,
                    ),
                    FadeIn(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffeeeeee),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.13))),
                            child: Stack(children: [
                              phoneInput.InternationalPhoneNumberInput(
                                textFieldController: controller,
                                initialValue:
                                    phoneInput.PhoneNumber(isoCode: 'MA'),
                                onInputChanged:
                                    (phoneInput.PhoneNumber number) {},
                                onInputValidated: (bool value) {
                                  validate = value;
                                },
                                selectorConfig: phoneInput.SelectorConfig(
                                  selectorType: phoneInput
                                      .PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                inputDecoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 15, left: 0),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16,
                                    )),
                                formatInput: false,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                inputBorder: OutlineInputBorder(),
                                onSaved: (phoneInput.PhoneNumber number) {
                                  numberPhone = number;
                                },
                              ),
                              Positioned(
                                  left: 90,
                                  top: 8,
                                  bottom: 8,
                                  child: Container(
                                    height: 40,
                                    width: 1,
                                    color: Colors.black.withOpacity(0.13),
                                  )),
                            ]))),
                    SizedBox(
                      height: 100,
                    ),
                    FadeIn(
                        child: MaterialButton(
                            onPressed: () {
                              send();
                            },
                            color: AppColors.mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            minWidth: double.infinity,
                            child: Text("vérifier",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                )))),
                  ])))),
    ));
  }
}
