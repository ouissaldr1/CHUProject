import 'package:flutter/cupertino.dart';
import 'package:p2_flutter/utils/dimensions.dart';

class BigText extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
   BigText({Key? key,this.color = const Color(0xFF332d2b),
    required this.text,
    this.size=0,// in the first it was size=20
    this.overFlow = TextOverflow.ellipsis
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color:color,
        fontSize: size==0?Dimensions.font20:size,// changed ...
        fontWeight: FontWeight.w400,
      ),

    );
  }

}

