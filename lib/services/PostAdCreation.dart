
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostAddFirebase{

  final firestoreInstance = Firestore.instance;

  void CreatePostAddHomes(
      String title,
      String desc,
      int price,
      String City,
      String AvailDays,
      String time,
      String unitArea,
      String location,
      String purpose,
      String propertyType,
      String propertyDeatil,
      String Buildyear,
      String ParkingSpace,
      String Rooms,
      String bathrooms,
      String Kitchens,
      String Floors,
      String propertySize,
      List ImageUrls) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").add({
      "Title": title,
      "Description": desc,
      "Price": price,
      "Image Urls": ImageUrls,
      "Address": {"location": location, "city": City},
      "Available Days": AvailDays,
      "Purpose": purpose,
      "Property Type": propertyType,
      "Property SubType": propertyDeatil,
      "Meeting Time": time,
      "Unit Area": unitArea,
      "Property Size": propertySize,
      "Main Features": {
        "Build year": Buildyear,
        "Parking space": ParkingSpace,
        "Rooms": Rooms,
        "Bathrooms": bathrooms,
        "kitchens": Kitchens,
        "Floors": Floors,
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

  void CreatePostAddHomesPentHouse(
      String title,
      String desc,
      int price,
      String City,
      String AvailDays,
      String time,
      String unitArea,
      String location,
      String purpose,
      String propertyType,
      String propertyDeatil,
      String propertySize,
      List ImageUrls) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").add({
      "Title": title,
      "Description": desc,
      "Price": price,
      "Image Urls": ImageUrls,
      "Address": {"location": location, "city": City},
      "Available Days": AvailDays,
      "Purpose": purpose,
      "Property Type": propertyType,
      "Property SubType": propertyDeatil,
      "Meeting Time": time,
      "Unit Area": unitArea,
      "Property Size": propertySize,
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

  void CreatePostAddPlots(
      String title,
      String desc,
      int price,
      String City,
      String AvailDays,
      String time,
      String unitArea,
      String location,
      String purpose,
      String propertyType,
      String propertyDeatil,
      bool possesion,
      bool ParkingSpace,
      bool corners,
      bool disputed,
      bool balloted,
      bool suiGas,
      bool waterSupply,
      bool sewarge,
      String propertySize,
      List ImageUrls) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").add({
      "Title": title,
      "Description": desc,
      "Price": price,
      "Address": {"location": location, "city": City},
      "Available Days": AvailDays,
      "Purpose": purpose,
      "Property Type": propertyType,
      "Property SubType": propertyDeatil,
      "Meeting Time": time,
      "Unit Area": unitArea,
      "Property Size": propertySize,
      "Image Urls": ImageUrls,
      "Main Features": {
        "Possession": possesion,
        "Park facing": ParkingSpace,
        "Disputed": disputed,
        "Balloted": balloted,
        "Corner": corners,
        "sui gas": suiGas,
        "water supply": waterSupply,
        "Sewarege": sewarge,
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

  void CreatePostAddCommerical(
      String title,
      String desc,
      int price,
      String City,
      String AvailDays,
      String time,
      String unitArea,
      String location,
      String purpose,
      String propertyType,
      String propertyDeatil,
      String buildyear,
      String Rooms,
      String ParkingSpace,
      String Floors,
      String Flooring,
      bool Elevators,
      bool MaintenanceStaff,
      bool Security,
      bool WasteDisposal,
      String PropertySize,
      List ImageUrls) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("PostAdd").add({
      "Title": title,
      "Description": desc,
      "Price": price,
      "Address": {"location": location, "city": City},
      "Available Days": AvailDays,
      "Purpose": purpose,
      "Property Type": propertyType,
      "Property SubType": propertyDeatil,
      "Meeting Time": time,
      "Unit Area": unitArea,
      "Property Size": PropertySize,
      "Image Urls": ImageUrls,
      "Main Features": {
        "Build year": buildyear,
        "Parking space": ParkingSpace,
        "Rooms": Rooms,
        "Floors": Floors,
        "Flooring": Flooring,
        "Elevators": Elevators,
        "Maintenance Staff": MaintenanceStaff,
        "Security Staff": Security,
        "Waste disposal": WasteDisposal
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




}
