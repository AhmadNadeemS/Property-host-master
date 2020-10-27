import 'dart:io';

import 'package:flutter/material.dart';
import 'package:signup/states/currentUser.dart';

//import 'package:property_host_system/http_exception.dart';
import './AppLogic/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
class SignUpPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  var _isLoading = false;
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _role = TextEditingController();
  String _FName,_LName, _phoneNumber, _email, _password,_confirmPassword;

  void _signUpUser(String email, String password, BuildContext context,String firstName, String title,String age,String location,String description,String phoneNumber,String role) async {
    //final _auth = FirebaseAuth.instance;
    CurrentUser _currentUser = Provider.of<CurrentUser>(context,listen: false);

    _sendToServer();
    try{
      String _returnString = await _currentUser.signUpUser(email, password,firstName,title,age,location,description,phoneNumber,role);
      if(_returnString == 'Success')
      {
        Navigator.pushNamed(context, '/LoginScreen');
      }
      else
      {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
    catch (e) {
      print(e);
    }
  }
//    catch (error) {
//      // const errorMessage =
//      //   'Could not authenticate you. Please try again later.';
//      //_showErrorDialog(errorMessage);
//      _showErrorDialog(Errors.show(error.code));
//    }
//      if (_returnString == "success") {
//        Navigator.pop(context);
//      } else {
//        Scaffold.of(context).showSnackBar(
//          SnackBar(
//            content: Text(_returnString),
//            duration: Duration(seconds: 2),
//          ),
//        );
//      }

  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if(user != null)
      {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Property Host',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _key,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                controller: _firstName,
                keyboardType: TextInputType.text,
                validator: validateName,
                onSaved: (String val){
                  _FName = val;
                  print(_FName);
                },

                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.grey[800],
                    ),
                    labelText: 'Enter Full Name'),
              ),

            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              validator:validateMobile,
              onSaved: (String val){
                _phoneNumber = val;
                print(_phoneNumber);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.grey[800],
                  ),
                  labelText: 'Phone No'),
            ),
            TextFormField(
              controller: _emailAddress,
              keyboardType: TextInputType.emailAddress,
              validator:validateEmail,
              onSaved: (String val){
                _email = val;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.grey[800],
                ),
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: _passwordTextController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey[800],
                ),
                labelText: 'Password',
              ),
              obscureText: true,
              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty || value.length < 6) {
                  return 'Password invalid';
                }
              },
              onSaved: (String value) {
                _password = value;
              },
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey[800],
                ),
                labelText: 'Confirm Password',
              ),
              obscureText: true,
              // ignore: missing_return
              validator: (String value) {
                if (_passwordTextController.text != value) {
                  return 'Passwords do not match.';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildLoginBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 2),
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/LoginScreen');
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Switch back to? ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .height / 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'Login In',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .height / 35,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  _sendToServer(){
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();


    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  Widget _buildSignUpButton() {
    return Builder(
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 1.4 * (MediaQuery
                  .of(context)
                  .size
                  .height / 25),
              width: 5 * (MediaQuery
                  .of(context)
                  .size
                  .width / 10),
              margin: EdgeInsets.only(top: 40),
              child: RaisedButton(
                //elevation: 5.0,
                color: Colors.grey[800],

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),

                onPressed: () {
                  _sendToServer();
                  
                  if (_passwordTextController.text ==
                      _confirmPasswordController.text) {
                    _signUpUser(
                        _emailAddress.text, _passwordTextController.text,
                        context, _firstName.text,_title.text,_age.text,_location.text,_description.text
                        ,_phoneController.text,_role.text);
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Passwords do not match"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },

//              catch(e)
//              {
//                print(e);
//              }

//              if (_key.currentState.validate()) {
//                // No any error in validation
//                _key.currentState.save();
//                print("Name $FName");
//                print("Mobile $phoneNumber");
//                print("Email $LName");
//              } else {
//                // validation error
//                setState(() {
//                  _validate = true;
//                });
//              }


                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .height / 40,
                  ),
                ),
              ),
            )
          ],
        );
  },
    );
  }


  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),

            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              //padding: EdgeInsets.only(bottom: 0),
              height: MediaQuery.of(context).size.height,

              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSignUpForm(),
                  // _buildSecondNameRow(),
                  //_buildEmailRow(),
                  //_buildPasswordRow(),
                  _buildSignUpButton(),
                ],
              ),
            ),
          ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff2f3f7),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height *1.3,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildLogo(),
                  _buildContainer(),
                  _buildLoginBtn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
