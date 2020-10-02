import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'AppLogic/validation.dart';
import 'models/ImageUploadModel.dart';




class PostAdd extends StatefulWidget {
  @override
  _PostAddState createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd> {
  List<Object> images = List<Object>();
  Future<File> _imageFile;

  String title,description,price;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  //String msg = 'Flutter RaisedButton example';
  String dropdownTo;
  String dropdownFrom;
  String dropdownCondition;
  String _selectedProvince;
  String _selectedPurpose;
  String _selectedpropertyType;
  String _selectedpropertyDetailType;
  String _selectedUnitArea;
  String _selectedpropertyTypeHomes;
  String _selectedpropertyTypePlots;
  String _selectedpropertyTypeCommercial;
  String _selectedCity;
  String _selectedPropertyTypeData;
  String _btn1SelectedVal;
  String _btn2SelectedVal;
  List<String> _categories;
  String _selectedCategory;

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
  String province_id;
  List<String> _purpose = ['For Sale', 'Rent'];
  List<String> _propertyType = ['Homes', 'Plots', 'Commercial'];
  List<String> _propertyTypeHomes = [
    'House',
    'Flat',
    'Upper Portion',
    'Lower Portion',
    'Farm House',
    'Room',
    'Pent House'
  ];
  List<String> _UnitArea =[
    'Marla',
    'Canal'
  ];

  List<String> _propertyTypeHouse = [
    'House',
  ];
  List<String> _propertyTypeFlat = [
    'Flat',
  ];
  List<String> _propertyTypeUpperPortion = [
    'Upper Portion',
  ];
  List<String> _propertyTypeLowerPortion = [
    'Lower Portion',
  ];
  List<String> _propertyTypeFarmHouse = [
    'Farm House',
  ];
  List<String> _propertyTypePlots = [
    'Residential Plot',
    'Commerical Plot',
    'Agricultural Plot',
    'Industrial Land',
    'Plot File',
    'Plot Form'
  ];
  List<String> _propertyTypeResidentialPlot = [
    'Residential Plot',
  ];
  List<String> _propertyTypeCommericalPlot = [
    'Commerical Plot',
  ];
  List<String> _propertyTypeAgriculturalPlot = [
    'Agricultural Plot',
  ];
  List<String> _propertyTypeCommercial = [
    'Office',
    'Shop',
    'WareHouse',
    'Factory',
    'Building',
    'Other'
  ];
  List<String> _propertyTypeOffice = [
    'Office',
  ];
  List<String> _propertyTypeShop = [
    'Shop',
  ];
  List<String> _propertyTypeWareHouse = [
    'WareHouse',
  ];
  List<String> _propertyTypeFactory = [
    'Factory',
  ];
  List<String> _propertyTypeBuilding = [
    'Building',
  ];
  List<String> _propertyTypeOther = [
    'Other',
  ];
  List<String> _province = ['Sindh', 'Balouchistan', 'KPK', 'Punjab'];
  String state_id;
  List<String> _sindhCities = [
    'Karachi',
    'Hyderabad',
    'Sukkur',
  ];
  List<String> _punjabCities = [
    'Islamabad',
    'Rawalpindi',
    'Lahore',
  ];
  List<String> _kpkCities = [
    'Peshawar',
    'Abbotabad',
    'Mardan',
  ];
  List<String> _balouchCities = [
    'Gawadar',
    'Sui',
    'Quetta',
  ];
  final List<String> _listItem = [
    'img/1.jpg',
    'img/2.jpg',
    'img/3.jpg',
    'img/1.jpg',
  ];

  static const menuItems = <String>[
    'Tiles',
    'Marble',
    'Wooden',
    'Cement',
    'Other'
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItemss = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
  )
      .toList();
  static const conditionItems = <String>[
    'Allowed',
    'Not Allowed',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = conditionItems
      .map(
        (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
  )
      .toList();

  List<String> _getCities() {
    switch (_selectedProvince) {
      case ("Sindh"):
        return _sindhCities;

      case ("Punjab"):
        return _punjabCities;

      case ("Balouchistan"):
        return _balouchCities;

      case ("KPK"):
        return _kpkCities;
    }
    List<String> deflt = ['Please Select Province'];
    return deflt;
  }

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
  List<String> _getPropertyTypeDetailsSelected() {
    switch (_selectedpropertyDetailType) {
      case ("House"):
        return _propertyTypeHouse;
      case ("Flat"):
        return _propertyTypeFlat;
      case ("Upper Portion"):
        return _propertyTypeUpperPortion;
      case ("Lower Portion"):
        return _propertyTypeLowerPortion;
      case ("Farm House"):
        return _propertyTypeFarmHouse;
      case ("Residential Plot"):
        return _propertyTypeResidentialPlot;
      case ("Commercial Plot"):
        return _propertyTypeCommericalPlot;
      case ("Agricultural Plot"):
        return _propertyTypeAgriculturalPlot;
      case ("Office"):
        return _propertyTypeOffice;
      case ("Shop"):
        return _propertyTypeShop;
      case ("WareHouse"):
        return _propertyTypeWareHouse;
      case ("Factory"):
        return _propertyTypeFactory;
      case ("Building"):
        return _propertyTypeBuilding;
      case ("Other"):
        return _propertyTypeOther;

    }
    List<String> deflt3 = ['Please Select Property Type'];
    return deflt3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.grey[600],
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

              //_selectedpropertyDetailType=='House'? _showExpansionList(): _selectedpropertyDetailType=='Flat'? _showExpansionList():_selectedpropertyDetailType=='Upper Portion'? _showExpansionList():_selectedpropertyDetailType=='Lower Portion'? _showExpansionList():_selectedpropertyDetailType=='Farm House'? _showExpansionList(): _selectedpropertyDetailType=='Residential Plot'? _showExpansionListPlot():_selectedpropertyDetailType=='Commercial Plot'? _showExpansionListPlot():_selectedpropertyDetailType=='Agricultural Plot'? _showExpansionListPlot(): _selectedpropertyDetailType=='Office'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Shop'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Ware House'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Factory'? _showExpansionListCommercial():_selectedpropertyDetailType=='Building'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Other'? _showExpansionListCommercial():_hideExpansionList(),

              // _showBedsInput(),
              // _showBathroomsInput(),


              //      _showButtons(),
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
              TextFormField(
                keyboardType: TextInputType.text,
                validator: validateTitle,
                onSaved: (String val){
                  title = val;
                },
                maxLines: 1,
                autofocus: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.title,
                      color: Color(0xff2470c7),
                    ),
                    labelText: 'Title'),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: ValidateDescp,
                onSaved: (String val){
                  description = val;
                },
                maxLines: 2,
                autofocus: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.description,
                      color: Color(0xff2470c7),
                    ),
                    labelText: 'Description'),
                //textAlign: TextAlign,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                autofocus: false,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Color(0xff2470c7),
                    ),
                    labelText: 'Price'),
                validator: (value) =>
                value.isEmpty ? 'Please enter price' : null,
              ),
              _getProvinceDropDown(),
              _getCityDropDown(),

              TextFormField(
                keyboardType: TextInputType.text,
                validator: ValidateLocation,
                onSaved: (String val){
                  description = val;
                },
                maxLines: 1,
                //autofocus: true,
                decoration: InputDecoration(
                    prefixIcon: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.pin_drop,
                        color: Color(0xff2470c7),
                      ),
                    ),
                    labelText: 'Enter Sector ! Example: G-10/1 ,'),

              ),
              _showonMap(),
              _getPurposeDropDown(),

              _getPropertyTypeDropDown(),

              _getPropertyTypeDetailDropDown(),
              _UnitAreaDropDown(),
              _selectedpropertyDetailType=='House'? _showExpansionList(): _selectedpropertyDetailType=='Flat'? _showExpansionList():_selectedpropertyDetailType=='Upper Portion'? _showExpansionList():_selectedpropertyDetailType=='Lower Portion'? _showExpansionList():_selectedpropertyDetailType=='Farm House'? _showExpansionList(): _selectedpropertyDetailType=='Residential Plot'? _showExpansionListPlot():_selectedpropertyDetailType=='Commercial Plot'? _showExpansionListPlot():_selectedpropertyDetailType=='Agricultural Plot'? _showExpansionListPlot(): _selectedpropertyDetailType=='Office'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Shop'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Ware House'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Factory'? _showExpansionListCommercial():_selectedpropertyDetailType=='Building'? _showExpansionListCommercial(): _selectedpropertyDetailType=='Other'? _showExpansionListCommercial():_hideExpansionList(),
              //_showAreaInput(),

             // _showArea1Input(),
              _selectMeetingTime(),

              _uploadImagesInput(),
              _showSelectImages(),
              _showAddImages(),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Submit"),
                      color:
                      isButtonPressed7 ? Colors.lightGreen : Colors.grey[200],
                      onPressed: () {
                        if(_key.currentState.validate()){
                          _key.currentState.save();
                        }
                        else{
                          setState(() {
                            _validate = true;
                          });
                        }
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

/*

  Widget _showprovinceDropDown() {
    return Form(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        child: Column(
          children: <Widget>[
            //_getCityDropDown(),
            _getProvinceDropDown(),
            //_selectedProvince == null ? Container() : _getCityDropDown(),
          ],
        ),
      ),
    ),
    );
  }

  Widget _showLocationDropDown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        child: Column(
          children: <Widget>[
            _getCityDropDown(),
            //  _getProvinceDropDown(),
            //_selectedProvince == null ? Container() : _getCityDropDown(),
          ],
        ),
      ),
    );
  }



  Widget _showPurposeDropDown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        child: Column(
          children: <Widget>[
            //_getCityDropDown(),
            _getPurposeDropDown(),
            //  _getProvinceDropDown(),
            //_selectedProvince == null ? Container() : _getCityDropDown(),
          ],
        ),
      ),
    );
  }

  Widget _showpropertyTypeDropDown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        child: Column(
          children: <Widget>[
            //_getCityDropDown(),
            _getPropertyTypeDropDown(),
            //_selectedProvince == null ? Container() : _getCityDropDown(),
          ],
        ),
      ),
    );
  }

  Widget _showpropertyTypeDetailDropDown() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Container(
        child: Column(
          children: <Widget>[
            //_getCityDropDown(),
            _getPropertyTypeDetailDropDown(),
            //_selectedProvince == null ? Container() : _getCityDropDown(),
          ],
        ),
      ),
    );
  }
*/

  Widget _getCityDropDown() {
    return Column(
      children: <Widget>[
        Container(
          height: 5,
        ),
        Row(
          children: <Widget>[
//            Icon(Icons.location_city, color: Colors.grey),
            Container(
              width: 7.0,
            ),
            Expanded(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.add_location,
                          color: Color(0xff2470c7),
                        ),
                      ),
                      labelText: 'Choose Your City'),
                  value: _selectedCity,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                  items: _getCities().map((location) {
                    return DropdownMenuItem(
                      child: Text(location),
                      value: location,
                    );
                  }).toList(),
                  validator: (value) =>
                  value == null ? 'Please select a city' : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }



  Widget _getProvinceDropDown() {
    return Row(
      children: <Widget>[
        //Icon(Icons.map, color: Colors.grey),
        Container(
          //padding: EdgeInsets.all(5),
          //margin: EdgeInsets.only(right: 10,),
          width: 7.0,
        ),
        Flexible(
          child: ButtonTheme(
            alignedDropdown: true,
            child: Container(
              //margin: EdgeInsets.only(right: 10),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  prefixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.place,
                      color: Color(0xff2470c7),
                    ),
                  ),
                  labelText: 'Please choose Your Province',
                ),
                value: _selectedProvince,
                onChanged: (newValue) {
                  setState(() {
                    _selectedProvince = newValue;
                    _selectedCity = _getCities().first;
                  });
                },
                items: _province.map((province) {
                  return DropdownMenuItem(
                    child: Text(province),
                    value: province,
                  );
                }).toList(),
                validator: (value) =>
                value == null ? 'Please select a province' : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showonMap() {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RaisedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.map,
                color: Colors.white,
                textDirection: TextDirection.ltr,
              ),
              label: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/choseOnMap');
                },
                child: Text(
                  'Choose Area on Map',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPurposeDropDown() {
    return Row(
      children: <Widget>[
        //Icon(Icons.map, color: Colors.grey),
        Container(
          //margin: EdgeInsets.only(left: 5,),
          //width: 7.0,
        ),
        Flexible(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  prefixIcon: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.home,
                      color: Color(0xff2470c7),
                    ),
                  ),
                  labelText: 'Choose Purpose'),
              value: _selectedPurpose,
              onChanged: (newValue) {
                setState(() {
                  _selectedPurpose = newValue;
                  //                _selectedPropertyTypeData = _getCities().first;
                });
              },
              items: _purpose.map((purpose) {
                return DropdownMenuItem(
                  child: Text(purpose),
                  value: purpose,
                );
              }).toList(),
              validator: (value) =>
              value == null ? 'Please select a purpose' : null,
            ),
          ),
        ),
      ],
    );
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

  Widget _UnitAreaDropDown() {
    return Row(
      children: <Widget>[
        //Icon(Icons.map, color: Colors.grey),
        Container(
          //margin: EdgeInsets.only(left: 5,),
          //width: 7.0,
        ),
        Flexible(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  prefixIcon: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.ac_unit,
                      color: Color(0xff2470c7),
                    ),
                  ),
                  labelText: 'Unit Area'),
              value: _selectedUnitArea,
              onChanged: (newValue) {
                setState(() {
                  _selectedUnitArea = newValue;
                  //                _selectedPropertyTypeData = _getCities().first;
                });
              },
              items: _UnitArea.map((unitarea) {
                return DropdownMenuItem(
                  child: Text(unitarea),
                  value: unitarea,
                );
              }).toList(),
              validator: (value) =>
              value == null ? 'Please select a Unit Area' : null,
            ),
            ),
          ),
      ],
    );
  }

  /*Widget _showAreaInput() {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 4),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Unit Area: ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Kanal"),
                          color: isButtonPressed1
                              ? Colors.green[400]
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              isButtonPressed1 = !isButtonPressed1;
                            });
                          },
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          splashColor: Colors.grey,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Row(
                        children: <Widget>[
                          RaisedButton(
                            child: Text("Marla"),
                            color: isButtonPressed2
                                ? Colors.green[400]
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                isButtonPressed2 = !isButtonPressed2;
                              });
                            },
                            textColor: Colors.black,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            splashColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Row(
                        children: <Widget>[
                          RaisedButton(
                            child: Text("Square Feet"),
                            color: isButtonPressed3
                                ? Colors.green[400]
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                isButtonPressed3 = !isButtonPressed3;
                              });
                            },
                            textColor: Colors.black,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            splashColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          child: Text("Square Meter"),
                          color: isButtonPressed4
                              ? Colors.green[400]
                              : Colors.grey,
                          onPressed: () {
                            setState(() {
                              isButtonPressed4 = !isButtonPressed4;
                            });
                          },
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          splashColor: Colors.grey,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Row(
                        children: <Widget>[
                          RaisedButton(
                            child: Text("Square Yards"),
                            color: isButtonPressed5
                                ? Colors.green[400]
                                : Colors.grey,
                            onPressed: () {
                              setState(() {
                                isButtonPressed5 = !isButtonPressed5;
                              });
                            },
                            textColor: Colors.black,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            splashColor: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/

/*

  Widget _showArea1Input() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 14),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Area: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        value.toString(),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.white,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
            ),
            child: Slider(
              value: value.toDouble(),
              min: 0,
              max: 100,
              activeColor: Colors.red,
              inactiveColor: Colors.black,
              label: '$value',
              onChanged: (double newValue) {
                setState(() {
                  value = newValue.round();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

*/

  Widget _uploadImagesInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 14),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Upload Images : ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showSelectImages() {
    return Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Select Images"),
//                    color:
//                        isButtonPressed6 ? Colors.lightGreen : Colors.grey[200],
//                    onPressed: () {
//                      setState(() {
//                        isButtonPressed6 = !isButtonPressed6;
//                      });
//                    },
                        textColor: Colors.black,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        splashColor: Colors.grey,
                      ),
                    ],

                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _showAddImages() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 1 / 2,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(images.length, (index) {
              if (images[index] is ImageUploadModel) {
                ImageUploadModel uploadModel = images[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: <Widget>[
                      Image.file(
                        uploadModel.imageFile,
                        width: 300,
                        height: 300,
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: InkWell(
                          child: Icon(
                            Icons.remove_circle,
                            size: 20,
                            color: Colors.red,
                          ),
                          onTap: () {
                            setState(() {
                              images.replaceRange(index, index + 1, ['Add Image']);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Card(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _onAddImageClick(index);
                    },
                  ),
                );
              }
            }),
          )),
    );
  }
  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Build Year:',
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Parking Space:',
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bedrooms:',
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Bathrooms:',
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Kitchens:',
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Floors:',
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
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Drawing Room',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 50,
                          margin: const EdgeInsets.all(8.0),
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
                        'Dining Room',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.only(left: 25.0, top: 12),
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
                        'Furnished:',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      margin: const EdgeInsets.only(left: 47.0, top: 12),
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
            ],
          ),
          ListTile(
            title: Text("Flooring: "),
            trailing: DropdownButton(
              value: _btn1SelectedVal,
              hint: Text("Choose"),
              onChanged: ((String newValue) {
                setState(() {
                  _btn1SelectedVal = newValue;
                });
              }),
              items: _dropDownMenuItems,
            ),
          ),
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Build Year:',
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Parking Space:',
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Rooms:',
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Floors:',
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
          ListTile(
            title: Text("Pet Policy: "),
            trailing: DropdownButton(
              value: _btn2SelectedVal,
              hint: Text("Choose"),
              onChanged: ((String newValue) {
                setState(() {
                  _btn2SelectedVal = newValue;
                });
              }),
              items: _dropDownMenuItems,
            ),
          ),
          ListTile(
            title: Text("Flooring: "),
            trailing: DropdownButton(
              value: _btn1SelectedVal,
              hint: Text("Choose"),
              onChanged: ((String newValue) {
                setState(() {
                  _btn1SelectedVal = newValue;
                });
              }),
              items: _dropDownMenuItemss,
            ),
          ),
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
  Widget _selectMeetingTime() {
    return Container(
      //constraints: BoxConstraints(maxWidth: 250),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  'Set Meeting Time',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          Row(
            children: <Widget>[
              Text(
                'Available Days :',
                style: TextStyle(fontSize: 15),
              ),
              Row(
                children: <Widget>[
                  Container(
                    //width: 50,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Card(
                      child: DropdownButton<String>(
                        value: dropdownTo,
                        hint: const Text('To'),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownTo = newValue;
                          });
                        },
                        items: <String>[
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              margin: EdgeInsets.only(left: 4, right: 4),
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blueGrey),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    //width: 50,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Card(
                      child: DropdownButton<String>(
                        value: dropdownFrom,
                        hint: const Text('From'),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownFrom = newValue;
                          });
                        },
                        items: <String>[
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              margin: EdgeInsets.only(left: 4, right: 4),
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blueGrey),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 10, top: 15),
                  child: Text(
                    'Mention Time :',
                    style: TextStyle(fontSize: 15),
                  )),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Container(
                      width: 200,
                      child: TextFormField(
                        maxLines: 1,
                        //autofocus: true,

                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.pin_drop,
                              color: Color(0xff2470c7),
                            ),
                            labelText: '1-3 pm ,'),

                        validator: (value) =>
                        value.isEmpty ? 'Time Field can\'t be empty' : null,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
