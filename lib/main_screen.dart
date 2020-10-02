import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/MainScreenUsers.dart';
import 'package:signup/login.dart';
import 'package:signup/root/root.dart';
import 'package:signup/states/currentUser.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  final bool isAdmin;

  const MainScreen({Key key, this.isAdmin}) : super(key: key);

  //FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//  signOut() async {
//    await _firebaseAuth.signOut();
//  }
//final new Value
//bool _isAdmin = false;

  @override
  _MainScreenState createState() => _MainScreenState(this.isAdmin);
}

class _MainScreenState extends State<MainScreen> {
  bool isPressed = false;
 bool userLoggedIn =false;
  var _userName;
  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

//  getCurrentUser() async {
//    final FirebaseUser user = await _auth.currentUser();
//    final uid = user.displayName;
//    // Similarly we can get email as well
//    //final uemail = user.email;
//    print(uid);
//    //print(uemail);
//  }

  FirebaseUser user;
  @override
  void initState() {
    super.initState();

    initUser();
   // _getUserName();
  }
  initUser() async {
    user = await _auth.currentUser();

    setState(() {});
  }

  bool isAdmin = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
 //final authData = snapshot.data;
  _MainScreenState(this.isAdmin);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    Future _getUserName(String uid) async {
      DocumentSnapshot variable = await Firestore.instance.collection('users').document(uid).get();
//    Firestore.instance
//        .collection('users')
//        .document((await FirebaseAuth.instance.currentUser()).uid)
//        .get()
//        .then((value) {
//      setState(() {
//        _userName = value.data['Email'].toString();
//      });
//    });
    }
   // var variable;
    return Scaffold(
      backgroundColor: Colors.grey[600],
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Property Host'),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
            //  Text('SignOut'),
              //Text('${user.email}')
              user != null ? Text('${user.email}') : IconButton(
                icon:Icon(Icons.person),
                onPressed: () {
                  Navigator.pushNamed(context,'/LoginScreen');
                },
              ),


//                    //signOut();
//                    // Navigator.pushNamed(context, '/LoginScreen');
//
//                    String _returnString = await _currentUser.signOut();
////                  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
////                  String _returnString = await _currentUser.signOut();
//                    if (_returnString == 'Success') {
//                      Navigator.pushAndRemoveUntil(
//                        context,
//                        MaterialPageRoute(builder: (context) => OurRoot()),
//                        (route) => false,
//                      );
//                      //Navigator.pushNamed(context, '/LoginScreen');
////                  }
////                  //Navigator.pushNamed(context, '/LoginScreen');
//                    }

            ],
          ),
        ],
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[500],
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 90.0,
                child: DrawerHeader(
                  child: Center(
                      child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.grey[200], fontSize: 25.0),
                  )),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                  ),
                ),
              ),

          Container(
          color: Colors.grey[800],
        child: ListTile(
        title: Text(
        'Post an Ad',
        style: TextStyle(color: Colors.grey[200]),
        ),
        onTap: () {
        Navigator.pushNamed(context, '/postscreen1');
        },
        ),
        ),
              SizedBox(height: 1.0),
              // ignore: unrelated_type_equality_checks

              Container(
                color: Colors.grey[800],
                child: ListTile(
                  title: Text(
                    'Agents',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  onTap: () {
                          Navigator.pushNamed(context, '/MyProfile');
                  },
                ),
              ),
              SizedBox(height: 1.0),
              Center(
                child: user != null ? Container(
                  color: Colors.grey[800],
                  child: ListTile(
                    title: Text(
                      'Agent',
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/AgentsList');
                    },
                  ),
                ): SizedBox.shrink(),
              ),
              SizedBox(height: 1.0),
              Container(
                color: Colors.grey[800],
                child: ListTile(
                  title: Text(
                    'Your Ads',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/ViewAdds');
                  },
                ),
              ),
              SizedBox(height: 1.0),
              Container(
                color: Colors.grey[800],
                child: ListTile(
                  title: Text(
                    'My Profile',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/UserProfile');
                  },
                ),
              ),
              SizedBox(height: 1.0),
              Container(
                color: Colors.grey[800],
                child: ListTile(
                  title: Text(
                    'Advertise',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/Advertise');
                  },
                ),
              ),
              SizedBox(height: 1.0),
               isAdmin ? SizedBox.shrink() :Container(
                color: Colors.grey[800],
                child: ListTile(
                  title: Text(
                    'Sign up as Agent',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/AgentSignup');
                  },
                ),
              ),
              SizedBox(height: 1.0),
              user != null ? Container(
                color: Colors.grey[800],
                child: ListTile(
                    title: Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                    onTap: ()
                        //      Navigator.pop(context);
                        async {
                      //signOut();
                      // Navigator.pushNamed(context, '/LoginScreen');

                      String _returnString = await _currentUser.signOut();
//                  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//                  String _returnString = await _currentUser.signOut();
                      if (_returnString == 'Success') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => OurRoot()),
                          (route) => false,
                        );
                        //Navigator.pushNamed(context, '/LoginScreen');
//                  }
//                  //Navigator.pushNamed(context, '/LoginScreen');
                      }
                    }),
              ): SizedBox.shrink(),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height / 1.90,
                width: 360.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/home.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Find Your Dream Home With Property Host',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[350],
                          fontWeight: FontWeight.w900,
                          fontSize: 30.0,
                        ),
                      ),
                      SizedBox(height: 60.0),
                      TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          letterSpacing: 2.0,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[700], width: 3.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[100], width: 2.0),
                          ),
                          hintText: 'Enter Address, City or Zip Code',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: RaisedButton.icon(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              side: BorderSide(
                                  color: Colors.pink[500], width: 2.0)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/SearchResult');
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          label: Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
