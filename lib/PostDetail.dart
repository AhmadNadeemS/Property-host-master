import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:signup/screens/postscreen2.dart';
import 'AppLogic/validation.dart';

import 'package:path/path.dart' as Path;


class PostDetail extends StatefulWidget {

  @override
  _PostDetailState createState() => _PostDetailState();


}


class _PostDetailState extends State<PostDetail> {


// Controllers of text fields


  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  TextEditingController MetTimeController = new TextEditingController();
  TextEditingController AvailDays = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController propertySize = new TextEditingController();

  // ends here






  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;


  final reviewKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAdmin = true;


  //bool isAdmin = false;


  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

//  void rate(int rating) {
//    //Other actions based on rating such as api calls.
//    setState(() {
//      _rating = rating;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context.size;
    //  CurrentUser _current = Provider.of<CurrentUser>(context,listen: false);
    //_current.updateStateFromDatabase(data,_current.getCurrentUser.uid);


    return Scaffold(
        key: reviewKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Add Details'),
          centerTitle: true,
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.notifications),
//            onPressed: () {
//              Navigator.pushNamed(context, "/activityFeed");
//            },
//          )
//        ],
          backgroundColor: Colors.grey[800],
          elevation: 0.0,
        ),
        body: user != null ? Container(
          child: StreamBuilder(
            stream:  Firestore.instance.collection('PostAdd').snapshots(),
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
                  //_buildFullName(),
                  Text(snapshot.data.documents.elementAt(index)['Title'], style: TextStyle(fontFamily: 'Roboto',
                  color: Colors.black,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,),),
                  //    _buildStatus(context),
                  Container(
                  padding: EdgeInsets.symmetric(
                  vertical: 4.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                  snapshot.data.documents.elementAt(index)['Description'],
                  style: TextStyle(
                  fontFamily: 'Spectral',
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  ),
                  ),
                  ),
                  SizedBox(height: 10.0),
                  //       _buildBio(context),
                  Container(
                  width: 270,
                  color: Colors.white,
                  child: Text(
                  snapshot.data.documents.elementAt(index)['Price'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontFamily: 'Spectral',
                  fontWeight: FontWeight.w400,
                  //try changing weight to w500 if not thin
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontSize: 16.0,),
                  ),
                  ),
                      Container(
                        width: 270,
                        color: Colors.white,
                        child: Text(
                          snapshot.data.documents.elementAt(index)['Purpose'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Spectral',
                            fontWeight: FontWeight.w400,
                            //try changing weight to w500 if not thin
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                            fontSize: 16.0,),
                        ),
                      ),
                  ])))
                    ]);
                    });
                    }
               else {
                debugPrint('Loading...');
                return Center(
                  child: Text('Loading...'),
                );
              }
            },
          ),
        ) : Center(child: Text("Error")));
  }

}

