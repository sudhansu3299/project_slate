import 'package:firebase_database_project/notifier/tutor_notifier.dart';
import 'package:firebase_database_project/screens/feed.dart';
import 'package:firebase_database_project/screens/tutor_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodDetail extends StatelessWidget {

   /*final int  index;
   FoodDetail({Key key,this.index}):super(key:key);*/

  @override
  Widget build(BuildContext context) {

      TutorNotifier foodNotifier = Provider.of<TutorNotifier>(context,listen: false);

      //print('Detail ${foodNotifier.currentFood.name}');
    return Scaffold(

        appBar: AppBar(title: Text(foodNotifier.currentTutor.name),),

        body: Center(
            child: Container(

                child: Column(
                    children: <Widget>[
                        Expanded(
                          child: Image.network(
                              foodNotifier.currentTutor.image !=null?foodNotifier.currentTutor.image:'https://www.via.placeholder.com/150',
                          ),
                        ),
                        SizedBox(height: 32,),
                        Text(
                            foodNotifier.currentTutor.name,
                            style: TextStyle(
                                fontSize: 40,
                            ),
                        ),
                        Text(
                            foodNotifier.currentTutor.category,
                            style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 16,),
                        GridView.count(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical ,
                            padding: EdgeInsets.all(8.0),
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            children: foodNotifier.currentTutor.details.map(
                                (ingredient)=>Card(
                                    color: Colors.black54,
                                    child: Center(
                                        child: Text(ingredient,
                                            style: TextStyle(color: Colors.white,fontSize: 16),
                                        ),
                                    ),
                                )
                            ).toList(),
                        )

                    ],
                ),
            ),
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
