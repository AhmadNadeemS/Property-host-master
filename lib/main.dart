import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signup/AdsOnMap.dart';
import 'package:signup/ImageCarousel.dart';
import 'package:signup/MainScreenUsers.dart';
import 'package:signup/MyProfileFinal.dart';
import 'package:signup/PostDetail.dart';
import 'package:signup/activity_feed.dart';
import 'package:signup/agentSignup.dart';
import 'package:signup/chat/chatrooms.dart';
import 'package:signup/choseOnMap.dart';
import 'package:signup/forgetPassword.dart';
import 'package:signup/home.dart';
import 'package:signup/homeThree.dart';
import 'package:signup/homeTwo.dart';
import 'package:signup/main_screen.dart';
import 'package:signup/myProfile.dart';
import 'package:signup/screens/editProfile.dart';
import 'package:signup/screens/postscreen1.dart';
import 'package:signup/search_result.dart';
import 'package:signup/states/currentUser.dart';
import 'package:signup/userProfile.dart';
import 'package:signup/viewPostAdds.dart';

import './login.dart';
import './signup.dart';
import 'package:provider/provider.dart';


void main() => runApp(HomePage());


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(
          isAgent: false,
        ),
        routes: {
          '/main': (context) => HomePage(),
          '/home': (context) => RoleCheck(),
          '/homeTwo': (context) => RoleCheckTwo(),
          '/homeThree': (context) => RoleCheckThree(),
          ActivityFeed.routeName: (context) => ActivityFeed(),
          MyProfileFinal.routeName: (ctx) => MyProfileFinal(),
          ImageCarousel.routeName: (ctx) => ImageCarousel(),
          '/UserProfile': (context) => UserProfile(),
          '/mainScreen': (context) => MainScreen(),
          '/mainScreenUser': (context) => MainScreenUsers(),
          '/LoginScreen': (context) => LoginPage(),
          '/MyProfile': (context) => MyProfile(),
          '/Signup': (context) => SignUpPage(),
          '/ViewAdds': (context) => ViewAdds(),
          '/postscreen1': (context) => PostFirstScreen(),
          '/choseOnMap': (context) => ChoseOnMap(),
          '/AgentSignup': (context) => AgentSignUp(),
          '/editProfile':(context) =>EditProfile(),
          '/AdsOnMap':(context) =>AdsOnMap(),
          '/search_result':(context) => SearcResult(),
          '/ForgetPassword': (context) => ForgetPassword(),
          '/ImageCarousel': (context) => ImageCarousel(),
          '/AgentSignup': (context) => AgentSignUp(),
          '/ForgetPassword': (context) => ForgetPassword(),
          '/ChatRoom': (context) => ChatRoom(),
        },
      ),
    );
  }
}
//  return MaterialApp(
//    routes: {
//      '/main': (context) => HomePage(),
//      '/mainScreen': (context) => MainScreen(),
//      '/LoginScreen': (context) => LoginPage(),
//      '/Signup': (context) => SignUpPage(),
//      '/ForgetPassword': (context) => ForgetPassword(),
//    },
//    home: ChangeNotifierProvider(
//        create: (context) => CurrentUser(),
//        child: LoginPage())
//  );
//  );

//class HomeController extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final AuthService auth = Provider.of(context).auth;
//    return StreamBuilder<String>(
//      stream: auth.onAuthStateChanged,
//      builder: (context, AsyncSnapshot<String> snapshot) {
//        if (snapshot.connectionState == ConnectionState.active) {
//          final bool signedIn = snapshot.hasData;
//          return signedIn ? HomePage() : LoginPage();
//        }
//        return CircularProgressIndicator();
//      },
//    );
//  }
//}
