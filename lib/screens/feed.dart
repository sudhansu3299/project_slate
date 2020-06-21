import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database_project/api/tutor_api.dart';
import 'package:firebase_database_project/drawer_pages/bookmarks.dart';
import 'package:firebase_database_project/drawer_pages/bookmarks_util.dart';
import 'package:firebase_database_project/drawer_pages/contact_us.dart';
import 'package:firebase_database_project/drawer_pages/feed_back.dart';
import 'package:firebase_database_project/drawer_pages/settings.dart';
import 'package:firebase_database_project/model/tutor.dart';
import 'package:firebase_database_project/notifier/auth_notifier.dart';
import 'package:firebase_database_project/notifier/tutor_notifier.dart';
import 'package:firebase_database_project/screens/detail.dart';
import 'package:firebase_database_project/screens/filter_util.dart';
import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:firebase_database_project/screens/tutor_form.dart';
import 'package:firebase_database_project/ui/login_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filter_list/filter_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
    //const Feed({Key key}) : super (key : key);

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();


    Future _refresh() async{
      setState(() {
        build(context);
        print('refreshed');
      });
  }
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

      Future<List<String>> getStringValuesSF() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> stringList = prefs.getStringList('bookmarkedTutor');
        
        return stringList;
      }

      List<String> filterElements = [
          "A",
          "B",
          "C",
          "ICSE",
          "CBSE",
          "Maths",
          "Science",
          "English"
      ];

      List<String> selectedList =[];

      void _openFilterList() async {
          var list = await FilterList.showFilterList(
              context,
              allTextList: filterElements,
              height: 450,
              borderRadius: 20,
              headlineText: "Select Topic/Board",
              searchFieldHintText: "Search Here",
              selectedTextList: selectedList,
          );

          if (list != null) {
              setState(() {
                print(list);

                FilterUtil()
                  .getFilterSearch(list)
                  .then((QuerySnapshot docs){
                    if(docs.documents.isNotEmpty){
                        for(var i in docs.documents){
                          print(i.data["name"]);
                          print(i.data["details"]);
                        }

                        List<Tutor> _tutorList = [];
                        docs.documents.forEach((document){
                        Tutor tutor =Tutor.fromMap(document.data);
                        _tutorList.add(tutor);
                        });

                      tutorNotifier.tutorList = _tutorList;
                    }
                    
                  });
                // selectedList = List.from(list);
              });
          }
      }

      return Scaffold(
          drawer: Drawer(
              elevation: 8.0,
              child: ListView(
                  children: <Widget>[
                      UserAccountsDrawerHeader(
                          accountEmail: Text(authNotifier.user.email),
                          accountName: Text('Hello'),
                          currentAccountPicture: GestureDetector(
                              onTap: (){
                                  // if(image==null){
                                  //     picker();
                                  // }
                              } ,
                              child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: ClipOval(
                                      child: SizedBox(
                                          width: 70.0,
                                          height: 70.0,
                                          // child: (image==null)?Icon(Icons.add_a_photo):Image.file(image,fit: BoxFit.fill,),
                                      ),
                                  ),
                                  //child: image==null?Icon(Icons.add_a_photo):Image.file(image),
                              ),
                          ),
                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.bookmark_border,color: Colors.blue,),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Bookmarks',style: TextStyle(fontSize: 20.0,fontFamily: 'Montserrat'),),
                              ],
                          ),

                          onTap: () async{
                              List<String> bookmarkList = await getStringValuesSF();

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMarks(localStringList: bookmarkList,)));
                          }

                      ),
                      Divider(
                        color: Colors.grey[500],
                        height: 8,
                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.email,color: Colors.blue),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Contact Us',style: TextStyle(fontSize: 20.0,fontFamily: 'Montserrat'),),
                              ],
                          ),

                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
                          }

                      ),
                      Divider(
                        color: Colors.grey[500],
                        height: 8,
                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.feedback,color: Colors.blue),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Feedback',style: TextStyle(fontSize: 20.0,fontFamily: 'Montserrat'),),
                              ],
                          ),

                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBack()));
                          }

                      ),
                      Divider(
                        color: Colors.grey[500],
                        height: 8,
                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.lock,color: Colors.blue),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Sign out',style: TextStyle(fontSize: 20.0,fontFamily: 'Montserrat'),),
                              ],
                          ),

                          onTap: ()=>signout(authNotifier),

                      ),
                      Divider(
                        color: Colors.grey[500],
                        height: 8,
                      ),
                      ListTile(
                          title: Row(
                              children: <Widget>[
                                  Icon(Icons.settings,color: Colors.blue),
                                  Padding(padding: EdgeInsets.only(left:Constant.sizeSmall)),
                                  Text('Settings',style: TextStyle(fontSize: 20.0,fontFamily: 'Montserrat'),),
                              ],
                          ),

                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
                          }

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
                        onPressed: _openFilterList,
                        child: Text('Filter',
                            style: TextStyle(fontSize: 20,color:Colors.black,fontFamily: 'Montserrat'),
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
              RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _refresh,
                    child: Scrollbar(
                      child: ListView.separated(
                      itemCount: tutorNotifier.tutorList.length,
                      separatorBuilder: (BuildContext context,int index){
                          return Divider(color: Colors.transparent,);
                      },
                      itemBuilder: (BuildContext context,int index){
                        //storing in detailsList the details of tutor
                        String detailsList = "" ;
                        int detailsLength = tutorNotifier.tutorList.length;
                        tutorNotifier.tutorList[index].details.forEach((element) {
                          detailsList += element;
                          detailsList += " ";
                         });
                        
                          return GestureDetector(
                              onTap: (){
                                  tutorNotifier.currentTutor = tutorNotifier.tutorList[index];
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FoodDetail()));
                              },
                                child: Container(
                                    width: MediaQuery.of(context).size.width*0.75,
                                    padding:EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                                    height: MediaQuery.of(context).size.height*0.547,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(width: 0.0),
                                      boxShadow: [
                                          BoxShadow(
                                              color: Colors.black45,
                                              blurRadius: 3.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(8.0, 3.0)
                                          ),
                                      ],
                                  ),
                                  child: Card
                                      (   elevation: 15.0,
                                          clipBehavior: Clip.hardEdge,
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
                                                          child: new Image.network( tutorNotifier.tutorList[index].image!=null?tutorNotifier.tutorList[index].image :
                                                                'https://firebasestorage.googleapis.com/v0/b/fir-database-34067.appspot.com/o/tutors%2Fimages%2Fimage_1.jpg?alt=media&token=76626647-ebbf-4aff-9aa6-c6ce263d8478',
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
                                                                  new Text( tutorNotifier.tutorList[index].name, style: new TextStyle(fontFamily: 'Montserrat',color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700)),
                                                                  new Padding(padding: new EdgeInsets.only(bottom: 8.0)),
                                                                  Row(
                                                                    children: <Widget>[
                                                                      new Text('$detailsList', textAlign: TextAlign.start, style: new TextStyle(fontFamily: 'Montserrat',color: Colors.white)),
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
                              //),
                          );
                      },
                ),
                    ),
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
