import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  final bool isAgent;

  const MyProfile({Key key, this.isAgent}) : super(key: key);
  @override
  _MyProfileState createState() => _MyProfileState(this.isAgent);
}

class _MyProfileState extends State<MyProfile> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAgent = true;

  String data;
  _MyProfileState(this.isAgent);

  //bool isAdmin = false;

  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  FirebaseUser user;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("List of Agents"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.4),
                Colors.black.withOpacity(.2),
              ]),
//                gradient: LinearGradient(
//                 //
//                   colors: [Colors.deepPurple, Color(0xff2470c7)], stops: [0.5, 1.0],
//                  // colors: [Colors.deepPurple, Colors.purple], stops: [0.5, 1.0],
//                ),
            ),
          ),
        ),
        body: user != null ? Container(
          child: StreamBuilder(
            stream: Firestore.instance.collection('users').where(
                "User Type", isEqualTo: "Agent").snapshots(),

            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(

                  itemCount: snapshot.data.documents.length,

                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Container(
                                        width: 55.0,
                                        height: 55.0,
                                        //color: Colors.green,

                                        child: CircleAvatar(
                                          //backgroundColor: Colors.green,
                                          //foregroundColor: Colors.green,
                                          //backgroundImage: AssetImage('assets/1.jpg'),
                                          //backgroundImage: NetworkImage(snapshot.data['image']),
                                          backgroundImage: NetworkImage(
                                              snapshot.data.documents.elementAt(
                                                  index)['image']),
//                                          Image.network(snapshot.data.documents
//                                              .elementAt(index)['image']),
//                                          //Image.network(snapshot.data['url'],),
                                          //Image.network(snapshot.data['url'],),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Column(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        //mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 5),
                                            child: Text(
                                              snapshot.data.documents.elementAt(
                                                  index)['displayName'],
                                              //   snapshot.data.documents.elementAt(index)['displayName'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: FlatButton(
                                        color: Colors.grey[800],
                                        onPressed: () {
//                                          Navigator.pushNamed(context, '/myProfileFinal');
                                          data =
                                          snapshot.data.documents.elementAt(
                                              index)['User Type'];
                                          Navigator.of(context).pushNamed(
                                              '/myProfileFinal',
                                              arguments: data);
                                          //Navigator.of(context).pushNamed(CurrentUser(),arguments: data);
                                          print(data);
                                        },
                                        child: Text('Visit Profile',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            )),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.grey[500],
                                                width: 1.5,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                      ),
//                        SmoothStarRating(
//                            allowHalfRating: false,
//                            onRated: (v) {
//                            },
//                            starCount: 5,
//                            rating: rating,
//                            size: 20,
//                            isReadOnly:true,
//                            //     fullRatedIconData: Icons.blur_off,
//                            //     halfRatedIconData: Icons.blur_on,
//                            color: Colors.yellow,
//                            borderColor: Colors.orange,
//                            spacing:0.0
//                        ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(top: 15, left: 5),
//                          child: Text(
//                          snapshot.data['displayName'],
//                            style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 16,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                        ),
                        //Text(snapshot.data['displayName'],),
                        //Text(snapshot.data['email'],),
//Image.network(snapshot.data['url'],),
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
        ) : Center(child: Text("Error")),),
    );
  }
}
