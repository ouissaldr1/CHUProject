import 'package:flutter/cupertino.dart';


class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backroundColor;
  final double size;
  final double iconSize;
  AppIcon({Key? key,
  required this.icon,
    this.iconColor=const Color(0xFF756d54),
    this.backroundColor=const Color(0xFFfcf4e4),
     this.size=40,
    this.iconSize=16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backroundColor,
      ),
      child: Icon( icon,
        color: iconColor,
        size: iconSize,

      ),
    );
  }
}
