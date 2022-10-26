import 'package:flutter/cupertino.dart';
import 'package:p2_flutter/utils/dimensions.dart';
import 'package:p2_flutter/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(  
      children: [ 
        Icon(icon,color: iconColor,size: Dimensions.iconSize22,),
        SizedBox(  width: 4,),
        SmallText(text:text,),
      ],
    );
  }
}

