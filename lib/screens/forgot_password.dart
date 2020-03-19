import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

    String _email,_warning="";

    final _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Forgot Password'),
        ),
        body: Form(
            key: _formKey,
          child: ListView(
              children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:Constant.screenWidthTenth,right: Constant.screenWidthTenth),
                    child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email',
                        ),
                        onSaved: (value){
                            _email= value;
                        },
                    ),
                  ),
                  Container(
                    height: Constant.sizeMedium,
                  ),
                  Center(
                      child: RaisedButton(
                          color: Colors.blue,
                          child: Text('Submit',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          onPressed: (){
                              forgot();
                          },
                      ),
                  )
              ],
          ),
        ),
    );
  }

  Future<void> forgot() async{

      _formKey.currentState.save();
      try{

          await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
          setState(() {
              print('link sent to mail');
              _warning = "A password reset link has been sent to $_email";
              alert();
          });
      }catch(e){
          print(e.message);
      }

  }

  Widget alert(){
      print('alert is working!');
      //if(_warning!=null){
          return Scaffold(
            body: Container(
              color: Colors.amber,
              width: double.infinity,
              padding: EdgeInsets.all(8.0),
                child: Row(
                    children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.error_outline),
                        ),
                        Expanded(
                            child: AutoSizeText(
                                _warning,
                                maxLines: 3,
                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                    setState(() {
                                        _warning = null;
                                    });
                                },
                            ),
                        )
                    ],
                ),
            ),
          );
      //}
      return SizedBox(
          height: 0,
      );
  }
}
