
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signup/AppLogic/post.dart';
import 'package:signup/home.dart';
import 'package:signup/services/agentDatabase.dart';
import '../models/user.dart';
import '../models/AgentUser.dart';
import '../services/database.dart';
import 'package:signup/services/database.dart';


class CurrentUser extends ChangeNotifier{
  OurUser _currentUser = OurUser();
  //  String _uid;
    String _name;
  final commentsRef  = Firestore.instance.collection('comments');
  //final CollectionReference _postsCollectionReference = Firestore.instance.collection('posts');
  OurUser get getCurrentUser => _currentUser;
  //String get getUid => _uid;
 bool _doneWithReview = false;
 bool get getDoneWithReview => _doneWithReview;
   String get getName => _name;
//  AgentUser _agentUser = AgentUser();
//  OurUser get getAgentUser => _currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

//  Future addPost(Post post) async {
//    try {
//      await _postsCollectionReference.add(post.toMap());
//      return true;
//    } catch (e) {
//      return e.toString();
//    }
//  }


  Future<String> loginUserWithEmail(String email, String password, BuildContext context) async {
    String retVal = "error";
    OurUser _user = OurUser();
    try{
      AuthResult _authResult = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
 //     _user.displayName = _authResult.user.displayName;
      // Navigator.push(context, MaterialPageRoute(builder: (context) => RoleCheck()));
//      if(_authResult.user!=null)
//      {
//        _currentUser.uid = _authResult.user.uid;
//        _currentUser.email = _authResult.user.email;
//
//        //        _uid = _authResult.user.uid;
//       //        _email = _authResult.user.email;
//       retVal = "Success";
      _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);

      //_currentUser = await OurDatabase().getUser(_authResult.user.uid);
      if(_currentUser!=null)
      {
        retVal ="Success";
      }
    }

    catch(e){
      retVal = e.message;
    }
    return retVal;
  }
//  void updateStateFromDatabase(String userId) async{
//    OurUser user = OurUser();
//    try{
//      //Firestore.instance.collection('users').where("uid", isEqualTo:data).snapshots(),
//      _doneWithReview = await OurDatabase().isUserDoneWithBook(userId);
//      print('Value${_currentUser.uid}');
//      notifyListeners();
//    }
//    catch(e)
//    {
//      print(e);
//    }
//  }
//  void finishedBook(String userId,int rating,String review) async{
//    OurUser user = OurUser();
//    try{
//      await OurDatabase().finishedBook(userId, rating, review);
//      print('Value2${_currentUser.uid}');
//      _doneWithReview = true;
//      notifyListeners();
//
//    }
//    catch(e){
//      print(e);
//    }
//  }
  Future<String> onStartUp() async{
    String retVal = "error";
    try{
      FirebaseUser _firebaseUser = await _auth.currentUser();
      if(_firebaseUser!=null)
      {
        _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
       // _currentUser = await OurDatabase().getUser(_firebaseUser.uid);
        if(_currentUser!=null)
        {
          retVal ="Success";
        }
      }

//      FirebaseUser _firebaseUser = await _auth.currentUser();
//      _currentUser.uid = _firebaseUser.uid;
//      _currentUser.email = _firebaseUser.email;
      //_uid = _firebaseUser.uid;
      //_email = _firebaseUser.email;

    }
    catch(e){
      print(e);
    }
    return retVal;
  }
  Future<String> signOut() async{
    String retVal = "error";
    try{
      await _auth.signOut();
      _currentUser = OurUser();
      //await _auth.currentUser();
      //_currentUser = null;
      //_uid = null;
      //_email = null;
      retVal = "Success";
    }
    catch(e){
      print(e);
    }
    return retVal;
  }
//  Future<String> createUserWithEmailAndPassword(String email, String password,
//      String name) async {
//    final authResult = await _auth.createUserWithEmailAndPassword(
//      email: email,
//      password: password,
//    );
//
//    // Update the username
//   // await updateUserName(name, authResult.user);
//    return authResult.user.uid;
//  }

  Future<String> signUpUser(String email, String password, String displayName,String title,String location,String age, String description, String phoneNumber,String role) async {
    String retVal = "error";
    OurUser _user = OurUser();
    try{
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password,);
      _user.uid = _authResult.user.uid;
      _user.email = _authResult.user.email;
      _user.displayName = displayName;
      //_user.image = _authResult.user.photoUrl;
      //_user.displayName = _authResult.user;
      //_user.firstName = _currentUser.firstName;
      //_user.lastName = lastName;
      _user.phoneNumber = phoneNumber;
      _user.role = role;
      String _returnString = await OurDatabase().createUser(_user);

      if(_returnString == 'Success')
      {
        retVal = "Success";
      }
    } on PlatformException catch (e)
    {
      retVal= e.message;
    }
    catch(e){
      retVal = e.message;
    }
    return retVal;
  }

//  Future<String> signUpAgent(String email, String password, String firstName,String title,String location,String age, String description, String phoneNumber,String role) async {
//    String retVal = "error";
//    AgentUser _user = AgentUser();
//    try{
//      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//      _user.uid = _authResult.user.uid;
//      _user.email = _authResult.user.email;
//      _user.firstName = firstName;
//      _user.title = title;
//      _user.age = age;
//      _user.location = location;
//      _user.description = description;
//      _user.phoneNumber = phoneNumber;
//      _user.role = role;
//      String _returnString = await AgentDatabase().createUser(_user);
//
//      if(_returnString == 'Success')
//      {
//        retVal = "Success";
//      }
//    } on PlatformException catch (e)
//    {
//      retVal= e.message;
//    }
//    catch(e){
//      retVal = e.message;
//    }
//    return retVal;
//  }

  Future<String> loginUserWithGoogle() async {
    String retVal = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    OurUser _user = OurUser();
    try{
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      AuthResult _authResult = await _auth.signInWithCredential(credential);
      if(_authResult.additionalUserInfo.isNewUser)
      {
        _user.uid = _authResult.user.uid;
        _user.email = _authResult.user.email;
        _user.displayName = _authResult.user.displayName;
        _user.image=_authResult.user.photoUrl;
        // _user.lastName = _authResult.user.displayName;
        //  _user.phoneNumber = _authResult.user.phoneNumber;
        OurDatabase().createUser(_user);

      }
//      _currentUser.uid = _authResult.user.uid;
//      _currentUser.email = _authResult.user.email;

      //_uid = _authResult.user.uid;
      //_email = _authResult.user.email;
//        retVal = "Success";
      _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
      //_currentUser = await OurDatabase().getUser(_authResult.user.uid);
      if(_currentUser!=null)
      {
        retVal ="Success";
      }
    }on PlatformException catch (e)
    {
      retVal= e.message;
    }
    catch(e){
      retVal = e.message;
    }
    return retVal;
  }
}