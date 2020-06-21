import 'package:firebase_database_project/model/tutor.dart';
import 'package:firebase_database_project/ui/login_component.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BookMarks extends StatefulWidget {

  List<String> localStringList;
  BookMarks({Key key, this.localStringList}) : super(key:key);

  @override
  _BookMarksState createState() => _BookMarksState();

}

class _BookMarksState extends State<BookMarks> {

  Future<bool> deleteBookmark(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getStringList('bookmarkedTutor').removeAt(index);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.localStringList);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks',style: TextStyle(fontFamily:'Montserrat',fontSize: 23),)
      ),
        body: Stack(
                  children: <Widget>[
                    BackgroundImageWidget(
                        opacity: 0.2,
                    ),
                    ListView.separated(
                      itemCount: widget.localStringList.length,
                      separatorBuilder: (BuildContext context,int index){
                          return Divider(color: Colors.transparent,);
                      },
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xff8acefc),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text('${widget.localStringList[index]}',style: TextStyle(fontFamily:'Montserrat',fontSize: 20,fontWeight: FontWeight.w400),),
                              ),
                              IconButton(
                                onPressed: () async{
                                  bool isDeleted = await deleteBookmark(index);
                                  if(isDeleted){
                                    print('Hello');
                                    setState(() {
                                    
                                    });
                                  }
                                  // prefs.remove('bookmarkedTutor');
                                  // widget.localStringList.removeAt(index);
                                  // print(widget.localStringList);
                                },
                                icon: Icon(Icons.delete,)
                                )
                            ],
                          ),
                        );
                      }
                    )
                  ],
        )
      );
  }
}
