import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signup/helper/constants.dart';
import 'package:signup/models/AgentUser.dart';
import 'package:signup/services/agentDatabase.dart';
import './AppLogic/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'helper/helperfunctions.dart';

class AgentSignUp extends StatefulWidget {
  @override
  _AgentSignUpState createState() => _AgentSignUpState();
}

class _AgentSignUpState extends State<AgentSignUp> {
  //File _image;
  bool work = false;
  String _imageUrl;
  File _imageFile;
  final picker = ImagePicker();

  final Firestore _firestore = Firestore.instance;

  String retVal;

  AgentDatabase agentdb = new AgentDatabase();
  AgentUser agentUser = new AgentUser();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //FirebaseUser user;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  String fName, title, age, location, phoneNumber, email, description;
  final TextEditingController _firstName = TextEditingController();

  // final TextEditingController _lastName = TextEditingController();
  //final TextEditingController _title = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController Address = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _description = TextEditingController();

  //final TextEditingController _passwordTextController = TextEditingController();
  //final TextEditingController _confirmPasswordController = TextEditingController();
  //final TextEditingController _role = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    //CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        //backgroundColor: Color(0xfff2f3f7),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                //height: MediaQuery.of(context).size.height * 1.7,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                //color: Color(0xff2470c7),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xff213A50),
                          const Color(0xff071930)
                        ],
                        begin: FractionalOffset.topRight,
                        end: FractionalOffset.bottomLeft)),

                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildLogo(context),
                    _buildContainer(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
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

  Widget _buildContainer(BuildContext context) {
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
            height: MediaQuery
                .of(context)
                .size
                .height / 0.7,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                        "Apply for agent",
                        style: TextStyle(
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                _showName(),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _showName() {
    return Builder(
      builder: (BuildContext context) {
        return Form(
          key: _key,
          autovalidate: _validate,
          child: Container(
            child: Column(
              children: <Widget>[
                _showImage(),
                SizedBox(height: 16),

                SizedBox(height: 16),
                _imageFile == null && _imageUrl == null
                    ? ButtonTheme(
                  child: RaisedButton(
                    onPressed: () => _getLocalImage(),
                    child: Text(
                      'Add Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ) : SizedBox(height: 0),

                /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _age,
                          keyboardType: TextInputType.number,
                          validator: validateAge,
                        onSaved: (String val) {
                            agentUser.age = val;
                          },
                          maxLines: 1,
                          autofocus: false,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.invert_colors,
                                color: Colors.grey[800],
                              ),
                              labelText: 'Enter Age:'),
                        ),
                      ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: ValidateLocation,
                    controller: Address,
                    onSaved: (String val) {
                      agentUser.address = val;
                    },
                    maxLines: 1,
                    autofocus: false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.add_location,
                          color: Colors.grey[800],
                        ),
                        labelText: 'Enter Your Address:'),
                  ),
                ),

                Container(
                  //padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
                  //color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          validator: ValidateDescp,
                          controller: _description,
                          onSaved: (String val) {
                            agentUser.description = val;
                          },
                          maxLines: 4,
                          autofocus: false,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.description,
                                color: Colors.grey[800],
                              ),
                              labelText: 'Your Introduction:'),
                          //textAlign: TextAlign,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          width: 165,
                          child: FlatButton(
                            disabledColor: Colors.grey[800],
                            onPressed: () async {
                              if (_sendToServer()) {
                                uploadFoodAndImage(_imageFile,);
                                //  print( agentUser.image.toString());

                                Constants.myName = await HelperFunctions
                                    .getUserNameSharedPreference();
                                Constants.PhoneNumber = await HelperFunctions
                                    .getUserPhoneNoSharedPreference();

                                agentUser.uid = user.uid;
                                agentUser.email = user.email;
                                agentUser.phoneNumber = Constants.PhoneNumber;
                                agentUser.Name = Constants.myName;

                                agentdb.ApplyForAgent(agentUser);

                                Navigator.pop(context);
                                _validate = false;
                                return true;
                              }

                              Navigator.pop(context);
                            },
                            child: Text('Submit',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey[800],
                                  width: 1.5,
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ),
                      ],

                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ); //:Center(child: Text("You do not meet the minimum criteria limit for the agent "));

      },
    );
  }


  uploadFoodAndImage(File localFile,) async {
    if (localFile != null) {
      print("uploading image");

      var fileExtension = path.extension(localFile.path);
      print(fileExtension);

      var uuid = user.email;

      final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref()
          .child('agentRequest/$uuid/$fileExtension');

      await firebaseStorageRef
          .putFile(localFile)
          .onComplete
          .catchError((onError) {
        print(onError);
        return false;
      });

      String url = await firebaseStorageRef.getDownloadURL();
      print("downloaded url: $url");
      _uploadImage(url);
    } else {
      print('...skipping image upload');
      //_uploadFood(foodUploaded);
    }
  }

  _uploadImage(String imageUrl) async {
    if (imageUrl != null) {
      agentUser.image = imageUrl;

      await _firestore.collection("agentRequest").document(user.uid).updateData(
          {
            'image': agentUser.image,
          });
    } else {

    }
  }

  // ignore: missing_return
  bool _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      return true;
    } else {
      // validation error
      setState(() {
        _validate = true;
        return false;
      });
    }
  }

  _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("image placeholder");
    } else if (_imageFile != null) {
      print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }

  Future _getLocalImage() async {
    final imageFile = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);
    if (imageFile != null) {
      setState(() {
        _imageFile = File(imageFile.path);
      });
    }
  }

}
