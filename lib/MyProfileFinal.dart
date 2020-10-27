import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signup/Arguments.dart';
import 'package:signup/ImageCarousel.dart';

import 'package:signup/comments.dart';

// ignore: must_be_immutable
class MyProfileFinal extends StatefulWidget {
  static const routeName = '/myProfileFinal';
  String uid;

  MyProfileFinal({this.uid});

  String image;

  @override
  _MyProfileStateFinal createState() => _MyProfileStateFinal(
    uid: this.uid,
  );
}

class _MyProfileStateFinal extends State<MyProfileFinal> {
  final reviewKey = GlobalKey<ScaffoldState>();

  String uid;

  final String _listings = "Listings";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAdmin = true;

  _MyProfileStateFinal({this.uid});

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    // CurrentUser _current = Provider.of<CurrentUser>(context, listen: false);

    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _showContact(context));

    // Size screenSize = MediaQuery.of(context.size;
    final data = ModalRoute
        .of(context)
        .settings
        .arguments as String;

    //  CurrentUser _current = Provider.of<CurrentUser>(context,listen: false);
    //_current.updateStateFromDatabase(data,_current.getCurrentUser.uid);

    return SafeArea(
      child: Scaffold(
          key: reviewKey,
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('Agent Profile'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.4),
                  Colors.black.withOpacity(.2),
                ]),
