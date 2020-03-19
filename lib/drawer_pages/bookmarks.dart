import 'package:flutter/material.dart';

class BookMarks extends StatefulWidget {
  @override
  _BookMarksState createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('No bookmarks yet!')),
    );
  }
}
