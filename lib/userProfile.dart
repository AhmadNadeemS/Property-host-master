import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/comments.dart';

class UserProfile extends StatefulWidget {
  final bool isAgent;

  const UserProfile({Key key, this.isAgent}) : super(key: key);
  //final String data;
  //static const routeName = '/UserProfile';
  //const MyProfileFinal({Key key, this.data}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState(this.isAgent);
}

class _UserProfileState extends State<UserProfile> {
  //final String _fullName = "Ali Qureshi";
  //final String data;
  //final String _status = "Property Dealer";

  final String _listings = "Listings";

  //final String _bio ="\"Hi, I am a Property Dealer.If you need property suitbale for your needs. You can contact me.\"";

  int _rating = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isAgent = true;

  _UserProfileState(this.isAgent);

  //_MyProfileStateFinal(this.data);



  //bool isAdmin = false;
  Future<String> currentUser() async {
    user = await _auth.currentUser();
    return user != null ? user.uid : null;
  }

  FirebaseUser user;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  String userid;

  initUser() async {
    user = await _auth.currentUser();
    if (user != null) {
      userid = user.uid;
      print(widget.isAgent);
    } else {
      print("user.uid");
      // User is not available. Do something else
    }
    setState(() {});
  }

  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _showContact(context));

    // Size screenSize = MediaQuery.of(context.size;
    //final data = ModalRoute.of(context).settings.arguments as String;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('My Profile'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.4),
                  Colors.black.withOpacity(.2),
                ]),
              ),
            ),
            centerTitle: true,
            actions: <Widget>[

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      //Image.asset('assets/index.jpg', fit: BoxFit.cover,height:16,width:16),
                      Container(
                          margin: new EdgeInsets.only(left: 130),
                          child: Text(
                            'My Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          )),

                      user != null
                          ? StreamBuilder(
                          stream: Firestore.instance
                              .collection('users')
                              .where("uid", isEqualTo: userid)
                              .snapshots(),

                          // ignore: missing_return
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.active) {
                              return Expanded(
                                child: ListView.builder(
                                    itemCount: snapshot.data.documents.length,
                                    // ignore: missing_return
                                    itemBuilder: (BuildContext context, int index) {
                                      // String Data = snapshot.data.documents.elementAt(
                                      //index)['displayName'];
                                      // String Result = Data.substring(0, Data.lastIndexOf(" "));
                                      //var text = Data.substring(Result, Data.lastIndexOf('') - Result);
                                      //String ret = Result[0] +""+ Result[1];
                                      //print("Error");
                                      return snapshot
                                          .data.documents.elementAt(index)['User Type']=="Agent"
                                          ?
                                                     IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushNamed(context, "/activityFeed");
                },
              )
                                          : Container();
                                    }
                                ),
                              );
                            }
                            else if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(child: Center(child: CircularProgressIndicator()));
                              //return CircularProgressIndicator();
                              //final userDocument = snapshot.data;
                              //final title=  snapshot.data.userocument['displayName']);
                              //CircularProgressIndicator();

                            }
                          })
                          : Container(),
                    ],
                  ),
                ),

