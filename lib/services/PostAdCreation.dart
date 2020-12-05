
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signup/models/Adpost.dart';

class PostAddFirebase{

  final firestoreInstance = Firestore.instance;

  void CreatePostAddHomes(AdPost adPost) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").add({
      "Title":adPost. title,
      "Description":adPost. desc,
      "Price": adPost.price,
      "Image Urls": adPost.ImageUrls,
      "Address": {"Street":adPost. Address, "city": adPost.City},
      "Location":adPost.location,
      "Available Days":adPost. AvailDays,
      "Purpose":adPost. purpose,
      "Property Type":adPost. propertyType,
      "Property SubType": adPost.propertyDeatil,
      "Meeting Time": adPost.time,
      "Unit Area": adPost.unitArea,
      "Property Size": adPost.propertySize,
      "Main Features": {
        "Build year": adPost.buildyear,
        "Parking space": adPost.ParkingSpace,
        "Rooms": adPost.Rooms,
        "Bathrooms": adPost.bathrooms,
        "kitchens": adPost.Kitchens,
        "Floors": adPost.Floors,
      },
      "email": firebaseUser.email,
      "uid": firebaseUser.uid,
    }).then((value) {
      firestoreInstance
          .collection("PostAdd")
          .document(value.documentID)
          .setData({
        "PostID": value.documentID,
      }, merge: true).then((_) {
        print("success!" + value.documentID);
      });
      print("success new post added in firebase!");
    });
  }

  void CreatePostAddHomesPentHouse(AdPost adPost) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();

    firestoreInstance.collection("PostAdd").add({
      "Title": adPost.title,
      "Description": adPost.desc,
      "Price": adPost.price,
      "Image Urls": adPost.ImageUrls,
      "Address": {"Street": adPost.Address, "city": adPost.City},
      "Available Days": adPost.AvailDays,
      "Purpose":adPost. purpose,
      "Property Type": adPost.propertyType,
      "Property SubType": adPost.propertyDeatil,
      "Meeting Time": adPost.time,
      "Unit Area": adPost.unitArea,
      "Property Size": adPost.propertySize,
      "email": firebaseUser.email,
      "uid": firebaseUser.uid,
    }).then((value) {
      firestoreInstance
          .collection("PostAdd")
          .document(value.documentID)
          .setData({
        "PostID": value.documentID,
      }, merge: true).then((_) {
        print("success!" + value.documentID);
      });
      print("success new post added in firebase!");
    });
  }

  void CreatePostAddPlots(AdPost adPost) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").add({
      "Title":adPost. title,
      "Description":adPost. desc,
      "Price": adPost.price,
      "Address": {"Street": adPost.Address, "city":adPost. City},
      "Available Days": adPost.AvailDays,
      "Purpose": adPost.purpose,
      "Property Type": adPost.propertyType,
      "Property SubType": adPost.propertyDeatil,
      "Meeting Time": adPost.time,
      "Unit Area": adPost.unitArea,
      "Property Size": adPost.propertySize,
      "Image Urls": adPost.ImageUrls,
      "Main Features": {
        "Possession": adPost.possesion,
        "Park facing": adPost.ParkingSpace,
        "Disputed": adPost.disputed,
        "Balloted": adPost.balloted,
        "Corner": adPost.corners,
        "sui gas": adPost.suiGas,
        "water supply": adPost.waterSupply,
        "Sewarege": adPost.sewarge,
      },
      "email": firebaseUser.email,
      "uid": firebaseUser.uid,
    }).then((value) {
      firestoreInstance
          .collection("PostAdd")
          .document(value.documentID)
          .setData({
        "PostID": value.documentID,
      }, merge: true).then((_) {
        print("success!" + value.documentID);
      });
      print("success new post added in firebase!");
    });
  }

  void CreatePostAddCommerical(AdPost adPost) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").add({
      "Title": adPost.title,
      "Description": adPost.desc,
      "Price": adPost.price,
      "Address": {"Street": adPost.Address, "city": adPost.City},
      "Available Days":adPost. AvailDays,
      "Purpose": adPost.purpose,
      "Property Type": adPost.propertyType,
      "Property SubType": adPost.propertyDeatil,
      "Meeting Time": adPost.time,
      "Unit Area": adPost.unitArea,
      "Property Size": adPost.propertySize,
      "Image Urls": adPost.ImageUrls,

      "Main Features": {
        "Build year": adPost.buildyear,
        "Parking space": adPost.ParkingSpace,
        "Rooms": adPost.Rooms,
        "Floors":adPost. Floors,
        "Flooring": adPost.Flooring,
        "Elevators": adPost.Elevators,
        "Maintenance Staff":adPost. MaintenanceStaff,
        "Security Staff": adPost.Security,
        "Waste disposal": adPost.WasteDisposal
      },
      "email": firebaseUser.email,
      "uid": firebaseUser.uid,
    }).then((value) {
      firestoreInstance
          .collection("PostAdd")
          .document(value.documentID)
          .setData({
        "PostID": value.documentID,
      }, merge: true).then((_) {
        print("success!" + value.documentID);
      });
      print("success new post added in firebase!");
    });
  }

  // ---------------------------------------------------------- update functions-------------------------------------//

  void updatePostAddHomes(AdPost adPost) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").document(adPost.postId).updateData({
      "Title":adPost. title,
      "Description":adPost. desc,
      "Price": adPost.price,
      "Image Urls": adPost.ImageUrls,
      "Address": {"Street":adPost. Address, "city": adPost.City},
      //  "Location":location,
      "Available Days":adPost. AvailDays,
      "Purpose":adPost. purpose,
      "Property Type":adPost. propertyType,
      "Property SubType": adPost.propertyDeatil,
      "Meeting Time": adPost.time,
      "Unit Area": adPost.unitArea,
      "Property Size": adPost.propertySize,
      "Main Features": {
        "Build year": adPost.buildyear,
        "Parking space": adPost.ParkingSpace,
        "Rooms": adPost.Rooms,
        "Bathrooms": adPost.bathrooms,
        "kitchens": adPost.Kitchens,
        "Floors": adPost.Floors,
      },
      "email": firebaseUser.email,
      "uid": firebaseUser.uid,
    });
      print("success  post updated in firebase!");

  }

  void updatePostAddHomesPentHouse(AdPost adPost) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();

    firestoreInstance.collection("PostAdd").document(adPost.postId).updateData({
      "Title": adPost.title,
      "Description": adPost.desc,
      "Price": adPost.price,
      "Image Urls": adPost.ImageUrls,
      "Address": {"Street": adPost.Address, "city": adPost.City},
      "Available Days": adPost.AvailDays,
      "Purpose":adPost. purpose,
      "Property Type": adPost.propertyType,
      "Property SubType": adPost.propertyDeatil,
      "Meeting Time": adPost.time,
      "Unit Area": adPost.unitArea,
      "Property Size": adPost.propertySize,
      "email": firebaseUser.email,
      "uid": firebaseUser.uid,
    });
      print("success new updated in firebase!");

  }

  void updatePostAddPlots(AdPost adPost) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").document(adPost.postId).updateData({
      "Title":adPost. title,
      "Description":adPost. desc,
      "Price": adPost.price,
      "Address": {"Street": adPost.Address, "city":adPost. City},
      "Available Days": adPost.AvailDays,
      "Purpose": adPost.purpose,
      "Property Type": adPost.propertyType,
      "Property SubType": adPost.propertyDeatil,
      "Meeting Time": adPost.time,
      "Unit Area": adPost.unitArea,
      "Property Size": adPost.propertySize,
      "Image Urls": adPost.ImageUrls,
      "Main Features": {
        "Possession": adPost.possesion,
        "Park facing": adPost.ParkingSpace,
        "Disputed": adPost.disputed,
        "Balloted": adPost.balloted,
        "Corner": adPost.corners,
        "sui gas": adPost.suiGas,
        "water supply": adPost.waterSupply,
        "Sewarege": adPost.sewarge,
      },
      "email": firebaseUser.email,
      "uid": firebaseUser.uid,
    });
  }

  void updatePostAddCommerical(AdPost adPost) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").document(adPost.postId).updateData({
      "Title": adPost.title,
      "Description": adPost.desc,
      "Price": adPost.price,
      "Address": {"Street": adPost.Address, "city": adPost.City},
      "Available Days":adPost. AvailDays,
      "Purpose": adPost.purpose,
      "Property Type": adPost.propertyType,
      "Property SubType": adPost.propertyDeatil,
      "Meeting Time": adPost.time,
      "Unit Area": adPost.unitArea,
      "Property Size": adPost.propertySize,
      "Image Urls": adPost.ImageUrls,

      "Main Features": {
        "Build year": adPost.buildyear,
        "Parking space": adPost.ParkingSpace,
        "Rooms": adPost.Rooms,
        "Floors":adPost. Floors,
        "Flooring": adPost.Flooring,
        "Elevators": adPost.Elevators,
        "Maintenance Staff":adPost. MaintenanceStaff,
        "Security Staff": adPost.Security,
        "Waste disposal": adPost.WasteDisposal
      },
      "email": firebaseUser.email,
      "uid": firebaseUser.uid,
    });
  }

 getCordinatesOfAds() async{
    return await firestoreInstance.collection("PostAdd").snapshots();
  }

}
