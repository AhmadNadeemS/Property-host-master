import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:signup/helper/constants.dart';
import 'package:signup/helper/helperfunctions.dart';
import 'package:signup/helper/theme.dart';
import 'package:signup/chat/chat.dart';
import 'package:signup/chat/search.dart';
import 'package:flutter/material.dart';
import 'package:signup/services/chatDatabase.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();

}

class _ChatRoomState extends State<ChatRoom> {

  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    String data =
        "https://thumbs.dreamstime.com/b/user-profile-avatar-icon-134114292.jpg";
    getUserInfogetChats();
  }

  String userid;
  /*initUser() async {
    user = await _auth.currentUser();
    if (user != null) {
      userid = user.uid;
    } else {
      print("user.uid");
      // User is not available. Do something else
    }
    setState(() {});
  }*/

  Stream chatRooms;
  Stream chats;


  Widget chatRoomsList(){
    return StreamBuilder(
        stream: chatRooms,
        builder: (context, snapshot) {
          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {

                return StreamBuilder(
                    stream: Firestore.instance.collection("chatRoom").document(snapshot.data.documents[index].data["chatRoomId"]).collection("Chats").orderBy("time",descending: true).limit(1).snapshots(),
                    builder: (context, snapshot1) {
                      return snapshot1.hasData ? ListView.builder(
                          itemCount: snapshot1.data.documents.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index1) {
                            return  ChatRoomsTile(
                              userName:snapshot.data.documents[index].data['chatRoomId'].toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                              chatRoomId: snapshot.data.documents[index].data["chatRoomId"].toString(),
                              message: snapshot1.data.documents[index1]["message"].toString(),
                              Time:snapshot1.data.documents[index1]["time"],
                            );
                          }):Container();

                    });
              }):Container();
        });

  }

  /*Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                userName:snapshot.data.documents[index].data['chatRoomId'].toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                chatRoomId: snapshot.data.documents[index].data["chatRoomId"].toString(),
              );
            })
            : Container();
      },
    );
  }*/



  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    chatdatabase().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        //backgroundColor: Color(0xff453658),
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Inbox"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.4),
                Colors.black.withOpacity(.2),
              ]),
            ),
          ),
        ),
        body: Container(height:MediaQuery.of(context).size.height,decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xff213A50),
                  const Color(0xff071930)
                ],
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft)),child: chatRoomsList())
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String message;
  final int Time;

  ChatRoomsTile({this.userName,@required this.chatRoomId,@required this.message,@required this.Time});



  @override
  Widget build(BuildContext context) {
    String data = "https://thumbs.dreamstime.com/b/user-profile-avatar-icon-134114292.jpg";
    //var date = DateFormat.format(Time.toString());
    //var date = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(Time);
    var formattedDate = DateFormat.yMMMd().format(date);
    //var formattedDate2 = DateFormat.yMMMd().format(date);
    var formattedDate2 = DateFormat.Hm().format(date);

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Chat(
              chatRoomId: chatRoomId,userName: userName,
            )
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
//
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.all(Radius.circular(40)),
//            border: Border.all(
//              width: 1,
//              color: Theme.of(context).primaryColor,
//            ),
            // shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),

    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(data),
                radius: 20.0,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      message,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.lightBlueAccent
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [

                  Text(
                    " " + formattedDate2.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    " " + formattedDate.toString(),
                    style: TextStyle( fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,),
                  ),
                ],
              ),

              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
