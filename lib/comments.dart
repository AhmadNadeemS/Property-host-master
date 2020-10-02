import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:signup/AppLogic/validation.dart';

//import 'package:signup/AppLogic/validation.dart';
import 'package:signup/activity_feed.dart';
import 'package:signup/header.dart';
import 'package:signup/progress.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatefulWidget {
  final String postId;

  //final String postOwnerId;
  final String image;

  Comments({
    this.postId,
    //this.postOwnerId,
    this.image,
  });

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final StorageReference storageRef = FirebaseStorage.instance.ref();
  final usersRef = Firestore.instance.collection('users');
  final postsRef = Firestore.instance.collection('posts');

  final DateTime timestamp = DateTime.now();

  //User currentUser;

  @override
  CommentsState createState() => CommentsState(
        postId: this.postId,
        //postOwnerId: this.postOwnerId,
        //postMediaUrl: this.image,
      );
}

class CommentsState extends State<Comments> {
  bool isAdmin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  FirebaseUser user;
  String data =
      "https://thumbs.dreamstime.com/b/user-profile-avatar-icon-134114292.jpg";
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    initUser();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

//  final List<Color> circleColors = [Colors.red, Colors.blue, Colors.green];
//
//  Color randomGenerator() {
//    return circleColors[new Random().nextInt(2)];
//  }
  //List colors = [Colors.red, Colors.green, Colors.yellow];
  //Random random = new Random();
  var items = ['⭐', '⭐⭐', '⭐⭐⭐', '⭐⭐⭐⭐', '⭐⭐⭐⭐⭐'];
  //int index = 0;
  GlobalKey<FormState> _key = new GlobalKey();
  //final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _validate = false;

//  void changeIndex() {
//    setState(() => index = random.nextInt(3));
//  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  //final retrieve = Firestore.instance.collection('users').where("role", isEqualTo: "other").snapshots();
  TextEditingController commentController = TextEditingController();
  final TextEditingController _controller = new TextEditingController();
  final String postId;

  //final String postOwnerId;
  //final String postMediaUrl;

  CommentsState({
    this.postId,
    // this.postOwnerId,
//    this.postMediaUrl,
  });

  buildComments() {
    final commentsRef = Firestore.instance.collection('comments');
    return StreamBuilder(
        stream: commentsRef
            .document(postId)
            .collection('comments')
            //.orderBy("timestamp", descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          List<Comment> comments = [];
          snapshot.data.documents.forEach((doc) {
            comments.add(Comment.fromDocument(doc));
          });
          return ListView(
            children: comments,
          );
        });
  }

  addComment() {
    final commentsRef = Firestore.instance.collection('comments');
    commentsRef.document(postId).collection("comments").add({
      "username": user.email,
      "comment": commentController.text,
      "timestamp": widget.timestamp,
      "avatarUrl": data,
      "userId": user.uid,
      'Rate': _controller.text,
    });
    print("data$data");
    //String data =postId;

    // Navigator.push(context, MaterialPageRoute(builder: (context)=> ActivityFeed(data: data,)));

    final activityFeedRef = Firestore.instance.collection('feed');
    activityFeedRef.document(postId).collection('feedItems').add({
      "type": "comment",
      "commentData": commentController.text,
      "timestamp": widget.timestamp,
      "postId": postId,
      "username": user.email,
      "comment": commentController.text,
      // ignore: equal_keys_in_map
      "timestamp": widget.timestamp,
      "avatarUrl": data,
      //"avatarUrl": colors,
      "userId": user.uid,
    });

    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    bool _sendToServer() {
      if (_key.currentState.validate()) {
        // No any error in validation
        _key.currentState.save();
        return true;
      } else {
        // validation error
        setState(() {
          _validate = true;
          return false;
        });
      }
    }

    return Form(
      //key: scaffoldKey,
      key: _key,
      child:
          //  appBar: header(context, titleText: "Comments"),
          Scaffold(
        body: Column(
          children: <Widget>[
            // ignore: unrelated_type_equality_checks
            Expanded(child:buildComments()),
            Divider(),
            Card(
              child: Column(
                children: [

                  Container(
                    margin: EdgeInsets.only(left: 16, right: 110),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IntrinsicWidth(
                          child: TextFormField(
                            focusNode: myFocusNode,
                            maxLines: 1,
                            controller: _controller,
                            keyboardType: TextInputType.text,
                            validator: validateStars,
                            readOnly: true,
                            autofocus: false,
                            decoration: InputDecoration(
//    prefixIcon: Icon(
//    //Icons.title,
//    color: Colors.grey[800],
//    ),
                              hintText: "Give Stars",
                            ),
                          ),
                        ),
                        //TextField(decoration: InputDecoration( hintText: "Give Stars"),controller: _controller,)),

                        PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            _controller.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return items
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      focusNode: myFocusNode,
                      validator: ValidateComment,
                      //(text){
//                          if(text==null||text.isEmpty){
//                            return 'Text is Empty';
//                          }
//                          return null;
//                        },
                      controller: commentController,
                      decoration:
                      InputDecoration(labelText: "Write a comment..."),
                    ),
                    trailing: OutlineButton(
//onPressed: addComment,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        //print('VAlue${_sendToServer()}');
                        if (_key.currentState.validate()) {
                          addComment();
                          _validate = false;
                          return true;
                        }
                        _controller.clear();
                        commentController.clear();
                      },

                      // addComment,
                      borderSide: BorderSide.none,
                      child: Text("Post"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final String rating;
  final Timestamp timestamp;

  //Timestamp accountCreated;

  Comment({
    this.username,
    this.userId,
    this.avatarUrl,
    this.comment,
    this.rating,
    this.timestamp,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      userId: doc['userId'],
      comment: doc['comment'],
      rating: doc['Rate'],
      timestamp: doc['timestamp'],
      avatarUrl: doc['avatarUrl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            comment,
            style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
          ),
          leading: CircleAvatar(
            //backgroundImage: NetworkImage(w),
            // backgroundColor: Colors.blueGrey,
            backgroundImage: CachedNetworkImageProvider(avatarUrl.toString()),
          ),
          // subtitle: Text(username),
          //subtitle: Text(accountCreated.toString()),
          subtitle: Text(
            username.toUpperCase(),
            style: TextStyle(fontSize: 8, color: Colors.grey),
          ),
          //trailing: Text(timeago.format(timestamp.toDate())),
          trailing: Text(rating,style: TextStyle(fontSize: 12),),
        ),
        Divider(),
      ],
    );
  }

}
