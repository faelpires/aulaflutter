import 'package:flutter/material.dart';
import 'package:aula3/like_button.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LikeButton(Icons.favorite, 'Gostei'),
    );
  }
}
