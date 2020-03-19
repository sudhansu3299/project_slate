import 'package:firebase_database_project/api/tutor_api.dart';
import 'package:firebase_database_project/drawer_pages/bookmarks.dart';
import 'package:firebase_database_project/drawer_pages/contact_us.dart';
import 'package:firebase_database_project/drawer_pages/feed_back.dart';
import 'package:firebase_database_project/notifier/auth_notifier.dart';
import 'package:firebase_database_project/notifier/tutor_notifier.dart';
import 'package:firebase_database_project/screens/detail.dart';
import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:firebase_database_project/screens/tutor_form.dart';
import 'package:firebase_database_project/ui/login_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
    //const Feed({Key key}) : super (key : key);


    @override
  void initState() {
    // TODO: implement initState
        TutorNotifier tutorNotifier = Provider.of<TutorNotifier>(context,listen: false);
        getTutors(tutorNotifier);
        super.initState();
  }
  @override
  Widget build(BuildContext context) {

      AuthNotifier authNotifier =Provider.of<AuthNotifier>(context);
      TutorNotifier tutorNotifier =Provider.of<TutorNotifier>(context);

      print('Building Feed');
      print('No of food items: ${tutorNotifier.tutorList.length}');

      return Scaffold(
          drawer: Drawer(
              elevation: 4.0,
              child: ListView(
                  children: <Widget>[
                      UserAccountsDrawerHeader(
                          accountEmail: Text(authNotifier.user.email),
                          accountName: Text('Hello'),
                          /*currentAccountPicture: GestureDetector(
                              onTap: (){
                                  if(image==null){
                                      picker();
                                  }
                              } ,
                              child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: ClipOval(
                                      child: SizedBox(
                                          width: 70.0,
                                          height: 70.0,
                                          child: (image==null)?Icon(Icons.add_a_photo):Image.file(image,fit: BoxFit.fill,),
                                      ),
                                  ),
                                  //child: image==null?Icon(Icons.add_a_photo):Image.file(image),
                              ),
                          ),*/
                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.bookmark_border),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Bookmarks',style: TextStyle(fontSize: 20.0),),
                              ],
                          ),

                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMarks()));
                          }

                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.email),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Contact Us',style: TextStyle(fontSize: 20.0),),
                              ],
                          ),

                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                          }

                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.feedback),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Feedback',style: TextStyle(fontSize: 20.0),),
                              ],
                          ),

                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBack()));
                          }

                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.lock),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Sign out',style: TextStyle(fontSize: 20.0),),
                              ],
                          ),

                          onTap: ()=>signout(authNotifier),

                      ),
                  ],
              ),
          ),
        appBar: AppBar(
            title: Text('SLATE',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Futura',color: Colors.black,fontSize: 26),),
                //authNotifier.user != null ? authNotifier.user.displayName:'Feed',

            actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: Constant.sizeXXXL*2.2,
                        height: Constant.sizeXXXL*0.8,
                    child: FlatButton(
                        splashColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        color: Colors.white,
                        onPressed: (){},
                        child: Text('F i l t e r',
                            style: TextStyle(fontSize: 20,color:Colors.black,fontFamily: 'Futura'),
                        ),
                    ),
                  ),
                )
            ],
        ),
        body: Stack(
          children: <Widget>[
              BackgroundImageWidget(
                  opacity: 0.85,
              ),
              ListView.separated(
                  itemCount: tutorNotifier.tutorList.length,
                  separatorBuilder: (BuildContext context,int index){
                      return Divider(color: Colors.transparent,);
                  },
                  itemBuilder: (BuildContext context,int index){
                      return GestureDetector(
                          onTap: (){
                              tutorNotifier.currentTutor = tutorNotifier.tutorList[index];
                              /*print('Hello ${foodNotifier.foodList[index]}');
                           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>
                                FoodDetail(index: index,)
                           ));*/
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FoodDetail()));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(80.0),
                            child: Container(
                                //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(150.0))),
                                margin: EdgeInsets.only(left: Constant.sizeLarge,right: Constant.sizeLarge,top: index==0?Constant.sizeMedium:0),
                                //width: MediaQuery.of(context).size.width*0.7,
                                height: MediaQuery.of(context).size.height*0.547,
                              child: Card
                                  (   elevation: 15.0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      child: new Stack
                                          (
                                          children: <Widget>
                                          [
                                              new SizedBox.expand
                                                  (
                                                  child: new Material
                                                      (
                                                      borderRadius: new BorderRadius.circular(12.0),
                                                      child: new Image.network( tutorNotifier.tutorList[index].image!=null?tutorNotifier.tutorList[index].image:
                                                      'https://drive.google.com/open?id=1KaMVkiMwIxMSoUHj5ysNWJMJS0_oQynq',
                                                          fit: BoxFit.cover),
                                                  ),
                                              ),
                                              new SizedBox.expand
                                                  (
                                                  child: new Container
                                                      (
                                                      decoration: new BoxDecoration
                                                          (
                                                          gradient: new LinearGradient
                                                              (
                                                              colors: [ Colors.transparent, Colors.black54 ],
                                                              begin: Alignment.center,
                                                              end: Alignment.bottomCenter
                                                          )
                                                      ),
                                                  ),
                                              ),
                                              new Align
                                                  (
                                                  alignment: Alignment.bottomLeft,
                                                  child: new Container
                                                      (
                                                      padding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                                      child: new Column
                                                          (
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>
                                                          [
                                                              new Text( tutorNotifier.tutorList[index].name, style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700)),
                                                              new Padding(padding: new EdgeInsets.only(bottom: 8.0)),
                                                              Row(
                                                                children: <Widget>[
                                                                  new Text('${tutorNotifier.tutorList[index].details}', textAlign: TextAlign.start, style: new TextStyle(color: Colors.white)),
                                                                ],
                                                              ),
                                                          ],
                                                      )
                                                  ),
                                              )
                                          ],
                                      ),

                              ),
                            ),
                          ),
                      );
                  },
              ),
          ],
        )
          /*ListView.separated(
            itemBuilder: (BuildContext context,int index){
                /*if(foodNotifier.foodList[index].name=='Salsa'){
                    print(foodNotifier.foodList[index].image);
                }*/
                print(foodNotifier.foodList[index].image);
                return ListTile(
                     leading: Image.network(
                         foodNotifier.foodList[index].image!=null?foodNotifier.foodList[index].image:'https://www.via.placeholder.com/150',
                         width: 120,
                         fit: BoxFit.fitWidth,

                     ),
                    title: Text(foodNotifier.foodList[index].name),
                    subtitle: Text(foodNotifier.foodList[index].category),
                    onTap: (){
                         foodNotifier.currentFood = foodNotifier.foodList[index];
                         /*print('Hello ${foodNotifier.foodList[index]}');
                         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>
                              FoodDetail(index: index,)
                         ));*/
                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FoodDetail()));
                    },
                );
            },
            itemCount: foodNotifier.foodList.length,
            separatorBuilder: (BuildContext context,int index){
                return Divider(color: Colors.black,);
            },
        ),*/,



          /*floatingActionButton: FloatingActionButton(
              onPressed: (){
                  tutorNotifier.currentTutor=null;
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                      return TutorForm(
                          isUpdating: false,
                      );
                  }));
              },
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
          ),*//////////// TO ADD NEW TUTORS
    );
  }
}
