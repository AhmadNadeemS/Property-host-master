import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:signup/main_screen.dart';
import 'package:signup/models/Adpost.dart';
import 'package:signup/services/PostAdCreation.dart';
import '../utils.dart';


class PostSecondScreen extends StatefulWidget{

  @override
  _PostSecondScreenState createState() => new _PostSecondScreenState();

  String title;
  String desc;
  int price;
  String City;
  String AvailDays;
  String time;
  String unitArea;
  String address;
  String purpose, propertySize;

  String location;

  PostSecondScreen(this.title, this.desc, this.price, this.City, this.address,
      this.purpose, this.unitArea, this.AvailDays, this.time, this.propertySize,
      {Key key})
      : super(key: key);
}


class _PostSecondScreenState extends State<PostSecondScreen>{

  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  bool isAdmin = false;

  String _error = 'No Error Dectected';
  bool isUploading = false;
  List<NetworkImage> _listOfImages = <NetworkImage>[];



  PostAddFirebase createpost = PostAddFirebase();
  AdPost adPost = new AdPost();

  // main features controllers

  TextEditingController buildYear = new TextEditingController();
  TextEditingController parkingSpace = new TextEditingController();
  TextEditingController Rooms = new TextEditingController();
  TextEditingController BathRooms = new TextEditingController();
  TextEditingController kitchens = new TextEditingController();
  TextEditingController Floors = new TextEditingController();

  TextEditingController flooring = new TextEditingController();



  //ends here

  GlobalKey<FormState> _key = new GlobalKey();

  bool _validate = false;



  /*void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }*/



  String dropdownTo;
  String dropdownFrom;
  String dropdownCondition;
  String _selectedpropertyType;
  String _selectedpropertyDetailType;



  int value = 0;
  bool isButtonPressed1 = false;
  bool isButtonPressed2 = false;
  bool isButtonPressed3 = false;
  bool isButtonPressed4 = false;
  bool isButtonPressed5 = false;
  bool isButtonPressed6 = false;
  bool isButtonPressed7 = false;


  bool _checkBoxVal = false;
  bool _checkBoxVal2 = false;
  bool _checkBoxVal3 = false;
  bool _checkBoxVal4 = false;
  bool _checkBoxVal5 = false;
  bool _checkBoxVal6 = false;
  bool _checkBoxVal7 = false;
  bool _checkBoxVal8 = false;



  List<String> _propertyType = ['Homes', 'Plots', 'Commercial'];

  List<String> _propertyTypeHomes = [
    'House',
    'Flat',
    'Upper Portion',
    'Lower Portion',
    'Farm House',
    'Pent House'
  ];






  List<String> _propertyTypePlots = [
    'Residential Plot',
    'Commerical Plot',
    'Agricultural Plot',
    'Industrial Land',
    'Plot File',
    'Plot Form'
  ];




  List<String> _propertyTypeCommercial = [
    'Office',
    'Shop',
    'WareHouse',
    'Factory',
    'Building',
    'Other'
  ];





