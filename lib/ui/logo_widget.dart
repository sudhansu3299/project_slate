import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  final double size;
  final String image;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const AppLogoWidget({Key key, this.margin, this.padding, this.size, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Text('Slate'),
      child: Container(
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? Constant.spacingAllSmall,
        child: Image(
          image: AssetImage(image ?? 'assets/images/logo.png'),
          height: size ?? Constant.defaultImageHeight,
          width: size ?? Constant.defaultImageHeight,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

