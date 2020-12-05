import 'package:signup/helper/constants.dart';
import 'package:signup/services/chatDatabase.dart';
import 'package:signup/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String userName;

  Chat({this.chatRoomId,this.userName});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  Stream<QuerySnapshot> chats;

  TextEditingController messageEditingController = new TextEditingController();



  Widget chatMessages(){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        //print(snapshot.data.documents.length);
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.documents[index].data["message"].toString(),
                sendByMe: Constants.myName == snapshot.data.documents[index].data["sendBy"],
                chatRoomId:widget.chatRoomId,
                messageId: snapshot.data.documents[index].data["messageId"].toString(),
              );
            }) : Container();
      },
    );
  }



  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
      };

      chatdatabase().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  void initState(){
    getChat();
    super.initState();
  }



  getChat() async{

    print(widget.chatRoomId + " it is in getchat before going to database");
    await chatdatabase().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
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
      //appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(alignment: Alignment.bottomCenter,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageEditingController,
                          style: simpleTextStyle(),
                          decoration: InputDecoration(
                              filled: true,
                              hintText: "Message ...",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              border: InputBorder.none
                          ),
                        )),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/send.png'),
                              //fit: BoxFit.fill,
                            ),
                            // shape: BoxShape.circle,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String chatRoomId;
  final String messageId;

  MessageTile({@required this.message, @required this.sendByMe,@required this.chatRoomId,@required this.messageId});


  @override
  Widget build(BuildContext context) {
    debugPrint(sendByMe.toString());

    return Container(
        padding: EdgeInsets.only(
            top: 6,
            bottom: 6,
            left: sendByMe ? 0 : 24,
            right: sendByMe ? 24 : 0),
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(
              top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: sendByMe ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23)
              ) :
              BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
              gradient: LinearGradient(
                colors: sendByMe ? [
                  const Color(0xff007EF4),
                  const Color(0xff2A75BC)
                ]
                    : [
                  Colors.black,
                  Colors.black54
                ],
              )
          ),

          child: Column(children: <Widget>[
            GestureDetector(
              onTap: () {
                print("On message tap" + messageId);
                //   _moreMessageOptions(context);
              },
              child: Text(message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      //   backgroundColor:Colors.black,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            )
          ]),
        ));
  }


  Future<void> _moreMessageOptions(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(
              'Click Delete message to permanently delete the message'),
          actions: <Widget>[
            FlatButton(
              child: Text('Delete Message'),
//              onPressed: () {
//                chatdatabase().removeChat(chatRoomId: chatRoomId, messageId: messageId);
//                Navigator.of(context).pop();
//              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

