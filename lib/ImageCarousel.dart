import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signup/AppLogic/validation.dart';
import 'package:signup/Arguments.dart';
import 'package:signup/models/Adpost.dart';
import 'package:signup/screens/editPost.dart';
import 'package:signup/screens/postscreen1.dart';
import 'package:signup/services/MakeBid.dart';
import 'package:signup/services/chatDatabase.dart';
import './widgets/TextIcon.dart';
import 'chat/chat.dart';
import 'helper/constants.dart';
import 'helper/helperfunctions.dart';

class ImageCarousel extends StatefulWidget {
  static const routeName = '/ImageCarousel';
  @override
  _ImageCarouselState createState() => _ImageCarouselState();


}


class _ImageCarouselState extends State<ImageCarousel>{

  final Firestore _firestore = Firestore.instance;
  FirebaseUser user;
  bool _validate = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
//  List<NetworkImage> _listOfImages = <NetworkImage>[];

  List<Image> _listOfImages = <Image>[];
  bool isLoading = false;
  chatdatabase Chatdatabase = new chatdatabase();

  AdPost _adPost = new AdPost();
  String data =
      "https://thumbs.dreamstime.com/b/user-profile-avatar-icon-134114292.jpg";

  @override
  void initState() {


    super.initState();
    // CurrentUser _current = Provider.of<CurrentUser>(context, listen: false);

    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {});
  }
  String name;
  double bid;
  int number;
  String postId;

  GlobalKey<FormState> _key = new GlobalKey();
  final navigaterKey = GlobalKey<NavigatorState>();
  PostBidFirebase createBid = PostBidFirebase();



  @override
  Widget build(BuildContext context) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    postId = args.PostId;

    // This is the type used by the popup menu below.




    createAlertDialog(BuildContext context) {
      TextEditingController _phoneController = TextEditingController();
      final TextEditingController _firstName = TextEditingController();
      final TextEditingController _bid = TextEditingController();
      return showDialog(
          context: context,
          builder: (context) {

            return AlertDialog(
              title: Text('Enter Your Offer Price'),
              content: Form(
                key: _key,
                autovalidate: _validate,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            controller: _firstName,
                            keyboardType: TextInputType.text,
                            validator: validateName,
                            onSaved: (String val){
                              name = val;
                              print(name);
                            },

                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey[800],
                                ),
                                labelText: 'Enter Full Name'),
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            validator:validateMobile,
                            onSaved: (String val){
                              number = int.parse(val);
                              print(number);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.grey[800],
                                ),
                                labelText: 'Phone No'),
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            controller: _bid,
                            keyboardType: TextInputType.phone,
                         //   maxLength: 11,
                            validator:validateBid,
                            onSaved: (String val){
                             bid = double.parse(val);
                              print(bid);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.grey[800],
                                ),
                                labelText: 'Enter Bid'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Make Offer'),
            onPressed: (){
            _validate = true;
            if (_sendToServer()) {
            makesBid(name,number,bid,postId);
            Navigator.pop(context);
            _validate = false;
            return true;
            }
            Navigator.pop(context);
//            else{
//                      setState(() {
//                        _validate = true;
//                      });
//                    }
                  },
                )
              ],
            );
          });
    }

    createContactDialog(BuildContext context)  async {
      TextEditingController Textcontroller = TextEditingController();
      String userName;


      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Contact information\n'
                  'or Send a message'
              ),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState)  {
                    return StreamBuilder(
                        stream:  Firestore.instance.collection("users").where("uid",isEqualTo: args.userId).snapshots(),
                        builder: (BuildContext context,  snapshot) {

                          if (snapshot.hasData) {

                            return SingleChildScrollView(
                              child:ListBody(
                                  children: <Widget>[
                                    Text( userName = snapshot.data.documents[0].data["displayName"].toString()),
                                    Text(snapshot.data.documents[0].data["email"].toString()),
                                    Text(snapshot.data.documents[0].data["phoneNumber"].toString()),

                                    FlatButton(
                                      onPressed: () {
                                        //  print(userName);
                                        sendMessage(userName);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 80,
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.only(left: 0),
                                        decoration: BoxDecoration(color: Colors.grey[800],border: Border.all(
                                            width: 1.0
                                        ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)
                                          ),),
                                        child: Center(
                                          child: Text(
                                            "Message",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),


                                    /* TextField(
                                      controller: Textcontroller,
                                      decoration: InputDecoration(
                                        labelText: 'Enter here:',
                                        errorText: _validate ? 'Value can,t be empty':null,
                                        alignLabelWithHint: false,
                                        filled: false,
                                      ),
                                    )*/
                                  ]),
                            );
                          }else{
                            return CircularProgressIndicator();
                          }


                        });
                  }),
              /*actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('send'),
                  onPressed: () {
                            sendMessage(userName);

                  },
                )
              ]*/
            );
          }
      );
    }


    deletePostAlert(BuildContext context) {

      return showDialog(
          context: context,
          builder: (context) {

            return AlertDialog(
              title: Text('Are you Sure you Want to Delete the Post?'),
              content: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(

                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Delete'),
                  onPressed: () {
                    print("delete button is called post id is"+args.PostId);

                 //   chatdatabase().removePost(args.PostId);

                    Navigator.pushNamed(context, "/ViewAdds");
                    

                  },
                ),
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Cancel'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigaterKey,

      home: Scaffold(

        //  backgroundColor: Colors.blue[800],
        appBar: AppBar(


          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.2),
                  ]
              ),


//                gradient: LinearGradient(
//                  //     colors: [Colors.deepPurple, Colors.purple], stops: [0.5, 1.0],
//                  colors: [Colors.deepPurple, Color(0xff2470c7)],
//                  stops: [0.5, 1.0],
//                ),
//              gradient: LinearGradient(
//                  begin: Alignment.bottomRight,
//                  colors: [
//                    Colors.black.withOpacity(.4),
//                    Colors.black.withOpacity(.2),
//                  ]
//              ),
            ),
          ),
          //backgroundColor: Colors.grey[800],

          title: Text("Ad Details"),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          
          actions: <Widget> [

          PopupMenuButton(
            itemBuilder: (content) =>[
              PopupMenuItem(
                value:1,
                child: Text("Edit"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("Delete"),
              )
            ],
            onSelected: (int menu){
              if(menu ==  1){
                navigaterKey.currentState.push(MaterialPageRoute(builder: (context)=> EditPost(adPost:_adPost)));

              }
              else if(menu == 2){

              deletePostAlert(context);



              }

              },
          )

          ],
        ),

        body: user != null ? Container(
          child:
          //stream: Firestore.instance.collection('PostAdd').document(Pos)
          StreamBuilder(
            stream: Firestore.instance.collection('PostAdd').where("PostID",isEqualTo: args.PostId).snapshots(),

            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {

                return ListView.builder(

                  itemCount: snapshot.data.documents.length,

                  itemBuilder: (BuildContext context, int index) {
                    _listOfImages = [];
                    _adPost.title = snapshot.data.documents[index].data['Title'];
                    _adPost.desc = snapshot.data.documents[index].data['Description'];
                    _adPost.price = snapshot.data.documents[index].data['Price'];
                    _adPost.Address = snapshot.data.documents[index].data['Address']['Street'];
                    _adPost.AvailDays = snapshot.data.documents[index].data['Available Days'];
                    _adPost.City = snapshot.data.documents[index].data['Address']['city'];
                    _adPost.time = snapshot.data.documents[index].data['Meeting Time'];
                    _adPost.propertySize=snapshot.data.documents[index].data['Property Size'];
                    _adPost.postId = args.PostId;

                    for (int i = 0;
                    i < snapshot.data.documents[index].data['Image Urls'].length;
                    i++
                    )
                    {
                      _listOfImages.add(Image.network(snapshot
                          .data.documents[index].data['Image Urls'][i],
                        // snapshot.data.documents[index].data['Image Urls'][0],
                        //'https://previews.123rf.com/images/blueringmedia/blueringmedia1701/blueringmedia170100692/69125003-colorful-kite-flying-in-blue-sky-illustration.jpg',
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                      );
                    }
                    //final List<Image> children = snapshot.data.documents.map<Image>((e) => Image.network(e["Image Urls"].toString())).toList();
                    //List<NetworkImage> _listOfImages = <NetworkImage>[snapshot.data.documents[index].data["Image Urls"][index]];
                    return Column(

                      children: <Widget>[

                        Center(
                          child: Container(
                            height: 200,
                            child: Center(
                              child: Carousel(
                                boxFit: BoxFit.fill,
                                images:
                                _listOfImages,
                                autoplay: false,
                                indicatorBgPadding: 1.0,
                                dotSize: 4.0,
                                dotColor: Colors.blue,
                                dotBgColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot
                                    .data.documents
                                    .elementAt(index)['Title'],
                                style: Theme
                                    .of(context)
                                    .textTheme
                                // ignore: deprecated_member_use
                                    .title
                                    .copyWith(fontSize: 24.0),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 16.0),
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Colors.grey, width: 0.4),
                                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Rooms'] !=null? TextIcon(
                                      icon: FontAwesomeIcons.bed,
                                      //text: "Bedroom",
                                      text: ('${snapshot
                                          .data.documents.elementAt(index)['Main Features']['Rooms'].toString()} Bedroom'),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)["Unit Area"] !=null? TextIcon(
                                      icon: FontAwesomeIcons.home,
                                      text: ('${snapshot
                                          .data.documents
                                          .elementAt(index)['Property Size']}' " " '${snapshot
                                          .data.documents
                                          .elementAt(index)['Unit Area']}'),
                                    ): SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Bathrooms']!=null? TextIcon(
                                      icon: FontAwesomeIcons.shower,
                                      text: ('${snapshot.data.documents.elementAt(index)['Main Features']['Bathrooms'].toString()} Bathroom'),
                                    ): SizedBox.shrink(),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Description",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                // ignore: deprecated_member_use
                                    .title
                                    .copyWith(fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                 _adPost.desc = snapshot
                                      .data.documents
                                      .elementAt(index)['Description'],style: TextStyle(color: Colors.grey),),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Center(
                                  child: Text(
                                    "Details",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                    // ignore: deprecated_member_use
                                        .title
                                        .copyWith(fontSize: 20.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Type: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 23,
                                            ),

                                            Text(   snapshot
                                                .data.documents
                                                .elementAt(index)['Property Type']),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Price: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot.data.documents.elementAt(index)['Price'].toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Location: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Flexible(
                                                child: Text(   snapshot
                                                    .data.documents
                                                    .elementAt(index)['Address']["Street"])),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Area: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Text(   snapshot
                                                .data.documents
                                                .elementAt(index)['Property Size']),
                                            SizedBox(width:5),
                                            Text(   snapshot
                                                .data.documents
                                                .elementAt(index)['Unit Area']),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Purpose: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents
                                                .elementAt(index)['Purpose']),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(

                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Center(
                                  child: Text(
                                    "Main Features",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                    // ignore: deprecated_member_use
                                        .title
                                        .copyWith(fontSize: 20.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Sewarege'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),

                                            Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Sewarege: ',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents.elementAt(index)['Main Features']['Sewarege'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),

                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Balloted'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),

                                            Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Balloted: ',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents.elementAt(index)['Main Features']['Balloted'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),  snapshot
                                        .data.documents.elementAt(index)['Main Features']['Corner'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),

                                            Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Corner: ',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents.elementAt(index)['Main Features']['Corner'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),  snapshot
                                        .data.documents.elementAt(index)['Main Features']['Disputed'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),

                                            Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Disputed: ',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents.elementAt(index)['Main Features']['Disputed'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),  snapshot
                                        .data.documents.elementAt(index)['Main Features']['Park facing'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),

                                            Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Park facing: ',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents.elementAt(index)['Main Features']['Park facing'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),  snapshot
                                        .data.documents.elementAt(index)['Main Features']['Possession'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),

                                            Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Possession: ',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents.elementAt(index)['Main Features']['Possession'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),  snapshot
                                        .data.documents.elementAt(index)['Main Features']['sui gas'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),

                                            Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Sui Gas: ',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents.elementAt(index)['Main Features']['sui gas'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['water supply'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),

                                            Row(
                                              children: [
                                                Container(
                                                    width: 70,
                                                    child: Text(
                                                      'Water Supply: ',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents.elementAt(index)['Main Features']['water supply'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Build year']!=null?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Built in Year: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Build year']),
                                          ],
                                        ),
                                      ),
                                    ): SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Parking space']!=null? Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Parking Spaces: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Parking space']),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Rooms']!=null?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Beds: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Flexible(child: Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Rooms'])),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Bathrooms']!=null?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Bathrooms: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Bathrooms']),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['kitchens'].toString()==null?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Kitchens: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['kitchens'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Floors']!=null?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,

                                                child: Text(
                                                  'Floors: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Floors'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Flooring']!=null?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,

                                                child: Text(
                                                  'Flooring: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Flooring']),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Waste disposal'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,

                                                child: Text(
                                                  'Waste disposal: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Waste disposal'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Elevators'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,

                                                child: Text(
                                                  'Elevators: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Elevators'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Floors']!=null?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,

                                                child: Text(
                                                  'Floors: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Floors']),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Maintenance Staff'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,

                                                child: Text(
                                                  'Maintenance Staff: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Maintenance Staff'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    snapshot
                                        .data.documents.elementAt(index)['Main Features']['Security Staff'].toString()=="true"?Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,

                                                child: Text(
                                                  'Security Staff: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(snapshot
                                                .data.documents.elementAt(index)['Main Features']['Waste disposal'].toString()),
                                          ],
                                        ),
                                      ),
                                    ):SizedBox.shrink(),
                                    Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Available Days: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents
                                                .elementAt(index)['Available Days']),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //                             Icon(Icons.schedule,),
                                            Container(
                                                width: 70,
                                                child: Text(
                                                  'Meeting Time: ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            SizedBox(
                                              width: 50,
                                            ),

                                            Text(   snapshot
                                                .data.documents
                                                .elementAt(index)['Meeting Time']),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        user.uid == snapshot.data.documents.elementAt(index)['uid'] ?
                        Column(
                          children: <Widget>[
                            Container(

                              //width: 320,
                              height:130,
                              margin: EdgeInsets.only(left: 14, right: 14, bottom: 10),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.black26,
                                ),
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),),
                              ),
                              child: StreamBuilder(
                                stream: Firestore.instance.collection('BidList').where('PostID',isEqualTo:args.PostId).snapshots(),
                                // ignore: missing_return
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                                  if(snapshot.data.documents.length != 0) {
                                    return ListView.builder(
                                        itemCount: snapshot.data.documents
                                            .length,
                                        itemBuilder: (BuildContext context,
                                            int index) {
                                          return Container(

                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  // margin: EdgeInsets.only(top: 30),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        //color: Colors.grey[500],
                                                        color: Colors.teal[700],
                                                        width: 300,
                                                        height: 25,
                                                        child: Center(
                                                          child: Text(
                                                            'Offers List',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                    snapshot.data
                                                        .documents[index]
                                                        .data['Name']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .black,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                  leading: CircleAvatar(
                                                    //backgroundImage: NetworkImage(w),
                                                    // backgroundColor: Colors.blueGrey,
                                                    backgroundImage: CachedNetworkImageProvider(
                                                        data
                                                            .toString()),
                                                  ),
                                                  // subtitle: Text(username),
                                                  //subtitle: Text(accountCreated.toString()),
                                                  subtitle: Row(
                                                    children: [
                                                      Text('Number: ',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 10),),
                                                      Text(
                                                        snapshot.data
                                                            .documents[index]
                                                            .data['Number']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .black45),
                                                      ),
                                                    ],
                                                  ),
                                                  //trailing: Text(timeago.format(timestamp.toDate())),
                                                  trailing: Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                        Text('Bid',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight
                                                                  .bold),),
                                                        Text(
                                                          snapshot.data
                                                              .documents[index]
                                                              .data['Bid']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 12),),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  }
                                  else
                                    {
                                      return Container(

                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              // margin: EdgeInsets.only(top: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    //color: Colors.grey[500],
                                                    color: Colors.teal[700],
                                                    width: 300,
                                                    height: 30,
                                                    child: Center(
                                                      child: Text(
                                                        'Offers List',
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
                                            Container(
                                              margin:EdgeInsets.only(top:7),
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Container(

                                                    child: Center(child: Text('No Offers Yet !',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),)),
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      );
                                    }
                                 // else if(snapshot.hasError || snapshot == null)

//
                                  }
                              ),
                            ),
                          ],
                        ):
                    SizedBox.shrink(),
                        user.uid != snapshot.data.documents.elementAt(index)['uid']
                            ?      Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                onPressed: () {
                                  createAlertDialog(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 40),
                                  height: 50,
                                  width: 80,
                                  decoration: BoxDecoration(color: Colors.grey[800],border: Border.all(
                                      width: 1.0
                                  ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    ),),
                                  child: Center(
                                    child: Text(
                                      "Make Offer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                onPressed: () {
                                  createContactDialog(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: 80,
                                  margin: EdgeInsets.only(left: 0),
                                  decoration: BoxDecoration(color: Colors.grey[800],border: Border.all(
                                      width: 1.0
                                  ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    ),),
                                  child: Center(
                                    child: Text(
                                      "Contact",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ):Container(),
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
        )   : Center(child: Text("Error")),),
    );
  }


  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }


  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName){
    List<String> users = [Constants.myName,userName];
    String chatRoomId = getChatRoomId(Constants.myName,userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };


    Chatdatabase.addChatRoom(chatRoom, chatRoomId);


    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
              chatRoomId: chatRoomId,
              userName: userName,
            )),
    );

  }

  void makesBid(String name,int number,double bid,String postId) async{

      createBid.CreateBid(name,number,bid,postId);
    //showAlert("uploaded successfully");
    //Navigator.of(context).pop();

  }

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

}