//               IconButton(
//                icon: Icon(Icons.notifications),
//                onPressed: () {
//                  Navigator.pushNamed(context, "/activityFeed");
//                },
//              )
            ],
            backgroundColor: Colors.grey[800],
            elevation: 0.0,
          ),
          body: user !=null ? Container(
            child: StreamBuilder(
              stream: Firestore.instance.collection('users').where("uid", isEqualTo:user.uid).snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                  //              _buildProfileImage(),
                                  SizedBox(height: 20.0),
                                  //              _buildProfileImage(),
                                  snapshot
                                      .data.documents
                                      .elementAt(index)['image'] !=null ?Center(
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
                                  ):Container(

                                    width: 100,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 6.0,
                                      ),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: Image.network("https://thumbs.dreamstime.com/b/user-profile-avatar-icon-134114292.jpg",
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.fill)),
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
//                                Container(
//                                  padding: EdgeInsets.symmetric(
//                                      vertical: 4.0, horizontal: 6.0),
//                                  decoration: BoxDecoration(
//                                    color: Theme
//                                        .of(context)
//                                        .scaffoldBackgroundColor,
//                                    borderRadius: BorderRadius.circular(4.0),
//                                  ),
//                                  child: Text(
//                                    snapshot.data.documents.elementAt(index)['title'],
//                                    style: TextStyle(
//                                      fontFamily: 'Spectral',
//                                      color: Colors.black,
//                                      fontSize: 20.0,
//                                      fontWeight: FontWeight.w300,
//                                    ),
//                                  ),
//                                ),
                                  SizedBox(height: 10.0),
                                  //       _buildBio(context),
                                  snapshot.data.documents.elementAt(
                                      index)['description'] !=null ? Container(
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
                                  ):Container(),
                                  SizedBox(height: 8.0),
//                                  //       _buildpropertyStatus(context),
//                                  Container(
//                                    //color: Colors.grey[500],
//                                    color: Colors.teal[700],
//                                    child: Row(
//                                      mainAxisAlignment:
//                                      MainAxisAlignment.center,
//                                      children: <Widget>[
//                                        Container(
//                                          padding: EdgeInsets.symmetric(
//                                              vertical: 4.0,
//                                              horizontal: 6.0),
//                                          child: Text(
//                                            _listings,
//                                            style: TextStyle(
//                                              fontFamily: 'Spectral',
//                                              color: Colors.white,
//                                              fontSize: 18.0,
//                                              fontWeight: FontWeight.bold,
//                                            ),
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  // _buildPropertyList(),
////                                  Container(
////                                    margin: EdgeInsets.only(top: 15),
////                                    height: 200,
////                                    child: ListView(
////                                      scrollDirection: Axis.horizontal,
////                                      children: <Widget>[
////                                        GestureDetector(
////                                          onTap: () {
////                                            Navigator.pushNamed(
////                                                context, '/AdDetail');
////                                          },
////                                          child: Container(
////                                            width: 160.0,
////                                            child: Card(
////                                              child: Wrap(
////                                                children: <Widget>[
////                                                  Container(
////                                                    height: 140,
////                                                    width: double.infinity,
////                                                    child: Image.asset(
////                                                      'assets/index.jpg',
////
////                                                      fit: BoxFit.cover,
////                                                    ),
////                                                  ),
////                                                  Container(
////                                                    color: Colors.grey,
////                                                    child: ListTile(
////                                                      title: Text(
////                                                        'heading',
////                                                        style: TextStyle(
////                                                            fontSize: 16,
////                                                            color: Colors
////                                                                .black),
////                                                      ),
//////                                                      subtitle: Text(
//////                                                        'subHeading',
//////                                                        style: TextStyle(
//////                                                            fontSize: 14, color: Colors.white),
//////                                                      ),
////                                                    ),
////                                                  ),
////                                                ],
////                                              ),
////                                            ),
////                                          ),
////                                        ),
////                                        GestureDetector(
////                                          onTap: () {
////                                            Navigator.pushNamed(
////                                                context, '/AdDetail');
////                                          },
////                                          child: Container(
////                                            width: 160.0,
////                                            child: Card(
////                                              child: Wrap(
////                                                children: <Widget>[
////                                                  Container(
////                                                    height: 140,
////                                                    width: double.infinity,
////                                                    child: Image.asset(
////                                                      'assets/index.jpg',
////
////                                                      fit: BoxFit.cover,
////                                                    ),
////                                                  ),
////                                                  Container(
////                                                    color: Colors.grey,
////                                                    child: ListTile(
////                                                      title: Text(
////                                                        'heading',
////                                                        style: TextStyle(
////                                                            fontSize: 16,
////                                                            color: Colors
////                                                                .black),
////                                                      ),
//////                                                      subtitle: Text(
//////                                                        'subHeading',
//////                                                        style: TextStyle(
//////                                                            fontSize: 14, color: Colors.white),
//////                                                      ),
////                                                    ),
////                                                  ),
////                                                ],
////                                              ),
////                                            ),
////                                          ),
////                                        ),       GestureDetector(
////                                          onTap: () {
////                                            Navigator.pushNamed(
////                                                context, '/AdDetail');
////                                          },
////                                          child: Container(
////                                            width: 160.0,
////                                            child: Card(
////                                              child: Wrap(
////                                                children: <Widget>[
////                                                  Container(
////                                                    height: 140,
////                                                    width: double.infinity,
////                                                    child: Image.asset(
////                                                      'assets/index.jpg',
////
////                                                      fit: BoxFit.cover,
////                                                    ),
////                                                  ),
////                                                  Container(
////                                                    color: Colors.grey,
////                                                    child: ListTile(
////                                                      title: Text(
////                                                        'heading',
////                                                        style: TextStyle(
////                                                            fontSize: 16,
////                                                            color: Colors
////                                                                .black),
////                                                      ),
//////                                                      subtitle: Text(
//////                                                        'subHeading',
//////                                                        style: TextStyle(
//////                                                            fontSize: 14, color: Colors.white),
//////                                                      ),
////                                                    ),
////                                                  ),
////                                                ],
////                                              ),
////                                            ),
////                                          ),
////                                        ),
////                                      ],
////                                    ),
////                                  ),
//                                  //   _showReviewForm(),
////                                Container(
////                                  margin: EdgeInsets.only(top: 30),
////                                  child: Row(
////                                    mainAxisAlignment: MainAxisAlignment.center,
////                                    children: <Widget>[
////                                      Container(
////                                        color: Colors.grey[500],
////                                        width: MediaQuery
////                                            .of(context)
////                                            .size
////                                            .width,
////                                        height: 25,
////                                        child: Center(
////                                          child: Text(
////                                            'User Reviews',
////                                            style: TextStyle(
////                                                fontSize: 18,
////                                                fontWeight: FontWeight.bold,
////                                                color: Colors.black),
////                                          ),
////                                        ),
////                                      )
////                                    ],
////                                  ),
////                                ),
//                                  //  _showInformationForm(),
////                                GestureDetector(
////                                  onTap: () => showComments(
////                                    context,
////                                    postId: snapshot.data.documents.elementAt(index)['uid'],
////                                    //ownerId: ownerId,
////                                    //     mediaUrl: snapshot.data.documents.elementAt(index)['image'],
////                                  ),
////                                  child: Icon(
////                                    Icons.chat,
////                                    size: 28.0,
////                                    color: Colors.blue[900],
////                                  ),
////                                ),
//
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          //color: Colors.grey[500],
                                          color: Colors.teal[700],
                                          width: MediaQuery.of(context)
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
                                  SizedBox(
                                    height: 17,
                                  ),
//                                  //    _showPersonalInformation(context),
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
                                        snapshot.data.documents
                                            .elementAt(
                                            index)[
                                        'displayName'] !=null ?  Container(
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
                                        ):Container(),
                                        snapshot.data.documents
                                            .elementAt(
                                            index)['age'] !=null? Container(
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
                                                            .bold,color: Colors.black54,),
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
                                        ):Container(),
                                        snapshot.data.documents
                                            .elementAt(
                                            index)[
                                        'address'] !=null? Container(
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
                                                            .bold,color: Colors.black54,),
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
                                        ):Container(),
                                        snapshot.data.documents
                                            .elementAt(
                                            index)[
                                        'phoneNumber']!=null?Container(
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
                                                            .bold,color: Colors.black54,),
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
                                        ):Container(),
                                      ],
                                    ),
                                  ),
                                  //   _editProfileButton(),
                                  snapshot
                                      .data.documents.elementAt(index)['User Type']=="Agent" ?
                                  Container(
                                    child: Center(
                                      child: FlatButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/AgentSignup');
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[800],
                                              borderRadius: BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "Edit Profile",
                                              style:
                                              TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                      :Container(
                                      child: Center(
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/editProfile');
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 170,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[800],
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                "Edit Profile",
                                                style:
                                                TextStyle(color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ),
//                                    :Container(
//                      margin: EdgeInsets.only(top: 60),
//                      child: Center(
//                      child: FlatButton(
//                      onPressed: () {
//                      Navigator.pushNamed(context, '/AgentSignup');
//                      },
//                      child: Container(
//                      height: 50,
//                      width: 180,
//                      decoration: BoxDecoration(
//                      color: Colors.grey[800],
//                      borderRadius: BorderRadius.circular(10)),
//                      child: Center(
//                      child: Text(
//                      "Complete Your Profile",
//                      style:
//                      TextStyle(color: Colors.white,
//                      fontWeight: FontWeight.bold),
//                      ),
//                      ),
//                      ),
//                      ),
//                      ),
//                      ),
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
          )   : Center(child: Text("Error"))),
    );

  }

