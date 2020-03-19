
import 'dart:io';

import 'package:firebase_database_project/model/tutor.dart';
import 'package:firebase_database_project/notifier/tutor_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database_project/api/tutor_api.dart';

class TutorForm extends StatefulWidget {

  final bool isUpdating;
  TutorForm({@required this.isUpdating});

  @override
  _TutorFormState createState() => _TutorFormState();
}

class _TutorFormState extends State<TutorForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _details = [];
  Tutor _currentTutor;
  String _imageUrl;
  File _imageFile;
  TextEditingController subingredrientController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    TutorNotifier tutorNotifier = Provider.of<TutorNotifier>(
        context, listen: false);

    if (tutorNotifier.currentTutor != null) {
      _currentTutor = tutorNotifier.currentTutor;
    } else {
      _currentTutor = Tutor();
    }

    _details.addAll(_currentTutor.details);
    _imageUrl = _currentTutor.image;
  }


  Widget _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text('Image Placeholder');
    } else if (_imageFile != null) {
      print('Showing image from gallery');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(_imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text('Change Image',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold
            ),),
            onPressed: ()=>_getLocalImage(),
          )
        ],
      );

    } else if (_imageUrl != null) {
      print('Showing image from url');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(_imageUrl,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text('Change Image',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold
            ),),
            onPressed: ()=>_getLocalImage(),
          )
        ],
      );
    }
  }

  _getLocalImage() async{
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 400
    );
    if(imageFile!=null){
      setState(() {
        _imageFile=imageFile;
      });
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue: _currentTutor.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is required';
        }
        if (value.length < 3 || value.length > 20) {
          return ' Name must be between 3 and 20 char';
        }
        return null;
      },
      onSaved: (String value) {
        _currentTutor.name = value;
      },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Category'),
      initialValue: _currentTutor.category,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Category is required';
        }
        if (value.length < 1 || value.length > 3) {
          return 'Category must be between 1 and 3 char';
        }
        return null;
      },
      onSaved: (String value) {
        _currentTutor.category = value;
      },
    );
  }

  Widget _buildDetailsField() {
    return SizedBox(width: 200,
      child: TextFormField(
        controller: subingredrientController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: 'Details'),
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _addDetails(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _details.add(text);
      });
      subingredrientController.clear();
    }
  }

  _saveFood(){
    print('Form saved');
      if(!_formKey.currentState.validate())
        return;
      _formKey.currentState.save();

      _currentTutor.details = _details;

      uploadTutorAndImage(_currentTutor,widget.isUpdating,_imageFile);

      print("name ${_currentTutor.name}");
      print("category ${_currentTutor.category}");
      print('_imageFile ${_imageFile.toString()}');
      print('_imageUrl ${_imageUrl}');
      print("details ${_currentTutor.details.toString()}");
  }


  @override
  Widget build(BuildContext context) {
      print('Coming to tutor-form');
    return Scaffold(
        appBar: AppBar(title: Text('Food Form'),),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  _showImage(),
                  SizedBox(height: 16,),
                  Text(
                    widget.isUpdating?'Edit Food':'Create Food',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 16,),
                  _imageFile==null && _imageUrl==null?
                  ButtonTheme(
                    child: RaisedButton(
                      onPressed: ()=>_getLocalImage(),
                      child: Text('Add Image',
                        style: TextStyle(color: Colors.white),

                      ),
                    ),
                  ): SizedBox(height: 0,),
                  _buildNameField(),
                  _buildCategoryField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildDetailsField(),
                      ButtonTheme(
                        child: RaisedButton(
                          onPressed: () =>
                              _addDetails(subingredrientController.text),
                          child: Text(
                            'Add', style: TextStyle(color: Colors.white),),),)
                    ],
                  ),
                  SizedBox(height: 16,),
                  GridView.count(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(8.0),
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    children: _details.map(
                            (ingredient) =>
                            Card(
                              color: Colors.black54,
                              child: Center(
                                child: Text(ingredient,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            )
                    ).toList(),
                  )
                ],
              )
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _saveFood(),
        child: Icon(Icons.save),
        foregroundColor: Colors.white,
      ),
    );
  }
}
