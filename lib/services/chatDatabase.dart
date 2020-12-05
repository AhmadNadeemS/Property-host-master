import 'package:cloud_firestore/cloud_firestore.dart';

class chatdatabase {


  getUserInfo(String email) async {
    return Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  removeChat({String chatRoomId, String messageId}) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("Chats")
        .document(messageId)
        .delete();
  }

  removePost(String PostId) async{
   await Firestore.instance
        .collection("PostAdd")
        .document(PostId)
        .delete();

    print("Post deleted with id" + PostId);

  }


  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('displayName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async{
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("Chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData){

    Firestore.instance.collection("chatRoom")
        .document(chatRoomId)
        .collection("Chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await Firestore.instance.collection("chatRoom").where('users', arrayContains: itIsMyName).snapshots();
  }

}
