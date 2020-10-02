import 'package:cloud_firestore/cloud_firestore.dart';

class AgentUser {
  String uid;
  String email;
  String title;
  String age;
  String location;
  String description;
  Timestamp accountCreated;
  String firstName;
  String phoneNumber;
  String role;

  //String notifToken;

  AgentUser({
    this.uid,
    this.email,
    this.title,
    this.age,
    this.location,
    this.description,
    this.accountCreated,
    this.firstName,
    this.phoneNumber,
    this.role,
    //this.notifToken,
  });

//  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
//    uid = doc.documentID;
//    email = doc.data['email'];
//    accountCreated = doc.data['accountCreated'];
//    fullName = doc.data['fullName'];
//    groupId = doc.data['groupId'];
//    notifToken = doc.data['notifToken'];
//  }
}
