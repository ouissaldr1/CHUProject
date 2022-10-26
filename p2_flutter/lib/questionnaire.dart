import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AppColors.dart';
import 'test.dart';
import 'myApp.dart';
import 'package:p2_flutter/pages/home/meets_detail.dart';

class Questionnaire extends StatefulWidget {
  final String phone;
  const Questionnaire(this.phone);
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Questionnaire> {
  final _formKey = GlobalKey<FormState>();
  List question = [
    {
      "name": "Au cours des 12 derniers mois, votre poids a-t-il varié",
    },
    {
      "name": "Avez-vous des difficultés à marcher 500 mètres, sans aide",
    },
    {
      "name": "Votre diabète a-t-il eu un impact sur votre parcours scolaire",
    },
    {
      "name":
          "Utilisez-vous un lecteur de glycémie ou un capteur en continu à votre domicile",
    },
    {
      "name": "Pensez-vous que vous avez trop de comprimés à prendre",
    },
  ];
  late String q2;
  String question5 = "";
  String question6 = "";
  String question7 = "";
  String question8 = "";

  addData() async {
    if (_formKey.currentState!.validate()) {
      CollectionReference usersRef =
          FirebaseFirestore.instance.collection("questionnaire");

      usersRef.doc(widget.phone).update({
        "question5": question5,
        "question6": question6,
        "question7": question7,
        "question8": question8,
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MyAppp();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('les champs sont obligatoirs')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 54, 170, 157),
          Color.fromARGB(255, 112, 201, 190).withOpacity(0.7),
        ],
        begin: const FractionalOffset(0.0, 0.4),
        end: Alignment.topRight,
      )),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 10,
              right: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Column(children: [
              Row(
                children: [
                  Expanded(child: Container()),
                  Text("QUESTIONNAIRE"),
                  Icon(
                    Icons.info_outline,
                    size: 20,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20, right: 70, bottom: 10),
                //****************************************************** */
                child: Column(
                  children: [
                    Text("Répondez au questionnaire s'il vous plaît",
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color(0xFF332d2b))),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 120, left: 5),
                      child: Text(
                        "pour votre santé !!!",
                        style: TextStyle(color: Color(0xFF332d2b)),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                      )),
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("Question et Réponse",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    /*--------------------------------------------*/
                    Expanded(
                        child: GestureDetector(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                indent: 20,
                                endIndent: 20,
                                color: Color(0xFFa9a29f),
                                thickness: 1,
                              ),
                          itemCount: question.length,
                          itemBuilder: (context, i) {
                            return Container(
                              height: 130,
                              margin: EdgeInsets.only(
                                  left: 20, top: 5, right: 20, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  "${question[i]['name']}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'ce champ est obligatoir';
                                    }
                                    return null;
                                  },
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    hintText: "ecrire ici",
                                  ),
                                  onChanged: (value) {
                                    if (i == 0) {
                                      question5 = value;
                                    } else if (i == 1) {
                                      question6 = value;
                                    } else if (i == 2) {
                                      question7 = value;
                                    } else {
                                      question8 = value;
                                    }
                                  },
                                ),
                                leading: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${i + 1}",
                                      style: TextStyle(
                                          color: Color(0xFF8f837f),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.white,
                                            Color(0xFFffd28d),
                                            Color(0xFFffd28d),
                                            Colors.white
                                          ],
                                        ))),
                              ),
                            );
                          }),
                    )),
                    Container(
                        child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          // style: flatButtonStyle,
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Test(widget.phone);
                            }));
                          },
                          child: Image.asset(
                            "assets/image/retour.png",
                            width: 50,
                          ),
                        ),
                        TextButton(
                          // style: flatButtonStyle,
                          onPressed: () {
                            addData();
                          },
                          child: Image.asset(
                            "assets/image/suivant.png",
                            width: 50,
                          ),
                        ),
                      ],
                    )),

                    /*----------------------------------*/
                  ]))),
        ],
      ),
    ));
  }
}
