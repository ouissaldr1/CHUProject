import 'package:flutter/material.dart';
import 'package:p2_flutter/utils/colors.dart';
import 'package:p2_flutter/utils/dimensions.dart';
import 'package:p2_flutter/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key,required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondtHalf;

  bool hiddenText= true;

  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState()
  {
    super.initState();
    if( widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondtHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }
    else{
    firstHalf = widget.text;
  secondtHalf = " ";

    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondtHalf.isEmpty?SmallText(color:AppColors.paraColor,size:Dimensions.font16,text: firstHalf):Column(
        children: [
          SmallText(hight:1.8,color:AppColors.paraColor,size:Dimensions.font16,text: hiddenText?(firstHalf+"..."):(firstHalf+secondtHalf)),
          InkWell(
            onTap: () {
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row( 
              children: [ 
                SmallText(text:hiddenText?"voir plus":"voir moins",color:AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color:AppColors.mainColor),
              ],
            ),
          )
        ],


      ),
    );
  }
}
