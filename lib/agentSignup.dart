import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:signup/MyProfileFinal.dart';
import 'package:signup/models/user.dart';
import 'package:signup/random.dart';
import 'package:signup/root/root.dart';
import 'package:signup/services/agentDatabase.dart';
import 'package:signup/states/currentUser.dart';
import './AppLogic/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'models/AgentUser.dart';

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

//  Future getImage() async{
//    final pickedFile = await picker.getImage(source: ImageSource.gallery);
//    setState(() {
//      _image = File(pickedFile.path);
//    });
//  }
  final Firestore _firestore = Firestore.instance;

//  Map<String,dynamic> productToAdd;
//  CollectionReference collectionReference=Firestore.instance.collection('agentRequests');
//  addProduct(){
//    productToAdd ={
//      "firstName" : _firstName.text,
//      "title" : _title.text,
//      "age" : _age.text,
//      "location" : _location.text,
//      "phoneController" : _phoneController.text,
////      "emailAddress" : _emailAddress.text,
//      "description" : _description.text,
//    };
//    collectionReference.add(productToAdd).whenComplete(() => print('Added'));
//  }
  //final Firestore _firestore = Firestore.instance;
  //AgentUser _currentUser = AgentUser();
  String retVal;

  //  String _uid;
  //  String _email;

  OurUser _currentUser = OurUser();

  //  String _uid;
  //  String _email;
  //  String _email;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  OurUser get getCurrentUser => _currentUser;

  //bool userLoggedIn =false;
  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

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

  //String get getUid => _uid;

  // String get getEmail => _email;
//  AgentUser _agentUser = AgentUser();
//  OurUser get getAgentUser => _currentUser;

  //AgentUser get getCurrentUser => _currentUser;
  //String get getUid => _uid;

  // String get getEmail => _email;
//  AgentUser _agentUser = AgentUser();
//  OurUser get getAgentUser => _currentUser;
  String FName, title, Age, Location, PhoneNumber, Email, Description;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _description = TextEditingController();

  //final TextEditingController _passwordTextController = TextEditingController();
  //final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _role = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

//  void _signUpUser(String email, String password, BuildContext context,String firstName, String lastName, String title,String age,String location,String description,String phoneNumber,String role) async {
//    //final _auth = FirebaseAuth.instance;
//    CurrentUser _currentUser = Provider.of<CurrentUser>(context,listen: false);
//
//    _sendToServer();
//    try{
//      String _returnString = await _currentUser.signUpUser(email, password,firstName,lastName,title,age,location,description,phoneNumber,role);
//      if(_returnString == 'Success')
//      {
//          //signOut();
//          // Navigator.pushNamed(context, '/LoginScreen');
//          CurrentUser _currentUser = Provider.of<CurrentUser>(
//              context, listen: false);
//          String _returnString = await _currentUser.signOut();
////                  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
////                  String _returnString = await _currentUser.signOut();
//          if (_returnString == 'Success') {
//            Navigator.pushAndRemoveUntil(
//              context, MaterialPageRoute(
//                builder: (context)=>OurRoot()
//            ),
//                  (route) => false,);
//            //Navigator.pushNamed(context, '/LoginScreen');
////                  }
////                  //Navigator.pushNamed(context, '/LoginScreen');
//          }
//
//
////        Navigator.pushNamed(context, '/LoginScreen');
//      }
//      else
//      {
//        Scaffold.of(context).showSnackBar(
//          SnackBar(
//            content: Text(_returnString),
//            duration: Duration(seconds: 2),
//          ),
//        );
//      }
//    }
//    catch (e) {
//      print(e);
//    }
//  }
  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
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
                height: MediaQuery.of(context).size.height * 1.3,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.grey[800],
                child: Column(
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
            height: MediaQuery.of(context).size.height / 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
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
                        "Sign Up",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
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
                      )
                    : SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 1,
                    controller: _firstName,
                    validator: validateName,
                    keyboardType: TextInputType.text,
                    onSaved: (String val) {
                      FName = val;
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.grey[800],
                        ),
                        labelText: 'Enter Full Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 1,
                    controller: _title,
                    keyboardType: TextInputType.text,
                    validator: validateTitle,
                    onSaved: (String val) {
                      title = val;
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.title,
                          color: Colors.grey[800],
                        ),
                        labelText: 'Enter your Title'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _age,
                    keyboardType: TextInputType.number,
                    validator: validateAge,