  List<String> _getPropertyTypeDetails() {
    switch (_selectedpropertyType) {
      case ("Homes"):
        return _propertyTypeHomes;
      case ("Plots"):
        return _propertyTypePlots;
      case ("Commercial"):
        return _propertyTypeCommercial;
    }

    List<String> deflt2 = ['Please Select Property Type'];
    return deflt2;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(value)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.grey[600],
      key: _scaffoldKey,
      body: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/background.png"),
//            fit: BoxFit.cover,
//          ),
//        ),
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: Text(
                  "Post New Ad",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              AddPost(),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              ),
            ], //:TODO: implement upload pictures
          ),
        ),
      ),
    );



  }

  Widget AddPost(){
    return Form(
      key: _key,
      autovalidate: _validate,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child:Column(
            children: <Widget>[

              _getPropertyTypeDropDown(),
              _getPropertyTypeDetailDropDown(),

              _selectedpropertyDetailType=='House'? _showExpansionList(): _selectedpropertyDetailType=='Flat'? _showExpansionList():_selectedpropertyDetailType=='Upper Portion'? _showExpansionList():_selectedpropertyDetailType=='Lower Portion'? _showExpansionList():_selectedpropertyDetailType=='Farm House'? _showExpansionList(): _selectedpropertyDetailType=='Residential Plot'? _showExpansionListPlot():_selectedpropertyDetailType=='Commercial Plot'? _showExpansionListPlot():_selectedpropertyDetailType=='Agricultural Plot'? _showExpansionListPlot(): _selectedpropertyDetailType=='Office'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Shop'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Ware House'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Factory'? _showExpansionListCommercial():_selectedpropertyDetailType=='Building'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Other'? _showExpansionListCommercial():_hideExpansionList(),



              UploadPropertyImages(),

              //ReadImagesFromFirebaseStorage(),
              //_uploadImagesInput(),
              //_showSelectImages(),
              //_showAddImages(),
              Container(

                margin: EdgeInsets.only(left: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //buildGridView(),
                    Container(
//                      decoration: BoxDecoration(
//                          color: Colors.blue[200],
//                          border: Border.all(
//                              color: Colors.pink[800],// set border color
//                              width: 3.0),   // set border width
//                          borderRadius: BorderRadius.all(
//                              Radius.circular(10.0)), // set rounded corner radius
//                        //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))]// make rounded corner of border
//                      ),
                      width: 200,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 4,
                      //color: Colors.green,
                      child: buildGridView(),
                    ),
                    RaisedButton(
                      child: Text("Submit"),
                      onPressed: () {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          showAlert("Post is Uploading. Please Wait ");
                          runMyFutureGetImagesReference();
                          if (isAdmin) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(isAgent: true,)));
                          }
                          else {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(isAgent: false,)));
                          }
//                          return MainScreen(isAdmin: true,);
                          //       Navigator.pushNamed(context, '/mainScreen');

                        }

                        else{
                          setState(() {
                            _validate = true;
                          });
                        }

                        //  Navigator.pushNamed(context, '/mainScreen');
//                      setState(() {
//                        isButtonPressed7 = !isButtonPressed7;
//                      });
                      },
                      textColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      splashColor: Colors.grey,
                    ),
                  ],
                ),
              ),

              //_showSubmitButton(),

            ],
          )
      ),

    );

  }

  void runMyFutureGetImagesReference() async{

    List<String> values =  await GetImageReferences();

    print(values.length.toString() + "entered in runMyfuture method");

    if (_selectedpropertyType == "Homes") {
      if(_selectedpropertyDetailType =="Pent House") {
        adPost.title = widget.title;
        adPost.desc = widget.desc;
        adPost.price = widget.price;
        adPost.Address = widget.address;
        adPost.City = widget.City;
        adPost.AvailDays = widget.AvailDays;
        adPost.time = widget.time;
        adPost.propertySize = widget.propertySize;
        adPost.unitArea = widget.unitArea;
        adPost.purpose = widget.purpose;
        adPost.propertyType = _selectedpropertyType;
        adPost.propertyDeatil = _selectedpropertyDetailType;
        adPost.ImageUrls = values;

        createpost.CreatePostAddHomesPentHouse(adPost);


      } else{

        setState(() {
          if (buildYear.text.isEmpty || parkingSpace.text.isEmpty ||
              Rooms.text.isEmpty || BathRooms.text.isEmpty
              || kitchens.text.isEmpty || Floors.text.isEmpty) {
            _validate = true;
          }
          else {
            adPost.title = widget.title;
            adPost.desc = widget.desc;
            adPost.price = widget.price;
            adPost.Address = widget.address;
            adPost.City = widget.City;
            adPost.AvailDays = widget.AvailDays;
            adPost.time = widget.time;
            adPost.propertySize = widget.propertySize;
            adPost.unitArea = widget.unitArea;
            adPost.purpose = widget.purpose;
            adPost.propertyType = _selectedpropertyType;
            adPost.propertyDeatil = _selectedpropertyDetailType;
            adPost.buildyear = buildYear.text;
            adPost.ParkingSpace = parkingSpace.text;
            adPost.Rooms = Rooms.text;
            adPost.bathrooms = BathRooms.text;
            adPost.Kitchens = kitchens.text;
            adPost.Floors = Floors.text;
            adPost.ImageUrls = values;

            createpost.CreatePostAddHomes(adPost);

            // print(imageUrls);
          }
        });
      }
    }

    else if (_selectedpropertyType == "Plots") {

      adPost.title = widget.title;
      adPost.desc= widget.desc;
      adPost.price= widget.price;
      adPost.Address= widget.address;
      adPost.City= widget.City;
      adPost.AvailDays=widget.AvailDays;
      adPost.time= widget.time;
      adPost.propertySize= widget.propertySize;
      adPost.unitArea=widget.unitArea;
      adPost.purpose= widget.purpose;
      adPost.propertyType=  _selectedpropertyType;
      adPost.propertyDeatil= _selectedpropertyDetailType;
      adPost.possesion=  _checkBoxVal;
     adPost.ParkingSpaces= _checkBoxVal2;
     adPost.corners = _checkBoxVal3;
     adPost.disputed= _checkBoxVal4;
     adPost.balloted= _checkBoxVal5;
     adPost.suiGas= _checkBoxVal6;
     adPost.waterSupply = _checkBoxVal7;
      adPost.sewarge= _checkBoxVal8;

      adPost.ImageUrls = values;
      createpost.CreatePostAddPlots(adPost);
    }

    else {
      setState(() {
        if (buildYear.text.isEmpty || parkingSpace.text.isEmpty ||
            flooring.text.isEmpty || Rooms.text.isEmpty ||
            Floors.text.isEmpty) {
          _validate = true;
        }
        else {
          adPost.title = widget.title;
          adPost.desc= widget.desc;
          adPost.price= widget.price;
          adPost.Address= widget.address;
          adPost.City= widget.City;
          adPost.AvailDays=widget.AvailDays;
          adPost.time= widget.time;
          adPost.propertySize= widget.propertySize;
          adPost.unitArea=widget.unitArea;
          adPost.purpose= widget.purpose;
          adPost.propertyType=  _selectedpropertyType;
          adPost.propertyDeatil= _selectedpropertyDetailType;
          adPost.buildyear=  buildYear.text;
          adPost.ParkingSpace= parkingSpace.text;
          adPost.Rooms=   Rooms.text;
          adPost.Floors= Floors.text;
          adPost.possesion=  _checkBoxVal;
          adPost.ParkingSpaces= _checkBoxVal2;
          adPost.corners = _checkBoxVal3;
          adPost.disputed= _checkBoxVal4;
          adPost.ImageUrls = values;
          createpost.CreatePostAddCommerical(adPost);
        }
      });
    }

    showAlert("uploaded successfully");
    Navigator.of(context).pop();

  }

  Widget _getPropertyTypeDropDown() {
    return Row(
      children: <Widget>[
        //Icon(Icons.map, color: Colors.grey),
        Container(
          //margin: EdgeInsets.only(left: 5,),
          width: 7.0,
        ),
        Flexible(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  prefixIcon: Container(
                    //margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.scatter_plot,
                      color: Color(0xff2470c7),
                    ),
                  ),
                  labelText: 'Choose Property Type'),
              value: _selectedpropertyType,
              onChanged: (newValue) {
                setState(() {
                  _selectedpropertyType = newValue;
                  _selectedpropertyDetailType = _getPropertyTypeDetails().first;
                });
              },
              items: _propertyType.map((propertyType) {
                return DropdownMenuItem(
                  child: Text(propertyType),
                  value: propertyType,
                );
              }).toList(),
              validator: (value) =>
              value == null ? 'Property Type is required' : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _getPropertyTypeDetailDropDown() {
    return Row(
      children: <Widget>[
        //Icon(Icons.map, color: Colors.grey),
        Container(
          //margin: EdgeInsets.only(left: 5,),
          width: 7.0,
        ),
        Flexible(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  prefixIcon: Container(
                    //margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.merge_type,
                      color: Color(0xff2470c7),
                    ),
                  ),
                  labelText: 'Choose Property Detail'),
              //hint: Text('Choose Property Type Detail'),
              value: _selectedpropertyDetailType,
              onChanged: (newValue) {
                setState(() {
                  _selectedpropertyDetailType = newValue;
                });
              },
              items: _getPropertyTypeDetails().map((propertyType) {
                return DropdownMenuItem(
                  child: Text(propertyType),
                  value: propertyType,
                );
              }).toList(),
              validator: (value) =>
              value == null ? 'Property type detail required' : null,
            ),
          ),
        ),
      ],
    );
  }




  showAlert(String a) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(a),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Ok",
                style: Theme.of(context).textTheme.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
