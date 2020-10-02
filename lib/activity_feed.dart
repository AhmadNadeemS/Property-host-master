import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signup/header.dart';
import 'package:signup/progress.dart';
import 'dart:developer';
import 'package:timeago/timeago.dart' as timeago;
import 'package:signup/states/currentUser.dart';

class ActivityFeed extends StatefulWidget {
  static const routeName = '/activityFeed';
//  final String data;
//
//  ActivityFeed({Key key, this.data});

  //const ActivityFeed({Key key, this.data}) : super(key: key);

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  //final String data;
  //String postId;
  final activityFeedRef = Firestore.instance.collection('feed');

 // _ActivityFeedState({this.data});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  FirebaseUser user;

  @override
  void initState() {

    super.initState();
//print(user.uid);
    initUser();
  }
  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }
 // _ActivityFeedState({this.postId});
  getActivityFeed() async {
    //final data = ModalRoute.of(context).settings.arguments as String;
    QuerySnapshot snapshot = await activityFeedRef
        .document(user.uid)
        .collection('feedItems')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .getDocuments();
//    snapshot.documents.forEach((doc) {
//      print('Activity Feed Item: ${doc.data}');
//    });
//    return snapshot.documents;
    List<ActivityFeedItem> feedItems = [];
    snapshot.documents.forEach((doc) {
      feedItems.add(ActivityFeedItem.fromDocument(doc));
       print('Activity Feed Item: ${doc.data}');
    });
    return feedItems;
  }

  @override
  Widget build(BuildContext context) {
    //final dataOne = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('My Feed'),),
      body: user != null ? Container(
          child: FutureBuilder(
            future: getActivityFeed(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return circularProgress();
              }
              // print('imp2${user.uid}');
              return ListView(
                  children: snapshot.data);
            },
          )) : Text('Trying'),

    );
  }}

Widget mediaPreview;
String activityItemText;

class ActivityFeedItem extends StatelessWidget {
  final String username;
 // final String userId;
  final String type; // 'like', 'follow', 'comment'
//  final String mediaUrl;
 // final String postId;
  final String userProfileImg;
  final String commentData;
 // final Timestamp timestamp;

  ActivityFeedItem({
    this.username,
 //   this.userId,
    this.type,
  //  this.mediaUrl,
  //  this.postId,
    this.userProfileImg,
    this.commentData,
  //  this.timestamp,
  });

  factory ActivityFeedItem.fromDocument(DocumentSnapshot doc) {
    return ActivityFeedItem(
      username: doc['username'],
    //  userId: doc['userId'],
      type: doc['type'],
    //  postId: doc['postId'],
        userProfileImg: doc['avatarUrl'],
      commentData: doc['commentData'],
   //   timestamp: doc['timestamp'],
   //   mediaUrl: doc['image'],
    );
  }

  configureMediaPreview() {
    if (type == 'comment') {
      mediaPreview = GestureDetector(
        onTap: () => print('showing post'),
        child: Container(
          height: 50.0,
          width: 50.0,
//          child: AspectRatio(
//              aspectRatio: 16 / 9,
//              child: Container(
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    fit: BoxFit.cover,
//                    image: CachedNetworkImageProvider(userProfileImg),
//                  ),
//                ),
//              )),
        ),
      );
    } else {
      mediaPreview = Text('');
    }

//    if (type == 'like') {
//      activityItemText = "liked your post";
//    } else if (type == 'follow') {
//      activityItemText = "is following you";
//    } else
          if (type == 'comment') {
      activityItemText = 'Rated by : $username';
    } else {
      activityItemText = "Error: Unknown type '$type'";
    }
  }

  @override
  Widget build(BuildContext context) {
    configureMediaPreview();

    return Card(
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.0),
        child: Container(
          color: Colors.white54,
          child: ListTile(
            title: GestureDetector(
              onTap: () => print('show profile'),
              child: Column(
                children: [

//            RichText(
//            overflow: TextOverflow.ellipsis,
//              text: TextSpan(
//                style: TextStyle(
//                  fontSize: 14.0,
//                  color: Colors.black,
//                ),
//                children: [
//                  TextSpan(
//                    text: username,
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  )
//
//                  ],
//              ),
//            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: commentData.toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 7.0,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: ' $activityItemText',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                    ],
                  ),

//                RichText(
//                  overflow: TextOverflow.ellipsis,
//                  text: TextSpan(
//                      style: TextStyle(
//                        fontSize: 14.0,
//                        color: Colors.black,
//                      ),
//                      children: [
//                        TextSpan(
//                          text: commentData,
//                          style: TextStyle(fontWeight: FontWeight.bold),
//                        ),
//                        TextSpan(
//                          text: username,
//                          style: TextStyle(fontWeight: FontWeight.bold),
//                        ),
//
//                        TextSpan(
//                          text: ' $activityItemText',
//                        ),
//                      ]),
//                ),

            ),
            leading: CircleAvatar(
             backgroundImage: CachedNetworkImageProvider(userProfileImg.toString()),
              //backgroundColor: Colors.grey,
            ),
       //     subtitle: Text(
 //           timeago.format(timestamp.toDate()),
   //         overflow: TextOverflow.ellipsis,
         //   ),
            //trailing: mediaPreview,
          ),
        ),
      ),
    );
  }
}