//                onSaved: (String val) {
//                  Age = val;
//                },
                    maxLines: 1,
                    autofocus: false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.invert_colors,
                          color: Colors.grey[800],
                        ),
                        labelText: 'Enter Age:'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: ValidateLocation,
                    controller: _location,
//                onSaved: (String val) {
//                  Location = val;
//                },
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: validateMobile,
                      controller: _phoneController,
//                onSaved: (String val) {
//                  PhoneNumber = val;
//                },
                      maxLines: 1,
                      autofocus: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.dialer_sip,
                            color: Colors.grey[800],
                          ),
                          labelText: 'Enter Number:'),
                    ),
                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: TextFormField(
//                      keyboardType: TextInputType.emailAddress,
//                      validator: validateEmail,
//                      controller: _emailAddress,
////                onSaved: (String val) {
////                  Email = val;
////                },
//                      maxLines: 1,
//                      autofocus: false,
//                      decoration: InputDecoration(
//                          prefixIcon: Icon(
//                            Icons.email,
//                            color: Colors.grey[800],
//                          ),
//                          labelText: 'Enter Email:'),
//                    ),
//                  ),
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
//                      onSaved: (String val) {
//                        Description = val;
//                      },
                            maxLines: 4,
                            autofocus: false,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.description,
                                  color: Colors.grey[800],
                                ),
                                labelText: 'Your Description:'),
                            //textAlign: TextAlign,
                          ),
//Center(
//  child: _image==null?Text('Select an image'): enableUpload(),
//),
//FlatButton(onPressed: getImage, child: Icon(Icons.add),),
//                    Container(
//                        child: Center(
//                      child: Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: [
//                            Container(
//                              margin: EdgeInsets.only(left: 7),
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceAround,
//                                children: <Widget>[
//                                  RaisedButton(
//                                    child: Text("Select Profile Picture"),
////                        color:
////                        isButtonPressed6 ? Colors.lightGreen : Colors.grey[200],
////                        onPressed: () {
////                          setState(() {
////                            isButtonPressed6 = !isButtonPressed6;
////                          });
////                        },
////                        textColor: Colors.black,
//                                    padding:
//                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
//                                    splashColor: Colors.grey,
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    )),
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Container(
//                        height: 100,
//                        width: 100,
//                        child: Card(
//                          color: Colors.transparent,
//                          elevation: 0,
//                          child: Container(
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(20),
//                                image: DecorationImage(
//                                    image: AssetImage('assets/logo.png'),
//                                    fit: BoxFit.cover)),
//                            child: Transform.translate(
//                              offset: Offset(50, -50),
//                              child: Container(
//                                margin: EdgeInsets.symmetric(
//                                    horizontal: 65, vertical: 63),
//                                decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.circular(10),
//                                    color: Colors.white),
//                                //            child: Icon(Icons.bookmark_border, size: 15,),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),

//                          TextFormField(
//                            controller: _passwordTextController,
//                            decoration: InputDecoration(
//                              prefixIcon: Icon(
//                                Icons.lock,
//                                color: Colors.grey[800],
//                              ),
//                              labelText: 'Password',
//                            ),
//                            obscureText: true,
//                            // ignore: missing_return
//                            validator: (String value) {
//                              if (value.isEmpty || value.length < 6) {
//                                return 'Password invalid';
//                              }
//                            },
//                      onSaved: (String value) {
//                        _password = value;
//                      },
//                          ),
//                          TextFormField(
//                            controller: _confirmPasswordController,
//                            decoration: InputDecoration(
//                              prefixIcon: Icon(
//                                Icons.lock,
//                                color: Colors.grey[800],
//                              ),
//                              labelText: 'Confirm Password',
//                            ),
//                            obscureText: true,
//                            // ignore: missing_return
//                            validator: (String value) {
//                              if (_passwordTextController.text != value) {
//                                return 'Passwords do not match.';
//                              }
//                            },
//                          ),

                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          width: 165,
                          child: FlatButton(
                            disabledColor: Colors.grey[800],
                            onPressed: () async {
_validate = true;
                              var firebaseUser = await FirebaseAuth.instance.currentUser();
                              if (_sendToServer()) {

                                _firestore.collection("users").document(firebaseUser.uid).updateData({
                                  "displayName": _firstName.text,
                                  "title": _title.text,
                                  "age": _age.text,
                                  'phoneNumber' : _phoneController.text,
                                  "address": _location.text,
                                  "description": _description.text,
                                });
                                Navigator.pop(context);
                                _validate = false;
                                return true;
                                                              _validate = false;
                              }

                              Navigator.pop(context);
                              //Navigator.pop(context);
                              // : print('Error') ?  if(_firstName.text !=null)  : Navigator.pop(context);

                              //final navigator = Navigator.of(context);
                              //await navigator.pushNamed('/main');

                              //_sendToServer();
                              //print("${_currentUser.image}");
                              // uploadFoodAndImage(File localFile,)

                              //  Navigator.pushNamed(context, '/main');

                              //Navigator.pop(context);
                            },
                            child: Text('Sign Up',
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
        );
      },
    );
  }

  uploadFoodAndImage(
    File localFile,
  ) async {
    if (localFile != null) {
      print("uploading image");

      var fileExtension = path.extension(localFile.path);
      print(fileExtension);

      var uuid = user.email;

      final StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('agentRequest/$uuid/$fileExtension');

      await firebaseStorageRef
          .putFile(localFile)
          .onComplete
          .catchError((onError) {
        print(onError);
        return false;
      });

      String url = await firebaseStorageRef.getDownloadURL();
      print("download url: $url");
      _uploadImage(url);
    } else {
      print('...skipping image upload');
      //_uploadFood(foodUploaded);
    }
  }

  _uploadImage(String imageUrl) async {
//    CollectionReference foodRef = Firestore.instance.collection('users');
    if (imageUrl != null) {
      _currentUser.image = imageUrl;

//
      await _firestore.collection("users").document(user.uid).updateData({
        'image': _currentUser.image.toString(),
      });
      //print(_currentUser.image);
    } else {
      print('uploaded image successfully:');
    }
  }

  bool _sendToServer() {
    uploadFoodAndImage(
      _imageFile,
    );
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
    //  Future getImage() async{
//    final pickedFile = await picker.getImage(source: ImageSource.gallery);
//    setState(() {
//      _image = File(pickedFile.path);
//    });
//  }
    //File imageFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 50, maxWidth: 400);
    final imageFile = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);
