import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'myData.dart';

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
    List<MyData> allData=[];

    @override
  void initState() {
    // TODO: implement initState
    DatabaseReference ref= FirebaseDatabase.instance.reference();
    ref.child('node-name').once().then((DataSnapshot snap){
        var keys =snap.value.keys;
        var data =snap.value;
        allData.clear();
        for(var key in keys){
            MyData d= new MyData(
                data[key]['name'],
                data[key]['message'],
                data[key]['profession']
            );
            allData.add(d);
            setState(() {
              print('Length : ${allData.length} ');
            });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
                    title: Text('Firebase Data')),
        body: new Container(
            child: allData.length==0 ? Text('No Data'):
             ListView.builder(
                itemCount: allData.length,
                itemBuilder: (_, index) {
                return UI(
                    allData[index].name,
                    allData[index].profession,
                    allData[index].message);
                },
            )),
        );
  }

  Widget UI(String name,String profession,String message){
        return new Card(
            child: new Container(
                child: new Column(
                    children: <Widget>[
                        Text('Name: $name'),
                        Text('Profession: $profession'),
                        Text('Message: $message'),
                    ],
                ),
            ),
        );
  }
}
