import 'package:firebase_database_project/notifier/tutor_notifier.dart';
import 'package:firebase_database_project/screens/tutor_form.dart';
import 'package:firebase_database_project/ui/login_component.dart';
import 'package:firebase_database_project/utils/rate_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Details{
  String subject;
  bool val;

  Details(this.subject, this.val);

  @override
  String toString(){
    return '{${this.subject},{${this.val}}}';
  }
}

class FoodDetail extends StatefulWidget {

  // List<String> localStringList;
  // FoodDetail({Key key, this.localStringList}) : super(key:key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool built      = false; // checking if the map is built once
  Map<String, bool> map1; // building the Map for the first to store values
  var rate = 0;
  var priceTutor = 0;

  calculateRate(Map<String, bool> m, String category, int rate){
    var cat = category;
    m.forEach((key, value) {
      String sub = key;
      if(value==true){
        rate += CatA.Maths;
      }
    });
    return rate;
  }
  
  @override
  Widget build(BuildContext context) {

      TutorNotifier tutorNotifier = Provider.of<TutorNotifier>(context,listen: false);

      var category = tutorNotifier.currentTutor.category;

      if(!built){
        List<Details> list =[];
        tutorNotifier.currentTutor.details.forEach((element) {
          list.add(Details(element,false));
        });
        
        map1 = Map.fromIterable(list, key: (e) => e.subject, value: (e) => e.val);
        print(map1);
      }

      addStringToSF(List<String> bookmarkedList) async{
                        SharedPreferences prefs =await SharedPreferences.getInstance();
                        prefs.setStringList('bookmarkedTutor', bookmarkedList);
        }

      Future<bool> getStringValuesSF() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> stringList = prefs.getStringList('bookmarkedTutor');

        if(!stringList.contains(tutorNotifier.currentTutor.name)){
            List<String> bookmarkedList = stringList + ['${tutorNotifier.currentTutor.name}'];
            addStringToSF(bookmarkedList);
            return true;
        }else{
          return false;
        }
      
      }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Tutor Profile: ${tutorNotifier.currentTutor.name}', 
                                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                                  ),
                      ),

        body: Stack(
            children: <Widget>[
              BackgroundImageWidget(
                opacity: 0.2,
              ),
              Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Image.network(
        tutorNotifier.currentTutor.image !=null?tutorNotifier.currentTutor.image:'https://www.via.placeholder.com/150',
            ),
          ),
          SizedBox(height: 32,),
          Text(
              tutorNotifier.currentTutor.name,
              style: TextStyle(
                fontSize: 40,
              ),
          ),
          Text(
              tutorNotifier.currentTutor.category,
              style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 10,),
          ListView(
            shrinkWrap: true,
            children: map1.keys.map<Widget>((key){
              return CheckboxListTile(
                title: Text(key),
                value: map1[key], 
                onChanged: (bool value){
                  setState(() {
                    map1[key] = value;
                    built = true;
                    rate = 0;
                    priceTutor = calculateRate(map1,category, rate);
                    print(map1);
                  });
                },
                );
            }).toList(),
          ),
          Container(child: Text('Total Charges: $priceTutor',style: TextStyle(fontFamily:'Montserrat',fontWeight: FontWeight.bold,fontSize: 20),)),
          // ListView.builder(
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     // separatorBuilder: (BuildContext context,int index){
          //     //             return Divider(color: Colors.transparent,);
          //     // },
          //     itemCount: tutorNotifier.currentTutor.details.length,
          //     itemBuilder: (BuildContext context, int index){
          //       return Row(
          //         children: <Widget>[
          //           Container(
          //             margin: EdgeInsets.fromLTRB(15, 10, 10, 5),
          //             child: Text('${tutorNotifier.currentTutor.details[index]}',style: TextStyle(fontSize:20,fontFamily:'Montserrat'),)
          //             ),
          //           Checkbox(
          //             // title: Text(tutorNotifier.currentTutor.details[index]),
          //             value: notChecked, 
          //             // controlAffinity: ListTileControlAffinity.trailing,
          //             onChanged: (isChecked){
          //               setState((){
          //                 notChecked = isChecked;
          //               });
          //             },
          //             )
          //         ],
          //       );
          //     },
          //   ),


          //   GridView.count(
          //       shrinkWrap: true,
          //       scrollDirection: Axis.vertical ,
          //       padding: EdgeInsets.all(8.0),
          //       crossAxisCount: 3,
          //       crossAxisSpacing: 4,
          //       mainAxisSpacing: 4,
          //       children: tutorNotifier.currentTutor.details.map(
          // (ingredient)=>Card(
          //     color: Colors.black54,
          //     child: Center(
          //         child: Text(ingredient,
          //             style: TextStyle(color: Colors.white,fontSize: 16),
          //         ),
          //     ),
          // )
          //       ).toList(),
          //   ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
        FlatButton(   
            onPressed: () async {
              // List<String> bookmarkedList = prefs.getStringList('bookmarkedTutor').addAll(['${tutorNotifier.currentTutor.name}']);
               bool val = await getStringValuesSF();

               final successSnackBar = SnackBar(content: Text('Tutor Added to Bookmarks!',
                                  style: TextStyle(fontFamily: 'Montserrat'),)
                        );
              final failureSnackBar = SnackBar(content: Text('Tutor Already Added!',
                                  style: TextStyle(fontFamily: 'Montserrat'),)
                        );

               if( val){
               _scaffoldKey.currentState.showSnackBar(successSnackBar);
               }else{
               _scaffoldKey.currentState.showSnackBar(failureSnackBar);
               }


              //  FutureBuilder(future: val, builder: (context, snapshot) 
              //   {
              //     if (snapshot.data){
              //       _scaffoldKey.currentState.showSnackBar(successSnackBar);
              //     }else{
              
              //     }
              //   };

              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BookMarks()));
              },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Text('Bookmark',style: TextStyle(fontFamily:'Montserrat',fontSize:20,color: Colors.grey[50]),),
          color: Color(0xff8acefc),
        ),
        FlatButton( 
          onPressed: (){},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Text('Book Tutor',style: TextStyle(fontFamily:'Montserrat',fontSize:20,color: Colors.grey[50]),),
          color: Color(0xff8acefc),
        )
              ],
            ),
          )

        ],
              ),
          ),
            ],
          ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return TutorForm(
                        isUpdating: true,
                    );
                }));
            },
            child: Icon(Icons.edit),
            foregroundColor: Colors.white,
        ),
        
    );
    
  }
}