//    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _imageFile = File(imageFile.path);
      });
    }
  }
//Widget enableUpload(){
//    return Container(
//      child: Column(
//        children: <Widget>[
//          Image.file(_image,height: 70,width: 70,),
//          RaisedButton(elevation: 7.0,child: Text("Upload"),textColor:Colors.white,color:Colors.blue,onPressed: ()async{
//            final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('myimage.jpg');
//            final StorageUploadTask task = firebaseStorageRef.putFile(_image);
//          }),
//        ],
//      ),
//    );
//}
//  Widget _uploadImagesInput() {
//    return Padding(
//      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(left: 14),
//                    child: Row(
//                      children: <Widget>[
//                        Text(
//                          "Upload Images : ",
//                          style: TextStyle(
//                              fontSize: 20,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.grey),
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _showSelectImages() {
//    return Container(
//        child: Center(
//      child: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Container(
//              margin: EdgeInsets.only(left: 7),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                children: <Widget>[
//                  RaisedButton(
//                    child: Text("Select Profile Picture"),
////                        color:
////                        isButtonPressed6 ? Colors.lightGreen : Colors.grey[200],
////                        onPressed: () {
////                          setState(() {
////                            isButtonPressed6 = !isButtonPressed6;
////                          });
////                        },
////                        textColor: Colors.black,
//                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                    splashColor: Colors.grey,
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    ));
//
//
//  Widget _showAddImages() {
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: Container(
//        height: 50,
//        width: 100,
//        child: Card(
//          color: Colors.transparent,
//          elevation: 0,
//          child: SingleChildScrollView(
//            child: Container(
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(20),
//                  image: DecorationImage(
//                      image: AssetImage('assets/1.jpg'), fit: BoxFit.cover)),
//              child: Transform.translate(
//                offset: Offset(50, -50),
//                child: Container(
//                  margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      color: Colors.white),
//                  //            child: Icon(Icons.bookmark_border, size: 15,),
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
}
