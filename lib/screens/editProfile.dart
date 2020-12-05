import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:signup/AppLogic/validation.dart';
import 'package:signup/models/user.dart';
import 'package:signup/states/currentUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class EditProfile extends StatefulWidget {
  final bool isAgent;

  const EditProfile({Key key, this.isAgent}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState(this.isAgent);
}

class _EditProfileState extends State<EditProfile> {
  //File _image;
  bool work = false;
  String _imageUrl;
  File _imageFile;
  final picker = ImagePicker();
  bool isAgent = true;

  _EditProfileState(this.isAgent);

  void _fetchUserData() async {

    // do something
    try {
      FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
      String authid =_currentUser.uid;
      Firestore.instance.collection('users').document('$authid').get().then((ds) {
        if (ds.exists) {
          setState(() {
            _firstName.text = ds.data['displayName'];
            _phoneController.text = ds.data['phoneNumber'];
            _description.text = ds.data['description'];
            _location.text = ds.data['address'];
            _age.text = ds.data['age'];
            _imageUrl = ds.data['image'];
          });
        }
      });
    }
    catch(e)
    {
      print("data");
    }
  }

  void dispose() {
    _firstName.dispose();
    super.dispose();
  }
//  Future getImage() async{
//    final pickedFile = await picker.getImage(source: ImageSource.gallery);
//    setState(() {
//      _image = File(pickedFile.path);
//    });
//  }
  final Firestore _firestore = Firestore.instance;


  String retVal;


  OurUser _currentUser = OurUser();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  OurUser get getCurrentUser => _currentUser;


  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
    _fetchUserData();
  }

  initUser() async {
    user = await _auth.currentUser();
    print(user.uid.toString());
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
  String fName, title, age, location, phoneNumber, email, description;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _description = TextEditingController();

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
            height: MediaQuery.of(context).size.height / 0.7,
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
                        "Edit Profile",
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
          child: StreamBuilder(
              stream: Firestore.instance.collection('users').where("uid", isEqualTo:user.uid).snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    //shrinkWrap: true,
                      shrinkWrap: true,  physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: SingleChildScrollView(
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
                                      fName = val;
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
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: TextFormField(
//                    maxLines: 1,
//                    controller: _title,
//                    keyboardType: TextInputType.text,
//                    validator: validateTitle,
//                    onSaved: (String val) {
//                      title = val;
//                    },
//                    autofocus: false,
//                    decoration: InputDecoration(
//                        prefixIcon: Icon(
//                          Icons.title,
//                          color: Colors.grey[800],
//                        ),
//                        labelText: 'Enter your Title'),
//                  ),
//                ),
                                snapshot
                                    .data.documents.elementAt(index)['User Type']=="Agent" ? Padding(
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
                                ):Container(),
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
                                              labelText: 'Your Introduction:'),
                                          //textAlign: TextAlign,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10, top: 10),
                                          width: 165,
                                          child: FlatButton(
                                            disabledColor: Colors.grey[800],
                                            onPressed: () async {
                                              _validate = true;
                                              var firebaseUser = await FirebaseAuth
                                                  .instance.currentUser();
                                              if (_sendToServer()) {
                                                if(snapshot.data.documents.elementAt(index)['User Type']=="Agent"){

                                               await _firestore.collection("users").document(
                                                    firebaseUser.uid).updateData({
                                                  "displayName": _firstName.text,
                                                  "age": _age.text,
                                                  'phoneNumber': _phoneController.text,
                                                  "address": _location.text,
                                                  "description": _description.text,
                                                });

                                                }else{

                                               await   _firestore.collection("users").document(
                                                      firebaseUser.uid).updateData({
                                                    "displayName": _firstName.text,
                                                    'phoneNumber': _phoneController.text,
                                                    "address": _location.text,
                                                    "description": _description.text,
                                                  });
                                                }

                                                Navigator.pop(context);
                                                _validate = false;
                                                return true;
                                              }

                                              Navigator.pop(context);
                                            },
                                            child: Text('Update',
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
                      }
                  );
                }
                else {
                  debugPrint('Loading...');
                  return Center(
                    child: Text('Loading...'),
                  );

                }
              }
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

  // ignore: missing_return
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
            height: 190,
            width: 190,
          ),
          ButtonTheme(
            height: 10,
            minWidth: 10,
            child: RaisedButton(
              padding: EdgeInsets.all(16),
              color: Colors.black54,
              child: Text(
                'Change Image',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () => _getLocalImage(),
            ),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('showing image from url');

      return Column(
        //alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          ClipOval(
            child: Image.network(
              _imageUrl,
              width: 190,
              height: 190,
              fit: BoxFit.cover,
            ),
          ),
//          Image.network(
//            _imageUrl,
//            width: MediaQuery.of(context).size.width,
//            fit: BoxFit.cover,
//            height: 250,
//          ),
          ButtonTheme(
            height: 10,
            minWidth: 10,
            child: RaisedButton(
              padding: EdgeInsets.all(16),
              color: Colors.black54,
              child: Text(
                'Change Image',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () => _getLocalImage(),
            ),
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
