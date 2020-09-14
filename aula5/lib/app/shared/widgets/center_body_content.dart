import 'package:flutter/material.dart';

class CenterBodyContent extends StatelessWidget {
  final List<Widget> children;

  const CenterBodyContent({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
