import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';
import 'package:signup/models/user.dart';

class OurDatabase{
  String data = "https://thumbs.dreamstime.com/b/user-profile-avatar-icon-134114292.jpg";
  final Firestore _firestore = Firestore.instance;
 //final CollectionReference profileList= Firestore.instance.collection('users');
  Future<String> createUser(OurUser user) async{
    //var addUserData = Map<String,dynamic>();
    String retVal ='error';
    try{
      await _firestore.collection('users').document(user.uid).setData({
        'displayName' : user.displayName,
      //  'lastName' : user.lastName,
        'phoneNumber' : user.phoneNumber,
        'email' : user.email,
        'uid': user.uid,
        'avatarUrl':data,
 //       'title': user.title,
 //       'age': user.age,
  //      'location': user.location,
   //     'description': user.description,
        'role' : "other",
        //'admin': user.in,
        'accountCreated' : Timestamp.now(),
      });
      retVal='Success';
    }
    catch(e)
    {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async{
    OurUser retVal = OurUser();
    try{
      //DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
      retVal.uid = uid;
      //retVal.firstName= _docSnapshot.data('firstName');
      retVal.displayName = _docSnapshot.data["displayName"];
      //retVal.lastName = _docSnapshot.data["lastName"];
      retVal.email= _docSnapshot.data['email'];
      retVal.phoneNumber= _docSnapshot.data['phoneNumber'];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
      retVal.role = _docSnapshot.data["role"];
      //retVal.isAdmin = _docSnapshot.data["isAdmin"];
    }
    catch(e)
    {
      print(e);
    }
    return retVal;
  }
//  Future<String> finishedBook(String uid,int rating,String review) async{
//    String retVal = 'error';
//    OurUser user = OurUser();
//    try{
//      DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
//      //await _firestore.collection('users').document(user.uid).collection('reviews').document(uid).setData({'rating':rating,'review':review});
////      await OurDatabase().addReview(_currentUser.uid,userUid, rating, review);
////      _doneWithReview = true;
////      notifyListeners();
//      print('Value3${user.uid}');
//    }
//    catch(e){
//      print(e);
//    }
//    return retVal;
//  }
//  Future<String> addReview(String userId,String uid, int rating,String review)async
//  {
//    String retVal = "error";
//    try{
//      await _firestore.collection('users').document(userId).collection('reviews').document(uid).setData({"rating": rating,"review":review});
//    }
//    catch(e){
//      print(e);
//    }
//    return retVal;
//  }
  Future<bool> isUserDoneWithBook(String uid)async
  {
    bool retVal = false;
    OurUser user = OurUser();
    try{
      DocumentSnapshot _docSnapshot = await  _firestore.collection('users').document(user.uid).collection('reviews').document(uid).get();
      print('Value4${user.uid}');
      if(_docSnapshot.exists)
      {
        print('Value4${user.uid}');
        retVal = true;
      }
      // await _firestore.collection('users').document(userId).collection('reviews').document(uid).setData({"rating": rating,"review":review});
    }
    catch(e){
      print(e);
    }
    return retVal;
  }
//  final CollectionReference _usersCollectionReference =
//  Firestore.instance.collection('users');
//
//  Future createUser(User user) async {
//    try {
//      await _usersCollectionReference.document(user.id).setData(user.toJson());
//    } catch (e) {
//      // TODO: Find or create a way to repeat error handling without so much repeated code
//      if (e is PlatformException) {
//        return e.message;
//      }
//
//      return e.toString();
//    }
//  }
//
//  Future getUser(String uid) async {
//    try {
//      var userData = await _usersCollectionReference.document(uid).get();
//      return User.fromData(userData.data);
//    } catch (e) {
//      // TODO: Find or create a way to repeat error handling without so much repeated code
//      if (e is PlatformException) {
//        return e.message;
//      }
//
//      return e.toString();
//    }
//  }

//  Stream<List<OurUser>> getUserList() {
//    return _firestore.collection('Users')
//        .snapshots()
//        .map((snapShot) => snapShot.documents
//        .map((document) => OurUser.fromJson(document.data))
//        .toList());
//  }
//  Future getUserLst() async {
//    List itemsList = [];
//
//    try {
//      await profileList.getDocuments().then((querySnapshop){
//        querySnapshop.documents.forEach((element) {
//          itemsList.add(element.data);
//        });
//      });
//      return itemsList;
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//
//  }
}