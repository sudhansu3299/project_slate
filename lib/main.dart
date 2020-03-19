
import 'package:firebase_database_project/notifier/auth_notifier.dart';
import 'package:firebase_database_project/notifier/tutor_notifier.dart';
import 'package:firebase_database_project/screens/feed.dart';
import 'package:firebase_database_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()=>runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(
            builder:(context)=>AuthNotifier()),
          ChangeNotifierProvider(
              builder:(context)=>TutorNotifier())

      ],
      child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue
      ),
      home: Consumer<AuthNotifier>(
          builder: (context,notifier,child){
            return notifier.user!=null ? Feed() : Login();
          }
      ),
    );
  }
}
