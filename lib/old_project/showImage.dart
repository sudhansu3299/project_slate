import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class ShowImage extends StatefulWidget {
  @override
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Images')),
        body: Center(
            child: Column(
                children: <Widget>[

                ],
            ),
        ),
    );
  }
}
