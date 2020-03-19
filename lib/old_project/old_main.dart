import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_project/old_project/ImagesScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database_project/old_project/showDataPage.dart';
import 'package:firebase_database_project/old_project/showImage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: ShowImage(),
            // ImageScreen(),
            //MyHomePage(title: 'FireBase Database'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    GlobalKey <FormState> _key= new GlobalKey();
    bool autoValidate =false;

    String name, profession, message;
    List<DropdownMenuItem<String>> items =[
        new DropdownMenuItem(
            child: Text('Student'),
            value: 'Student',
        ),
        new DropdownMenuItem(
            child: Text('Professor'),
            value: 'Professor',
        ),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),
            body: SingleChildScrollView(
                child: Container(
                    child: Form(
                        key: _key,
                        autovalidate: autoValidate,
                        child: formUI()
                    ),
                ),
            )
        );
    }

    Widget formUI(){
        return Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    new Row(
                        children: <Widget>[
                            Flexible(
                                child: new TextFormField(
                                    decoration: new InputDecoration(hintText: 'Name'),
                                    onSaved: (val){
                                        name=val;
                                    },
                                    validator: validateName,
                                    maxLength: 32,
                                ),
                            ),
                            new SizedBox(
                                height: 10.0,
                            ),
                            DropdownButtonHideUnderline(
                                child: new DropdownButton(
                                    items: items,
                                    hint: Text('Profession'),
                                    value: profession,
                                    onChanged: (String val){
                                        setState(() {
                                            profession=val;
                                        });
                                    }
                                ),
                            ),
                        ],
                    ),

                    new TextFormField(
                        decoration: new InputDecoration(hintText: 'Message'),
                        onSaved: (val){
                            message=val;
                        },
                        validator: validateMessage,
                        maxLines: 5,
                        maxLength: 256,
                    ),
                    new RaisedButton(onPressed: _sendToServer,child: Text('Send'),),
                    new RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowDataPage())); },
                        child: Text('Show Data'),)

                ],
            ),
        );
    }

    _sendToServer(){
        if(_key.currentState.validate()){
            _key.currentState.save();
            DatabaseReference ref = FirebaseDatabase.instance.reference();
            var data={
                "name":name,
                "profession":profession,
                "message": message,
            };
            ref.child('node-name').push().set(data).then((v){
                _key.currentState.reset();
            });
            /* ref.child('node-name').child(path).push().set(data).then((v){
        _key.currentState.reset(); // Node inside a node in the firebase database.
      }); */
        }else{
            setState(() {
                autoValidate =true;
            });
        }
    }

    String validateMessage(String val){
        return val.length==0 ? "Enter message first" : null;
    }
    String validateName(String val){
        return val.length==0 ? "Enter name first" :null;
    }

}
