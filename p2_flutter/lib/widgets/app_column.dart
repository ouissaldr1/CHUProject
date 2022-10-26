// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:p2_flutter/utils/colors.dart';
import 'package:p2_flutter/utils/dimensions.dart';
import 'package:p2_flutter/widgets/small_text.dart';

import 'big_text.dart';
import 'icon_and_text_widget.dart';


class AppColumn extends StatelessWidget {
  final String text;
  final String date;
  final String heure;
  final String lien;
  const AppColumn({Key? key,required this.text,required this.date,required this.heure, required this.lien}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height:Dimensions.height5,
        ),
        Row(
          children: [
            Wrap (
              children: List.generate(1, (index) {
                return Icon(Icons.video_call_rounded, color:AppColors.mainColor , size:22, );}),

            ),
            SizedBox(width: 10,),
            GestureDetector(
//   onTap: () async{
    
    
  
//   if (await canLaunch(lien)) {
//     await launch(lien);
//   } else {
//     throw 'Could not launch $lien';
  
// }
//   },
  child: SmallText(text: "sujet"),
),
            
  

           
            
          ],
        ),
        SizedBox(height:Dimensions.height5
        ),
        Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            IconAndTextWidget(icon: Icons.date_range,
                text: date,
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.access_time_sharp,
                text: heure,
                iconColor: AppColors.iconColor2),

          ], ),


      ],
    );
  }
}