//  Widget _buildCoverImage(Size screenSize) {
//    return Container(
//      color: Colors.black38,
//      height: screenSize.height / 7.5,
//    );
//  }
//
//  Widget _editProfileButton() {
//    return Container(
//      child: Center(
//        child: FlatButton(
//          onPressed: () {
//            Navigator.pushNamed(context, '/AgentSignup');
//          },
//          child: Container(
//            height: 50,
//            width: 100,
//            decoration: BoxDecoration(
//                color: Colors.grey[800],
//                borderRadius: BorderRadius.circular(10)),
//            child: Center(
//              child: Text(
//                "Edit Profile",
//                style:
//                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  Widget _buildBio(BuildContext context) {
//    TextStyle bioTextStyle = TextStyle(
//      fontFamily: 'Spectral',
//      fontWeight: FontWeight.w400,
//      //try changing weight to w500 if not thin
//      fontStyle: FontStyle.italic,
//      color: Colors.black,
//      fontSize: 16.0,
//    );
//    return Container(
//      width: 270,
//      color: Colors.white,
//      child: Text(
//        _bio,
//        textAlign: TextAlign.center,
//        style: bioTextStyle,
//      ),
//    );
//  }
//
////  Widget _buildProfileImage() {
////    return Center(
////      child: Container(
////        width: 140.0,
////        height: 140.0,
////        decoration: BoxDecoration(
////          image: DecorationImage(
////            image: AssetImage('assets/1.jpg'),
////            fit: BoxFit.cover,
////          ),
////          borderRadius: BorderRadius.circular(70.0),
////          border: Border.all(
////            color: Colors.black26,
////            width: 6.0,
////          ),
////        ),
////      ),
////    );
////  }
//
////  Widget _buildFullName() {
////    TextStyle _nameTextStyle = TextStyle(
////      fontFamily: 'Roboto',
////      color: Colors.black,
////      fontSize: 28.0,
////      fontWeight: FontWeight.w700,
////    );
////
////    return Text(
////      _fullName,
////      style: _nameTextStyle,
////    );
////  }
//
////  Widget _buildStatus(BuildContext context) {
////    return Container(
////      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
////      decoration: BoxDecoration(
////        color: Theme.of(context).scaffoldBackgroundColor,
////        borderRadius: BorderRadius.circular(4.0),
////      ),
////      child: Text(
////        _status,
////        style: TextStyle(
////          fontFamily: 'Spectral',
////          color: Colors.black,
////          fontSize: 20.0,
////          fontWeight: FontWeight.w300,
////        ),
////      ),
////    );
////  }
//
//  Widget _buildpropertyStatus(BuildContext context) {
//    return Container(
//      color: Colors.grey[500],
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Container(
//            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
//            child: Text(
//              _listings,
//              style: TextStyle(
//                fontFamily: 'Spectral',
//                color: Colors.black,
//                fontSize: 18.0,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _buildReviews(BuildContext context) {
//    return Container(
//      color: Colors.red,
//      child: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Text(
//                  _status,
//                  style: TextStyle(
//                    fontFamily: 'Spectral',
//                    color: Colors.black,
//                    fontSize: 13.0,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//              ],
//            ),
//            Row(
//              children: <Widget>[],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  Widget _buildPropertyList() {
//    return Container(
//      margin: EdgeInsets.only(top: 15),
//      height: 200,
//      child: ListView(
//        scrollDirection: Axis.horizontal,
//        children: <Widget>[
//          GestureDetector(
//            onTap: () {
//              Navigator.pushNamed(context, '/AdDetail');
//            },
//            child: Container(
//              width: 160.0,
//              child: Card(
//                child: Wrap(
//                  children: <Widget>[
//                    Container(
//                      height: 120,
//                      child: Image.asset(
//                        'assets/1.jpg',
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                    Container(
//                      color: Colors.grey,
//                      child: ListTile(
//                        title: Text(
//                          'heading',
//                          style: TextStyle(fontSize: 16, color: Colors.black),
//                        ),
//                        subtitle: Text(
//                          'subHeading',
//                          style: TextStyle(fontSize: 14, color: Colors.white),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//          GestureDetector(
//            onTap: () {
//              Navigator.pushNamed(context, '/AdDetail');
//            },
//            child: Container(
//              width: 160.0,
//              child: Card(
//                child: Wrap(
//                  children: <Widget>[
//                    Container(
//                      height: 120,
//                      child: Image.asset(
//                        'assets/1.jpg',
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                    Container(
//                      color: Colors.grey,
//                      child: ListTile(
//                        title: Text(
//                          'heading',
//                          style: TextStyle(fontSize: 16, color: Colors.black),
//                        ),
//                        subtitle: Text(
//                          'subHeading',
//                          style: TextStyle(fontSize: 14, color: Colors.white),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//          GestureDetector(
//            onTap: () {
//              Navigator.pushNamed(context, '/AdDetail');
//            },
//            child: Container(
//              width: 160.0,
//              child: Card(
//                child: Wrap(
//                  children: <Widget>[
//                    Container(
//                      height: 120,
//                      child: Image.asset(
//                        'assets/1.jpg',
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                    Container(
//                      color: Colors.grey,
//                      child: ListTile(
//                        title: Text(
//                          'heading',
//                          style: TextStyle(fontSize: 16, color: Colors.black),
//                        ),
//                        subtitle: Text(
//                          'subHeading',
//                          style: TextStyle(fontSize: 14, color: Colors.white),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//  Widget _showInformationForm() {
//    return Container(
//      margin: EdgeInsets.only(top: 30),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Container(
//            color: Colors.grey[500],
//            width: MediaQuery.of(context).size.width,
//            height: 25,
//            child: Center(
//              child: Text(
//                'Personal Information',
//                style: TextStyle(
//                    fontSize: 18,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.black),
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
//  Widget _showPersonalInformation(BuildContext context) {
//    return Container(
//      margin: EdgeInsets.only(left: 14, right: 14, bottom: 10),
//      padding: EdgeInsets.all(10),
//      decoration: BoxDecoration(
//        borderRadius: new BorderRadius.only(
//          bottomLeft: const Radius.circular(10.0),
//          bottomRight: const Radius.circular(10.0),
//        ),
//      ),
//      child: Column(
//        children: <Widget>[
//          Container(
//            height: 50,
//            color: Colors.grey[400],
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                      width: 70,
//                      child: Text(
//                        'Name: ',
//                        style: TextStyle(fontWeight: FontWeight.bold),
//                      )),
//                  SizedBox(
//                    width: 50,
//                  ),
//                  Text('Ali Qureshi'),
//                ],
//              ),
//            ),
//          ),
//          Container(
//            height: 50,
//            color: Colors.grey[200],
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                      width: 70,
//                      child: Text(
//                        'Age: ',
//                        style: TextStyle(fontWeight: FontWeight.bold),
//                      )),
//                  SizedBox(
//                    width: 50,
//                  ),
//                  Text('35'),
//                ],
//              ),
//            ),
//          ),
//          Container(
//            height: 70,
//            color: Colors.grey[400],
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                      width: 70,
//                      child: Text(
//                        'Address: ',
//                        style: TextStyle(fontWeight: FontWeight.bold),
//                      )),
//                  SizedBox(
//                    width: 50,
//                  ),
//                  Flexible(child: Text('DHA Defence, Islamabad')),
//                ],
//              ),
//            ),
//          ),
//          Container(
//            height: 50,
//            color: Colors.grey[200],
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                      width: 70,
//                      child: Text(
//                        'Cell No: ',
//                        style: TextStyle(fontWeight: FontWeight.bold),
//                      )),
//                  SizedBox(
//                    width: 50,
//                  ),
//                  Text('+92 333 3424242'),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
  Widget _showContact(BuildContext context) {
    return Container();
  }
//
//  Widget _showReviewForm() {
//    return Container(
//      margin: EdgeInsets.only(top: 30),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Container(
//            color: Colors.grey[500],
//            width: MediaQuery.of(context).size.width,
//            height: 25,
//            child: Center(
//              child: Text(
//                'User Reviews',
//                style: TextStyle(
//                    fontSize: 18,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.black),
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
}
//showComments(BuildContext context,
//    {String postId}) {
//  Navigator.push(context, MaterialPageRoute(builder: (context) {
//    return Comments(
//      postId: postId,
//      //postOwnerId: ownerId,
//      //   image: mediaUrl,
//    );
//  }));
//}
