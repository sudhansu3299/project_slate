import 'package:firebase_database_project/api/tutor_api.dart';
import 'package:firebase_database_project/model/user.dart';
import 'package:firebase_database_project/notifier/auth_notifier.dart';
import 'package:firebase_database_project/screens/forgot_password.dart';
import 'package:firebase_database_project/screens/screen_util.dart';
import 'package:firebase_database_project/ui/login_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode{Signup, Login}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

    final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
    final TextEditingController _passwordController =new TextEditingController();
    AuthMode _authMode =AuthMode.Login;

    User _user = User();

    bool _obscureText =true;
    void _toggle() {
        // To toggle the visibility of password field
        setState(() {
            _obscureText = !_obscureText;
        });
    }

    @override
  void initState() {
    // TODO: implement initState
        AuthNotifier authNotifier =Provider.of<AuthNotifier>(context,listen: false);
        initializeCurrentUser(authNotifier);
    super.initState();
  }

    void _submitForm(){
        if(!_formKey.currentState.validate()){
            return;
        }

        _formKey.currentState.save();

        AuthNotifier authNotifier =Provider.of<AuthNotifier>(context,listen: false);

        if(_authMode== AuthMode.Login){
            //Login
            login(_user, authNotifier);
        }else{
            //Sign up
            signup(_user, authNotifier);
        }
    }

    Widget _buildDisplayNameField(){
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: Constant.sizeExtraSmall
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.green
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
          child: TextFormField(
              decoration: InputDecoration(labelText: 'Display Name',
              icon: Icon(Icons.face)
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 26),
              validator: (String value){
                  if(value.isEmpty){
                      return 'Display Name is required';
                  }
                  if(value.length<5 || value. length>12){
                      return 'Display name must be between 5 and 12 characters';
                  }
                  return null;
              },
              onSaved: (String value){
                  _user.displayName=value;
              },
          ),
        );
    }
    Widget _buildEmailField(){
        return Column(
          children: <Widget>[
              Container(
                  height: Constant.sizeXL,
              ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Constant.sizeExtraSmall
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.green
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.mail_outline),
                      hintText: 'type your mail-id',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic,
                          fontSize: 13.0,
                          color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: 'test@slate.com',
                  style: TextStyle(fontSize: 26),
                  validator: (String value){
                      if (!RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)){
                          return "This is not a valid email";
                      }


                  },
                  onSaved: (String value){
                      _user.email=value;
                  },
              ),
            ),
          ],
        );
    }

    Widget _buildPasswordField(){
            return Column(
              children: <Widget>[
                  Container(
                      height: Constant.sizeXL,
                  ),
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constant.sizeExtraSmall
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.green
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(
                                _obscureText ? Icons.visibility:Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: (){
                                _toggle();
                            },
                        ),
                        labelText: 'Password',
                        hintText: 'type your password',
                        hintStyle: TextStyle(fontStyle: FontStyle.italic,
                            fontSize: 13.0,
                            color: Colors.grey),
                    ),
                    style: TextStyle(fontSize: 26),
                    obscureText: _obscureText,
                    controller: _passwordController,
                    validator: (String value){
                        if(value.isEmpty){
                            return 'Password is required';
                        }
                        if(value.length<5 || value.length>20){
                            return 'Password must be between 5 and 20 characters';
                        }
                        return null;
                    },
                    onSaved: (String value){
                        _user.password =value;
                    },
                  ),
                ),
              ],
            );
    }

    Widget _buildConfirmPasswordField(){
            return Column(
              children: <Widget>[
                  Container(
                      height: Constant.sizeXL,
                  ),
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Constant.sizeExtraSmall
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.green
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                  child: TextFormField(
                      decoration: InputDecoration(labelText: 'Confirm Password',
                      icon: Icon(Icons.lock_open)
                      ),
                      style: TextStyle(fontSize: 26),
                      obscureText: true,
                      validator: (String value){
                          if(_passwordController.text!=value){
                              return 'Passwords do not match';
                          }
                          return null;
                      },

                  ),
                ),
              ],
            );
    }




  @override
  Widget build(BuildContext context) {

        print('building login screen');
    return Scaffold(
        body: Form(
            key: _formKey,
            autovalidate: true,
            child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                    BackgroundImageWidget(
                        opacity: 0.5,
                    ),
                    SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
                            child: Column(
                                children: <Widget>[
                                    Center(
                                        child: Padding(
                                            padding: EdgeInsets.fromLTRB(2.0, Constant.sizeXXXL, 2.0, 20.0),
                                            child: Image(
                                                image: AssetImage('assets/images/logo.png'),
                                            ),
                                        ),
                                    ),
                                    SizedBox(height: 20,),
                                    _authMode == AuthMode.Signup ? _buildDisplayNameField():Container(),
                                    _buildEmailField(),
                                    _buildPasswordField(),
                                    _authMode ==AuthMode.Signup ? _buildConfirmPasswordField() :Container(),
                                    SizedBox(height: 32,),
                                    RaisedButton(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            'Switch to ${_authMode == AuthMode.Login? 'Signup':'Login'}',
                                            style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: (){
                                            setState(() {
                                                _authMode = _authMode == AuthMode.Login? AuthMode.Signup:AuthMode.Login;
                                            });
                                        },
                                    ),
                                    SizedBox(height: 16,),
                                    RaisedButton(
                                        padding: EdgeInsets.all(10.0),
                                        onPressed: ()=>_submitForm(),
                                        child: Text(
                                            _authMode == AuthMode.Login ? 'Login' : 'Signup',
                                            style:  TextStyle(fontSize: 20),
                                        ),
                                    ),
                                    SizedBox(height: 16,),
                                    _authMode == AuthMode.Login? InkWell(
                                        child: Text('Forgot Password? Click here',
                                            style: TextStyle(color: Colors.blue[600],fontSize: 18.0,fontWeight: FontWeight.w600,decoration: TextDecoration.underline),
                                        ),
                                        onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                                        },
                                    ):Container(),
                                ],
                            ),
                        ),
                    )
                ],
            )
        ),
    );
  }
}
