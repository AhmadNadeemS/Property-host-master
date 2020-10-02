

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './widgets/TextIcon.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    Widget imageSliderCarousel = Container(
      height: 200,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage('assets/1.jpg'),
          AssetImage('assets/2.jpg'),
          AssetImage('assets/3.jpg'),
        ],
        autoplay: false,
        indicatorBgPadding: 1.0,
        dotSize: 4.0,
        dotColor: Colors.blue,
        dotBgColor: Colors.transparent,
      ),
    );
    createAlertDialog(BuildContext context) {
      TextEditingController Controller = TextEditingController();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter Your Offer Price'),
              content: TextField(
                keyboardType: TextInputType.number,
                controller: Controller
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Make Offer'),
                  onPressed: () {},
                )
              ],
            );
          });
    }

    createContactDialog(BuildContext context) {
      TextEditingController Controller = TextEditingController();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Contact information\n\n'
                  '03365543873\n\n'
                  'faraz@gmail.com\n\n'
                  'or send a message hear'),
              content: TextField(
                controller: Controller,
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('send'),
                  onPressed: () {},
                )
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Property Host'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey[700],
            pinned: false,
            floating: false,
            expandedHeight: 256,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  imageSliderCarousel,
                  Positioned(
                    bottom: 20,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              FontAwesomeIcons.tag,
                              size: 20,
                              color: Colors.amber,
                            ),
                          ),
                          Text('20,000'
                              //property.priceFormatted,
                              // style: Theme.of(context).textTheme.title,
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Villa, Islamabad',
                    style: Theme.of(context)
                        .textTheme
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
                        TextIcon(
                          icon: FontAwesomeIcons.bed,
                          text: "Bedroom",
                        ),
                        TextIcon(
                          icon: FontAwesomeIcons.shower,
                          text: "Bathroom",
                        ),
                        TextIcon(
                          icon: FontAwesomeIcons.home,
                          text: "1 Kanal",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Summary",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                        "A beautiful villa sitauted in Islamabad. Please do not disappoint by asking for negotiation"),
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
                        style: Theme.of(context)
                            .textTheme
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
                                    width: 100,
                                    child: Text(
                                      'Type: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('House'),
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

                                Text('20,000'),
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

                                Flexible(child: Text('DHA Defence, Islamabad')),
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

                                Text('1 Kanal'),
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

                                Text('For Sale'),
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
                        style: Theme.of(context)
                            .textTheme
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
                                    width: 100,
                                    child: Text(
                                      'Built in Year: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('2019'),
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
                                    width: 100,
                                    child: Text(
                                      'Parking Spaces: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('2'),
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
                                    width: 100,
                                    child: Text(
                                      'Beds: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Flexible(child: Text('4')),
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
                                    width: 100,
                                    child: Text(
                                      'Bathrooms: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('2'),
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
                                    width: 100,
                                    child: Text(
                                      'Kitchens: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('2'),
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
                                    width: 100,
                                    child: Text(
                                      'Floors: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('2'),
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
                                    width: 100,
                                    child: Text(
                                      'Drawing Room: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('Yes'),
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
                                    width: 100,
                                    child: Text(
                                      'Dining Room: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('2'),
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
                                    width: 100,
                                    child: Text(
                                      'Furnished: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('No'),
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
                                    width: 100,
                                    child: Text(
                                      'Flooring: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('Marble'),
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
                                    width: 100,
                                    child: Text(
                                      'Available Days: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('Fri-Sun:'),
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
                                    width: 100,
                                    child: Text(
                                      'Available Time: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  width: 50,
                                ),

                                Text('1-3pm'),
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
            Row(
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
                      decoration: BoxDecoration(color: Colors.grey[800]),
                      child: Center(
                        child: Text(
                          "Make Offer",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                      decoration: BoxDecoration(color: Colors.grey[800]),
                      child: Center(
                        child: Text(
                          "Contact",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ])),
        ],
      ),
    );
  }
}
