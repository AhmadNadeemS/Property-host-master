import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup/models/AgentUser.dart';

class AgentDatabase{
  final Firestore _firestore = Firestore.instance;

  Future<String> ApplyForAgent(AgentUser user) async {
    String retVal = 'error';
    try {
      await _firestore.collection('agentRequest').document(user.uid).setData({
        'displayName': user.Name,
        'Address': user.address,
        'description': user.description,
        'phoneNumber': user.phoneNumber,
        'email': user.email,
        'image':user.image,
        //    'image':user.image,
        'User Type': "user",

        //    'accountCreated' : Timestamp.now(),
      });
      retVal='Success';
    }
    catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<AgentUser> getUserInfo(String uid) async{
    AgentUser retVal = AgentUser();
    try {
      DocumentSnapshot _docSnapshot =
      await _firestore.collection("agentRequest").document(uid).get();
      retVal.uid = uid;
      retVal.Name = _docSnapshot.data["firstName"];
      retVal.email = _docSnapshot.data['email'];
      retVal.phoneNumber = _docSnapshot.data['phoneNumber'];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
      retVal.UserType = _docSnapshot.data["User Type"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }

}