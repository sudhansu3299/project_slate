import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const fbUrl = 'https://www.facebook.com/SLATE-112226980297362';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Contact Us'),
        ),
        body: Padding(
            padding: EdgeInsets.only(left: Constant.sizeMedium,top: Constant.sizeMedium),
            child: Column(
              children: <Widget>[
                Container(child: Text('TIIR Building',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),)),
                Row(
                  children: <Widget>[
                    Icon(Icons.phone,color: Colors.red[200],),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: Text('Phone no: +91 7906449644',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                      ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.mail,color: Colors.red[200],),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: Text('Mail Id: slatepvtltd@gmail.com',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                      ),
                  ],
                ),
                Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                      child: Text('Follow us:',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),)
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(icon: FaIcon(FontAwesomeIcons.facebookSquare,color: Colors.blue,),onPressed: ()=>_launchFBUrl(fbUrl),iconSize: 50, ),
                    IconButton(icon: FaIcon(FontAwesomeIcons.instagramSquare,color: Colors.purple,),onPressed: (){},iconSize: 50 ),
                    IconButton(icon: FaIcon(FontAwesomeIcons.twitterSquare,color: Colors.blue[300],),onPressed: (){},iconSize: 50, ),
                ],)
              ],
            ))
    );
  }
}

_launchFBUrl(String urlString) async{
    var url = urlString;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could Not launch $url';
    }
  }
