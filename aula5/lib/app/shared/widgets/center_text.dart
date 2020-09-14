import 'package:aula5/app/shared/widgets/center_body_content.dart';
import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;
  final Widget action;
  CenterText(
    this.text, {
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return CenterBodyContent(
      children: [
        Text(
          text,
        ),
        action ?? Container()
      ],
    );
  }
}
