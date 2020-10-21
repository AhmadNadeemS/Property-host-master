import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';
import 'package:signup/models/user.dart';

class OurDatabase{
  String data =
      "https://thumbs.dreamstime.com/b/user-profile-avatar-icon-134114292.jpg";
  final Firestore _firestore = Firestore.instance;

  Future<String> createUser(User user) async {
    String retVal = 'error';
    try {
      await _firestore.collection('users').document(user.uid).setData({
        'displayName': user.displayName,
        'phoneNumber': user.phoneNumber,
        'email': user.email,
        'uid': user.uid,
        'avatarUrl': data,
        'User Type': "other",
        'accountCreated': Timestamp.now(),
      });
      retVal = 'Success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<User> getUserInfo(String uid) async {
    User retVal = User();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").document(uid).get();
      retVal.uid = uid;
      retVal.displayName = _docSnapshot.data["displayName"];
      retVal.email = _docSnapshot.data['email'];
      retVal.phoneNumber = _docSnapshot.data['phoneNumber'];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
      retVal.UserType = _docSnapshot.data["role"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }


  Future<bool> isUserDoneWithBook(String uid)async
  {
    bool retVal = false;
    User user = User();
    try {
      DocumentSnapshot _docSnapshot = await _firestore.collection('users')
          .document(user.uid).collection('reviews').document(uid)
          .get();
      print('Value4${user.uid}');
      if (_docSnapshot.exists) {
        print('Value4${user.uid}');
        retVal = true;
      }
    }
    catch (e) {
      print(e);
    }
    return retVal;
  }
}