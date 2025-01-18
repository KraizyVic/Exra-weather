import 'package:exraweather/constants.dart';
import 'package:flutter/material.dart';

class NamedWithTrailingIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final IconData iconData;
  const NamedWithTrailingIconButton({
      super.key,
      required this.onPressed,
      required this.buttonName,
      required this.iconData,
    });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Text(buttonName,style: TextStyle(color: tertiaryColor),),
          Icon(iconData,color: tertiaryColor,),
        ],
      ),
    );
  }
}
