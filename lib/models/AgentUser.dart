import 'package:cloud_firestore/cloud_firestore.dart';

class AgentUser {
  String uid;
  String email;
  String age;
  List location;

  String description;
  Timestamp accountCreated;
  String Name;
  String phoneNumber;
  String UserType;
  String image;
  String address;

  AgentUser({
        this.uid,
        this.email,
        this.age,
        this.location,
        this.description,
        this.accountCreated,
        this.Name,
        this.phoneNumber,
        this.UserType,
        this.image,
        this.address});
}
