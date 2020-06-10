import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Settings'),
        ),
        body: Center(
          child: Column(
                  children: <Widget>[
                      const SizedBox(height: 20),
                      button("Change Display Name",1),
                      const SizedBox(height: 20),
                      button("Change Password",2),
                      const SizedBox(height: 20),
                      button("Change Profile Pic",3),
                      const SizedBox(height: 20),
                  ],
          ),
        ),
    );
  }

  Widget button(String btnText,int id){
      return RaisedButton.icon(
              onPressed: () {},
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: id == 4?Colors.red:Colors.white10,
              padding: const EdgeInsets.all(6.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      '${btnText}',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              icon: selectIcon(id),
//          child: Container(
//              decoration: const BoxDecoration(
//                  gradient: LinearGradient(
//                      colors: <Color>[
//                          Color(0xFF1976D2),
//                          Color(0xFF42A5F5),
//                      ],
//                  ),
//              ),
//              padding: const EdgeInsets.all(10.0),
//              child: Text(
//                  '${btnText}',
//                  style: TextStyle(fontSize: 20)
//              ),
//          ),
          );
  }

  Widget selectIcon(int id){
      if(id == 1)
      return Icon(Icons.face);
      if(id == 2)
          return Icon(Icons.lock);
      if(id == 3)
          return Icon(Icons.image);
  }
}
