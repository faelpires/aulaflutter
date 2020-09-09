import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final IconData iconData;
  final String text;

  LikeButton(this.iconData, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData),
          Text(text),
        ],
      ),
    );
  }
}
