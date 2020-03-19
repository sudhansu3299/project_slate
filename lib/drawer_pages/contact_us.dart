import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Contact Us'),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.only(left: Constant.sizeMedium,top: Constant.sizeMedium),
                child: Text('TIIR Building',style: TextStyle(fontWeight: FontWeight.bold),)),
        )
    );
  }
}
