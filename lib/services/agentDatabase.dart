import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup/models/AgentUser.dart';
import '../models/user.dart';
import 'package:signup/models/user.dart';

class AgentDatabase{
  final Firestore _firestore = Firestore.instance;

  Future<String> createUser(AgentUser user) async{
    String retVal ='error';
    try{
      await _firestore.collection('agentRequest').document(user.uid).setData({
        'firstName' : user.firstName,
        'title' : user.title,
        'age' : user.age,
        'location' : user.location,
        'description' : user.description,
        'phoneNumber' : user.phoneNumber,
        'email' : user.email,
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

  Future<AgentUser> getUserInfo(String uid) async{
    AgentUser retVal = AgentUser();
    try{
      //DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
      DocumentSnapshot _docSnapshot = await _firestore.collection("agentRequest").document(uid).get();
      retVal.uid = uid;
      //retVal.firstName= _docSnapshot.data('firstName');
      retVal.firstName = _docSnapshot.data["firstName"];
    //  retVal.lastName = _docSnapshot.data["lastName"];
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
//  Future<OurUser> getUser(String uid) async {
//    OurUser retVal;
//
//    try {
//      DocumentSnapshot _docSnapshot =
//      await _firestore.collection("users").document(uid).get();
//      retVal = OurUser.fromDocumentSnapshot(doc: _docSnapshot);
//    } catch (e) {
//      print(e);
//    }
//
//    return retVal;
//  }
}