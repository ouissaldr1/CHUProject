import 'package:flutter/material.dart';
import 'package:p2_flutter/AppColors.dart';

import 'package:p2_flutter/otp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test.dart';

class singUpState extends StatefulWidget {
  final String phone;
  singUpState(this.phone);

  @override
  State<singUpState> createState() => _singUpState();
}

class _singUpState extends State<singUpState> {
  @override
  void initState() {
  
    super.initState();
  }

  String? nom, prenom;
  int? num;
  var selectedDate;
  String? sexe;
  String? person ;
  


  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signUp() async {
    var formdata = formstate.currentState;

    if (formdata!.validate()) {
      
      formdata.save();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("prenom",prenom as String);
      setData();
      preferences.setBool("isSubscribed", true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return Test(widget.phone);
      }
      )
      );
    
      
    } else {
     
    }
  }

  TextEditingController _controller = TextEditingController();
  setData() async {
    CollectionReference usersref =
        FirebaseFirestore.instance.collection('users');
    usersref.add({
      "numeroTel":"0"+widget.phone,
      "nom":nom,
      "prenom":prenom,
      "person":person,
      "dateNaissance":selectedDate,
      "sexe":sexe,

    });
       
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Form(
          key: formstate,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Icon(Icons.person_outline, color: AppColors.mainColor, size: 140),
                SizedBox(height: 13),
                Text(
                  "Créer votre compte",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: AppColors.mainBlacktColor),
                ),
                Text("Veuillez remplire ces champs",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor)),
                SizedBox(height: 20),
                Container(
                  child: TextFormField(
                      onSaved: (val) {
                        nom = val;
                      },
                      validator: ((value) {
                        if (value!.length > 100) {
                          return "le nom est trop long ";
                        } else if (value == "") {
                          return "ce champ est obligatoir";
                        }
                        return null;
                      }),
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_outline,size:30,color: AppColors.mainColor,),
                        labelText: "Nom",
                        labelStyle:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w800,color:AppColors.textColor),
                      )
                      ),
                ),
                Container(
                  child: TextFormField(
                      onSaved: (val) {
                        prenom = val;
                      },
                      validator: ((value) {
                        if (value!.length > 100) {
                          return "le prenom est trop long ";
                        } else if (value == "") {
                          return "ce champ est obligatoir";
                        }
                        return null;
                      }),
                       style: TextStyle(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person_outline,size:30,color: AppColors.mainColor),
                          labelText: "Prenom",
                          labelStyle:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w800,color:AppColors.textColor),
                        )),
                ),
                Text("vous êtes:", style: TextStyle(color: AppColors.mainBlacktColor,fontSize: 18),),
                Row(
                  children: [
                    Expanded(
                        child: RadioListTile(
                          
                            title: Text("père",style:TextStyle(color:AppColors.paraColor )),
                            value: "père",
                           
                            groupValue: person,
                            onChanged: (val) {
                              setState(() {
                                person = val.toString();
                               
                              });
                            })),
                    Expanded(
                        child: RadioListTile(
                           
                      title: Text("mère",style:TextStyle(color:AppColors.paraColor )),
                      value: "mère",
                   
                      groupValue: person,
                      onChanged: (val) {
                        setState(() {
                          person = val.toString();
                          
                        });
                      },
                    ))
                  ],
                ),
               Row(
                  children: [
                    Expanded(
                        child: RadioListTile(
                      title: Text("patient",style:TextStyle(color:AppColors.paraColor )),
                      value: "patient",
                     
                      groupValue: person,
                      onChanged: (val) {
                        setState(() {
                          person = val.toString();
                        
                        });
                      },
                    )),
                    Expanded(
                        child: RadioListTile(
                      title: Text("autre",style:TextStyle(color:AppColors.paraColor )),
                      value: "autre",
                     
                      groupValue: person,
                      onChanged: (val) {
                        setState(() {
                          person = val.toString();
                          
                        });
                      },
                    ))
                  ],
                ),
                Container(
                  child: TextFormField(
                     style: TextStyle(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person_outline,size:30,color: AppColors.mainColor,),
                          labelText: "N° identifiant",
                          labelStyle:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.w800,color:AppColors.textColor),
                        )),
                ),
                Container(
                   child: DateTimeField(
                     mode:DateTimeFieldPickerMode.date ,
                   
                     
              decoration: const InputDecoration(
                labelText: "Date de naissance",
                labelStyle:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w800,color: Color(0xFFccc7c5)),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.date_range_outlined,size:30, color:Color(0xFF89dad0),),
                  ),                 
              selectedDate: selectedDate,
              onDateSelected: (DateTime value) {
                setState(() {
                  selectedDate = value;
                });
                
              }),
                ),
                         Container(child: Text("Sexe",style: TextStyle(color: AppColors.mainBlacktColor,fontSize: 18))),
                 Row(
                  children: [
                    Expanded(
                        child: RadioListTile(
                      title: Text("male",style:TextStyle(color:AppColors.paraColor )),
                      value: "male",
                  
                      groupValue: sexe,
                      onChanged: (val) {
                        setState(() {
                          sexe = val.toString();
                          
                        });
                      },
                    )),
           
                    Expanded(
                        child: RadioListTile(
                      title: Text("female",style:TextStyle(color:AppColors.paraColor )),
                      value: "female",
                    
                      groupValue: sexe,
                      onChanged: (val) {
                        setState(() {
                          sexe= val.toString();
                          
                        });
                      },
                    ))
                  ],
                ),
               MaterialButton(
                   minWidth: double.infinity,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding:EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                    color: AppColors.mainColor,
                    textColor: Colors.white,
                    
                    onPressed: () async {
                      await signUp();
                    },
                    child: Text("S'inscrire")),
             
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
