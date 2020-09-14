import 'package:aula5/app/shared/widgets/center_body_content.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CenterBodyContent(
      children: [
        CircularProgressIndicator(),
      ],
    );
  }
}
