import 'dart:io';

import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class MyProfile extends StatefulWidget {
    static const String routeName= '/myprofile';

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
    File image;

  @override
  Widget build(BuildContext context) {
      Future getImage() async{
          //print('Picker is called');
          File img=await ImagePicker.pickImage(source: ImageSource.gallery);
          //print(img.path);
          if(img!=null){
              setState(() {
                  // Called to update the UI when we select the image.
                  image=img;
              });
          }

      }

      Future uploadImage(BuildContext context) async{
          String file_name= basename(image.path);
          StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(file_name);
          StorageUploadTask uploadTask =firebaseStorageRef.putFile(image);
          StorageTaskSnapshot taskSnapshot =await uploadTask.onComplete;
          setState(() {
              print('Profile Pic updated!');
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile pic updated'),));
          });

      }
    return Scaffold(
        appBar: AppBar(
            title: Text('Profile Info'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                    Navigator.pop(context);
                }),
        ),
        body: Builder(
            builder: (context)=>Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        SizedBox(height: 20.0,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                        radius: Constant.screenWidthThird,
                                        backgroundColor: Colors.blue,
                                        child: ClipOval(
                                            child: SizedBox(
                                                width:  200.0,
                                                height: 200.0,
                                                child: (image!=null)?Image.file(image,fit: BoxFit.fill,):Icon(Icons.add_a_photo)
                                            ),
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top:60.0),
                                    child: IconButton(
                                        icon: Icon(Icons.camera),
                                        onPressed: (){
                                            getImage();
                                        }),
                                )
                            ],
                        ),
                        SizedBox(
                            height: 20.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        child: Column(
                                            children: <Widget>[
                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text('Username',
                                                    style: TextStyle(
                                                        color: Colors.blueGrey,fontSize: 18.0
                                                    ),),
                                                ),
                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text('Sudhansu',
                                                        style: TextStyle(
                                                            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
                                                        ),),
                                                ),

                                            ],
                                        ),
                                    ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                          child: Icon(Icons.mode_edit,color: Colors.blue,),

                                      ),
                                  ),
                                ),
                                SizedBox(
                                    height: 20.0,
                                ),
                            ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        child: Column(
                                            children: <Widget>[
                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text('Username',
                                                        style: TextStyle(
                                                            color: Colors.blueGrey,fontSize: 18.0
                                                        ),),
                                                ),
                                                Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text('Sudhansu',
                                                        style: TextStyle(
                                                            color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
                                                        ),),
                                                ),

                                            ],
                                        ),
                                    ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                            child: Icon(Icons.mode_edit,color: Colors.blue,),

                                        ),
                                    ),
                                ),
                                SizedBox(
                                    height: Constant.screenWidthSixth,
                                ),
                            ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                                RaisedButton(
                                    color: Colors.blue,
                                    onPressed: (){
                                        uploadImage(context);
                                    },
                                    elevation: 4.0,
                                    child: Text('Submit',
                                        style: TextStyle(color: Colors.white,fontSize: 16.0),
                                    ),
                                )
                            ],
                        )
                    ],
                ),
            )
        ),

    );
  }
}
