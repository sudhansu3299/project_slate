import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:firebase_database_project/ui/login_component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const fbUrl = 'https://www.facebook.com/SLATE-112226980297362';
const twitterUrl = '';
const linkedInUrl = '';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Contact Us',style: TextStyle(fontSize: 25),),
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
                  // Container(child: Text('TIIR Building',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),)),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff8acefc),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 10,10,10),
                    
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin:  EdgeInsets.fromLTRB(10, 10,10,10),
                          child: Icon(Icons.location_on,color: Colors.grey[50], size: 40,)),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        ),
                        // VerticalDivider(color: Colors.black,thickness: 5,width: 20,indent: 10,endIndent: 10,),
                        Container(
                          height: 65,
                          decoration: BoxDecoration(border: Border(left: BorderSide(color:Colors.grey[50],width:1)))
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('105, TIIR Building',style: TextStyle(fontFamily: 'Montserrat',fontSize: 21,fontWeight: FontWeight.w500),),
                              Text('National Institute Of Technology',style: TextStyle(fontFamily: 'Montserrat',fontSize: 15,fontWeight: FontWeight.w400),),
                              Text('Rourkela, Sundargarh, Odisha',style: TextStyle(fontFamily: 'Montserrat',fontSize: 15,fontWeight: FontWeight.w400),),
                              Text('769005',style: TextStyle(fontFamily: 'Montserrat',fontSize: 15,fontWeight: FontWeight.w400,),),
                            ],
                          )
                          ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff8acefc),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 10,10,10),
                    
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin:  EdgeInsets.fromLTRB(10, 10,10,10),
                          child: Icon(Icons.phone,color: Colors.grey[50],size: 40,),
                          ),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        ),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(border: Border(left: BorderSide(color:Colors.grey[50],width:1)))
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: Column(
                            children: <Widget>[
                              Text('+91 7906449644',style: TextStyle(fontFamily: 'Montserrat',fontSize: 20,fontWeight: FontWeight.w500),),
                            ],
                          )
                          ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff8acefc),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 10,10,10),
                    
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10,10,10),
                          child: Icon(Icons.mail,color: Colors.grey[50],size: 40,)),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        ),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(border: Border(left: BorderSide(color:Colors.grey[50],width:1)))
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                          child: Text('slatepvtltd@gmail.com',style: TextStyle(fontFamily: 'Montserrat',fontSize: 20,fontWeight: FontWeight.w500),)
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height)/5,
                  ),
                  Container(
                        margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
                        child: Text('Follow us:',style: TextStyle(fontFamily: 'Montserrat',fontSize: 23,fontWeight: FontWeight.w700),)
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(icon: FaIcon(FontAwesomeIcons.facebookSquare,color: Color.fromARGB(255, 59, 89, 152),),onPressed: ()=>_launchFBUrl(fbUrl),iconSize: 40, ),
                      IconButton(icon: FaIcon(FontAwesomeIcons.linkedin,color: Color.fromARGB(255, 14, 118, 168),),onPressed: (){},iconSize: 40 ),
                      IconButton(icon: FaIcon(FontAwesomeIcons.twitterSquare,color: Color.fromARGB(255, 0, 172, 238),),onPressed: (){},iconSize: 40, ),
                  ],)
                ],
              )),
          ],
        )
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
