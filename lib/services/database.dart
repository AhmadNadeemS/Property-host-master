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
        'phoneNumber' : user.phoneNumber,
        'email' : user.email,
        'uid': user.uid,
        'avatarUrl':data,
        'User Type' : "user",
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
      retVal.UserType = _docSnapshot.data["User Type"];
      //retVal.isAdmin = _docSnapshot.data["isAdmin"];
    }
    catch(e)
    {
      print(e);
    }
    return retVal;
  }

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

}