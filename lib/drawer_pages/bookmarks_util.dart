import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//NOT USED YET!!!!!!!!!!!!!

class BookMarksUtil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
  Future<List<String>> getStringValuesSF() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList('bookmarkedTutor');
    
    print(stringList);
    return stringList;
  }
}