//          child: ThreeDContainer(
//            backgroundColor: MultiPickerApp.brighter,
//            backgroundDarkerColor: MultiPickerApp.brighter,
//            height: 50,
//            width: 50,
//            borderDarkerColor: MultiPickerApp.pauseButton,
//            borderColor: MultiPickerApp.pauseButtonDarker,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2)
              ),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            ),
          ),
          //  ),
        );
      }),
    );
  }

  Widget UploadPropertyImages() {
    return Container(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  NiceButton(
                      width: 250,
                      elevation: 8.0,
                      radius: 52.0,
                      text: "Select Images",
                      background: Colors.blueAccent,
                      onPressed: () async {
                        List<Asset> asst = await loadAssets();
                        if (asst.length == 0) {
                          showAlert("No images selected");
                        }
                        SizedBox(height: 10,);

                        showInSnackBar('Images Successfully loaded');
                        //                 SnackBar snackbar = SnackBar(content: Text('Please wait, we are uploading'));
                        //_scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
                      }
                    //print(asst.length.toString() + "load asset completed");

                    // }
                  ),


                  /* imageUrls != null ? Container(
                    height: 200,
                    padding: EdgeInsets.all(16.0),
                    child: GridView.builder(
                          itemCount: imageUrls.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
                          itemBuilder: (BuildContext context, int index){
                            return Image.network(imageUrls[index].toString());
                  },
                ))
                    : Center(child: Text("No images selected ")),*/

                ],
              ),
            )
        )
    );

  }


  Future<List<String>> GetImageReferences() async {

    String error = "No error detected";
    List<String> urls = <String>[];
    // var firebaseUser = await FirebaseAuth.instance.currentUser();

    try {
      for (var imageFile in images) {
        await  postImage(imageFile).then((downloadUrl) {
          urls.add(downloadUrl.toString());
          print( "i am third line of awaiting post image");
          if (urls.length == images.length) {
            print(urls.length.toString() + " images selected" +
                urls.toString());

            return urls;


            // showInSnackBar('Uploaded Successfully');
            /* showDialog(context: context, builder: (_) {
              return AlertDialog(
                backgroundColor: Theme
                    .of(context)
                    .backgroundColor,
                content: Text("Uploaded Successfully",
                    style: TextStyle(color: Colors.white)),
              );
            }
            );*/

          }
        }).catchError((err) {
          print(err);
        });
      }
    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }
    return urls;

  }



  Widget ReadImagesFromFirebaseStorage(){


    return Row(
        children: <Widget>[
          Expanded(
              child:SizedBox(
                  height: 500,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('PostAdd').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                _listOfImages = [];
                                for (int i = 0;
                                i <
                                    snapshot.data.documents[index].data['Image Urls']
                                        .length;
                                i++) {
                                  _listOfImages.add(NetworkImage(snapshot
                                      .data.documents[index].data['Image Urls'][i]));
                                }
                                return Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(10.0),
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Carousel(
                                          boxFit: BoxFit.cover,
                                          images: _listOfImages,
                                          autoplay: false,
                                          indicatorBgPadding: 5.0,
                                          dotPosition: DotPosition.bottomCenter,
                                          animationCurve: Curves.fastOutSlowIn,
                                          animationDuration:
                                          Duration(milliseconds: 2000)),
                                    ),
                                    Container(
                                      height: 1,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.red,
                                    )
                                  ],
                                );
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }))

          )]
    );
  }



  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }


  Future<List<Asset>> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = "No error Detected";

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      showInSnackBar("loading images");
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));
      print("loadAssets is called");

    } on Exception catch (e) {
      error = e.toString();
      print(error);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted){
      print("Not mounted");
    }
    else {
      setState(() {
        images = resultList;
        _error = error;
      });
    }

    return images;
  }


  Widget _showExpansionList() {
    return Container(
      //margin: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 25, top: 25, bottom: 10),
      child: ExpansionTile(
        //leading:  Icon(Icons.arrow_drop_down_circle,color: Colors.blue,),
        title: Text(
          "Choose Main Features",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black45),
        ),
        trailing: Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.blue,
        ),
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: buildYear,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                            border: OutlineInputBorder(),
                            labelText: 'Build Year:',

                            errorText: _validate ? 'Value can,t be empty':null,

                            alignLabelWithHint: false,
                            filled: true,
                          ),

                          textInputAction: TextInputAction.done,



                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 140,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: parkingSpace,
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Parking Space:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),

                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: Rooms,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Rooms:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),

                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 140,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: BathRooms,
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bathrooms:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),

                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: kitchens,
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Kitchens:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),

                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 140,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: Floors,
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Floors:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),

                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // dropdownfield of flooring

        ],
      ),
    );
  }



  Widget _showExpansionListPlot() {
    return Container(
      //margin: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 25, top: 25, bottom: 10),
      child: ExpansionTile(
        //leading:  Icon(Icons.arrow_drop_down_circle,color: Colors.blue,),
        title: Text(
          "Choose Main Features",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black45),
        ),
        trailing: Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.blue,
        ),
        children: <Widget>[

          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Possession:',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 50,
                          margin: const EdgeInsets.all(7.0),
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._checkBoxVal = value);
                            },
                            value: this._checkBoxVal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Corner:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      //margin: const EdgeInsets.only(left: 25.0, top: 12),
                      margin: const EdgeInsets.only(left: 50),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal2 = value);
                        },
                        value: this._checkBoxVal2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Park Facing:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.only(left: 5.0, top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal3 = value);
                        },
                        value: this._checkBoxVal3,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Disputed:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.only(left:33,top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal4 = value);
                        },
                        value: this._checkBoxVal4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Balloted:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.only(left: 40.0, top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal5 = value);
                        },
                        value: this._checkBoxVal5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sui Gas:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.only(left: 46.0, top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal6 = value);
                        },
                        value: this._checkBoxVal6,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Water supply:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.only( top: 12,),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal7 = value);
                        },
                        value: this._checkBoxVal7,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sewarage:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.only(left: 27.0, top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal8 = value);
                        },
                        value: this._checkBoxVal8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }


  Widget _showExpansionListCommercial() {
    return Container(
      //margin: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 25, top: 25, bottom: 10),
      child: ExpansionTile(
        //leading:  Icon(Icons.arrow_drop_down_circle,color: Colors.blue,),
        title: Text(
          "Choose Main Features",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black45),
        ),
        trailing: Icon(
          Icons.arrow_drop_down_circle,
          color: Colors.blue,
        ),
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller:buildYear,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Build Year:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 140,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: parkingSpace,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Parking Space:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller:Rooms,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Rooms:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 140,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller:Floors ,

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Floors:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 50,
                        margin: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: flooring,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Flooring:',
                            errorText: _validate ? 'Value can,t be empty':null,
                            alignLabelWithHint: false,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ],
          ),

          Column(
            children: <Widget>[

              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Elevators:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 105,
                      height: 50,
                      margin: const EdgeInsets.only(left: 82.0, top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal = value);
                        },
                        value: this._checkBoxVal,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Maintenance Staff:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 105,
                      height: 50,
                      margin: const EdgeInsets.only(top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal2 = value);
                        },
                        value: this._checkBoxVal2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Security Staff:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 105,
                      height: 50,
                      margin: const EdgeInsets.only(left: 44.0, top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal3 = value);
                        },
                        value: this._checkBoxVal3,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Waste Disposal:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 105,
                      height: 50,
                      margin: const EdgeInsets.only(left: 27.0, top: 12),
                      child: Checkbox(
                        onChanged: (bool value) {
                          setState(() => this._checkBoxVal4 = value);
                        },
                        value: this._checkBoxVal4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Flooring  text field goes here



        ],
      ),
    );
  }
  Widget _hideExpansionList() {
    return Visibility(
      visible: false,
      child: Container(
        //margin: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: 25, top: 25, bottom: 10),
        child: ExpansionTile(
          //leading:  Icon(Icons.arrow_drop_down_circle,color: Colors.blue,),
          title: Text(
            "Choose Main Features",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black45),
          ),
          trailing: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }


}