//                gradient: LinearGradient(
//                  colors: [Colors.deepPurple, Color(0xff2470c7)],
//                  stops: [0.5, 1.0],
//                ),
              ),
            ),
            centerTitle: true,
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.notifications),
//            onPressed: () {
//              Navigator.pushNamed(context, "/activityFeed");
//            },
//          )
//        ],
            //backgroundColor: Colors.blueAccent,
            elevation: 0.0,
          ),
          body: user != null
              ? Container(
            child: StreamBuilder(
              stream: Firestore.instance.collection('users').where(
                  "User Type", isEqualTo: data).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: <Widget>[
                          SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  //              _buildProfileImage(),
                                  Center(
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data.documents
                                              .elementAt(index)['image']),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(50.0),
                                        border: Border.all(
                                          color: Colors.black26,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //_buildFullName(),
                                  Text(
                                    snapshot.data.documents
                                        .elementAt(index)['displayName'],
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  //    _buildStatus(context),
//                                  Container(
//                                    padding: EdgeInsets.symmetric(
//                                        vertical: 4.0, horizontal: 6.0),
//                                    decoration: BoxDecoration(
//                                      color: Theme
//                                          .of(context)
//                                          .scaffoldBackgroundColor,
//                                      borderRadius: BorderRadius.circular(4.0),
//                                    ),
//                                    child: Text(
//                                      snapshot.data.documents.elementAt(index)['title'],
//                                      style: TextStyle(
//                                        fontFamily: 'Spectral',
//                                        color: Colors.black,
//                                        fontSize: 20.0,
//                                        fontWeight: FontWeight.w300,
//                                      ),
//                                    ),
//                                  ),
                                  SizedBox(height: 10.0),
                                  //       _buildBio(context),
                                  Container(
                                    width: 270,
                                    //color: Colors.white,
                                    child: Text(
                                      snapshot.data.documents.elementAt(
                                          index)['description'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Spectral',
                                        fontWeight: FontWeight.w400,
                                        //try changing weight to w500 if not thin
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[600],
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  //       _buildpropertyStatus(context),
                                  Container(
                                    //color: Colors.grey[500],
                                    color: Colors.teal[700],
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4.0,
                                              horizontal: 6.0),
                                          child: Text(
                                            _listings,
                                            style: TextStyle(
                                              fontFamily: 'Spectral',
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // _buildPropertyList(),
                                  Container(
                                      margin: EdgeInsets.only(top: 15),
                                      height: 160,
                                      child: StreamBuilder(
                                          stream: Firestore.instance.collection(
                                              "PostAdd")
                                              .where("uid",
                                              isEqualTo: snapshot.data
                                                  .documents[index].documentID)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              snapshot1) {
                                            if (snapshot1.hasData) {
                                              return ListView.builder(
                                                scrollDirection:
                                                Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: snapshot1.data
                                                    .documents.length,
                                                // ignore: missing_return
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(
                                                          context)
                                                          .pushNamed(
                                                          ImageCarousel
                                                              .routeName,
                                                          arguments: ScreenArguments(
                                                              snapshot1.data
                                                                  .documents[index]
                                                                  .documentID
                                                                  .toString(),
                                                              snapshot1.data
                                                                  .documents[index]
                                                                  .data['uid']
                                                                  .toString())
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 160.0,
                                                      //height: 220,
                                                      child: Card(
                                                        child: Wrap(
                                                          children: <
                                                              Widget>[
                                                            Container(
                                                              height: 110,
                                                              width: double
                                                                  .infinity,
                                                              child: Image
                                                                  .network(
                                                                snapshot1
                                                                    .data
                                                                    .documents[
                                                                index]
                                                                    .data['Image Urls'][0],
                                                                loadingBuilder: (
                                                                    BuildContext context,
                                                                    Widget
                                                                    child,
                                                                    ImageChunkEvent
                                                                    loadingProgress) {
                                                                  if (loadingProgress ==
                                                                      null)
                                                                    return child;
                                                                  return Center(
                                                                    child:
                                                                    CircularProgressIndicator(
                                                                      value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                          null
                                                                          ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                          loadingProgress
                                                                              .expectedTotalBytes
                                                                          : null,
                                                                    ),
                                                                  );
                                                                },
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .blue[100],
                                                                        Colors
                                                                            .green[100]
                                                                      ],
                                                                      begin:
                                                                      FractionalOffset
                                                                          .centerRight,
                                                                      end: FractionalOffset
                                                                          .centerLeft)),
                                                              //color: Colors
                                                              //.grey,
                                                              child:
                                                              ListTile(
                                                                title:
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                      12),
                                                                  child:
                                                                  Text(
                                                                    snapshot1
                                                                        .data
                                                                        .documents[index]
                                                                        .data['Title']
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                    style: TextStyle(
                                                                        fontSize: 13,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily: 'Overpass'),
                                                                    //style: TextStyle(fontStyle: F),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          } //builder

                                      )),
                                  // ads stream builder ends here
                                  //   _showReviewForm(),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          //                    color: Colors.blue,
                                          color: Colors.teal[700],
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          height: 25,
                                          child: Center(
                                            child: Text(
                                              'User Reviews',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Click Icon for Reviews',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              showComments(
                                                context,
                                                postId: snapshot
                                                    .data.documents
                                                    .elementAt(index)['uid'],
                                                //ownerId: ownerId,
                                                //     mediaUrl: snapshot.data.documents.elementAt(index)['image'],
                                              ),
                                          child: Icon(
                                            Icons.chat,
                                            size: 28.0,
                                            color: Colors.blue[900],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          //color: Colors.grey[500],
                                          color: Colors.teal[700],
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          height: 25,
                                          child: Center(
                                            child: Text(
                                              'Personal Information',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //    _showPersonalInformation(context),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  Container(
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(40.0),
//                                      color: Colors.black54,
//
//                                    ),
                                    margin: EdgeInsets.only(
                                        left: 14, right: 14, bottom: 10),
                                    padding: EdgeInsets.all(10),

                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          //color: Colors.grey[400],
                                          //color: Colors.grey[200],
                                          //color: Colors.black38,
                                          //color: Colors.blue[200],
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.only(
                                                  topLeft: Radius
                                                      .circular(20),
                                                  topRight:
                                                  Radius.circular(
                                                      20)),
                                              color: Colors.blue[200],
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.blue[300],
                                                  style:
                                                  BorderStyle.solid)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Name: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .black54,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Text(
                                                  snapshot.data.documents
                                                      .elementAt(
                                                      index)[
                                                  'displayName'],
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black87),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          //color: Colors.grey[200],
                                          //color: Colors.blue[200],
                                          decoration: BoxDecoration(
                                            //  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),color: Colors.blue[200],
                                              color: Colors.blue[200],
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.blue[300],
                                                  style:
                                                  BorderStyle.solid)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Age: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .black54,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Text(
                                                  snapshot.data.documents
                                                      .elementAt(
                                                      index)['age'],
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black87),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          //color: Colors.grey[400],
                                          color: Colors.blue[200],
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Address: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .black54,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Flexible(
                                                    child: Text(
                                                      snapshot.data.documents
                                                          .elementAt(
                                                          index)[
                                                      'address'],
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black87),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          //color: Colors.grey[200],
                                          // color: Colors.blue[200],
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.only(
                                                  bottomLeft: Radius
                                                      .circular(20),
                                                  bottomRight:
                                                  Radius.circular(
                                                      20)),
                                              color: Colors.blue[200],
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.blue[300],
                                                  style:
                                                  BorderStyle.solid)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Cell No: ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .black54,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Text(
                                                  snapshot.data.documents
                                                      .elementAt(
                                                      index)[
                                                  'phoneNumber'],
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black87),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //   _editProfileButton(),

                                  /*user.uid ==
                                                snapshot.data.documents
                                                    .elementAt(index)['uid']
                                            ? Container(
                                                child: Center(
                                                  child: FlatButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/AgentSignup');
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[800],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                        child: Text(
                                                          "Edit Profile",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),*/
                                  SizedBox(height: 8.0),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  debugPrint('Loading...');
                  return Center(
                    child: Text('Loading...'),
                  );
                }
              },
            ),
          )
              : Center(child: Text("Error"))),
    );
  }

  Widget _showContact(BuildContext context) {
    return Container();
  }
}

showComments(BuildContext context, {String postId}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
      postId: postId,
      //postOwnerId: ownerId,
      //   image: mediaUrl,
    );
  }));
}
