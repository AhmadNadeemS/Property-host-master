import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OurUser{
  String uid;
  String email;
 // String title;
 // String age;
 // String location;
 // String description;
  Timestamp accountCreated;
  String displayName;
  //String firstName;
  //String lastName;
  String phoneNumber;
  String role;
  String image;

  //String notifToken;

  OurUser({
    this.uid,
    this.email,
 //   this.title,
 //   this.age,
 //   this.location,
 //   this.description,
    this.accountCreated,
    this.displayName,
    //   this.firstName,
 //   this.lastName,
    this.phoneNumber,
    this.role,
    this.image,
    //this.notifToken,
  });

//  OurUser.fromData(Map<String, dynamic> data)
//      : uid = data['uid'],
//        displayName = data['displayName'],
//        email = data['email'],
//        phoneNumber = data['phoneNumber'],
//        role = data['role'];
//
//  Map<String, dynamic> toJson() {
//    return {
//      'id': uid,
//      'fullName': displayName,
//      'email': email,
//      'phoneNumber' :phoneNumber,
//      'role': role,
//    };
//  }
//  OurUser.fromJson(Map<String, dynamic> parsedJSON)
//      : firstName = parsedJSON['name'],
//        age = parsedJSON['age'];
//  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
//    uid = doc.documentID;
//    email = doc.data['email'];
//    accountCreated = doc.data['accountCreated'];
//    fullName = doc.data['fullName'];
//    groupId = doc.data['groupId'];
//    notifToken = doc.data['notifToken'];
//  }
}
