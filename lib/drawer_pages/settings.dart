import 'package:firebase_database_project/messaging/message_widget.dart';
import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:firebase_database_project/ui/login_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Settings'),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundImageWidget(
              opacity: 0.2,
            ),
            Padding(
              padding: EdgeInsets.only(left: Constant.sizeSmall,top: Constant.sizeMedium),
              child: Column(
                children: <Widget>[
                  button('Change Profile Picture', 1,context),
                  button('Change Password', 2, context),
                  button('Notifications', 3, context),
                  button('Invite Friend', 4, context)
                ]
              )
            )
          ]
        )
    );
  }

  Widget button(String btnText,int id,BuildContext context){
      return  GestureDetector(
              onTap: (){_launchButton(id, context);} ,
              child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff8acefc),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 10,10,10),
                      
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin:  EdgeInsets.fromLTRB(10, 10,10,10),
                            child: Icon(selectIcon(id),color: Colors.grey[50], size: 30,)),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          ),
                          // VerticalDivider(color: Colors.black,thickness: 5,width: 20,indent: 10,endIndent: 10,),
                          Container(
                            height: 30,
                            decoration: BoxDecoration(border: Border(left: BorderSide(color:Colors.grey[50],width:1)))
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('$btnText',style: TextStyle(fontFamily: 'Montserrat',fontSize: 21,fontWeight: FontWeight.w500),)                            
                                ],
                              )
                            ),
                        ],
                      ),
                    ),
      );//Container
  }

  IconData selectIcon(int id){
      if(id == 1)
      return (Icons.face);
      if(id == 2)
          return (Icons.lock);
      if(id == 3)
          return (Icons.notifications);
      if(id==4)
          return (Icons.group_add);
  }

  _launchButton(int id, BuildContext context){
    if(id == 3){
      // print('hello');
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MessagePage()));
    }
    if(id == 4){
    Share.share('check out my study website https://slate.com');
    }
  }
}
