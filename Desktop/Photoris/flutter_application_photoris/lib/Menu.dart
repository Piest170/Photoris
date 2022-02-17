// ignore_for_file: deprecated_member_use, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Profile.dart';

class theme extends StatelessWidget {
  const theme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Column(
          children: [
            Container(
              height: 125,
              width: double.infinity,
              child: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25))),
                backgroundColor: Colors.pinkAccent,
                elevation: 5,
                title: Text(
                  'Photoris',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: Container(
                        margin: EdgeInsets.only(
                          right: 50,
                        ),
                        child: Icon(Icons.account_circle, size: 30)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Profile()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(child: Menu()),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final costs = [
    'ต่ำกว่า 1,000 บาท',
    '1,000-5,000 บาท',
    '5,000-10,000 บาท',
    '10,000-15,000 บาท',
    '15,000 บาทขึ้นไป'
  ];
  final locations = [
    'ภาคเหนือ',
    'ภาคใต้',
    'ภาคกลาง',
    'ภาคตะวันออกเฉียงเหนือ',
    'ภาคตะวันออก'
  ];
  String? cost;
  String? location;
  String? cate;

  selectbox(String name) {
    if (name == cate) {
      return BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 12)]);
    } else {
      return BoxDecoration();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(18),
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text('ใส่งบประมาณที่ต้องการ'),
                value: cost,
                iconSize: 36,
                elevation: 4,
                isExpanded: true,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                items: costs.map(buildCostItem).toList(),
                onChanged: (value) => setState(() => this.cost = value),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(18),
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text('สถานที่'),
                value: location,
                iconSize: 36,
                elevation: 4,
                isExpanded: true,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                items: locations.map(buildLocationItem).toList(),
                onChanged: (value) => setState(() => this.location = value),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Wrap(
              spacing: 35.0,
              runSpacing: 20.0,
              direction: Axis.horizontal,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cate = "All_Photo";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: selectbox("All_Photo"),
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo_album,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: Text("All Photo"),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cate = "view";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: selectbox("view"),
                    child: Column(
                      children: [
                        Icon(
                          Icons.landscape_sharp,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: Text("View"),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cate = "graduate";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: selectbox("graduate"),
                    child: Column(
                      children: [
                        Icon(
                          Icons.school,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: Text("Graduate"),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cate = "wedding";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: selectbox("wedding"),
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: Text("Wedding"),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cate = "portrait";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: selectbox("portrait"),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: Text("Portrait"),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cate = "product";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: selectbox("product"),
                    child: Column(
                      children: [
                        Icon(
                          Icons.liquor_rounded,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: Text("Product"),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cate = "event";
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: selectbox("event"),
                    child: Column(
                      children: [
                        Icon(
                          Icons.event,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: Text("Event"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
              width: 220,
              child: RaisedButton(
                elevation: 5.0,
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.pinkAccent,
                child: Text(
                  'ค้นหา',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans'),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "ช่างภาพแนะนำ",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20, width: 20),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.8,
                children: [
                  for (int i = 0; i < 10; i++)
                    Container(
                      // padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //     spreadRadius: 5,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "photo/cat.jpeg",
                                height: 200,
                                width: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            top: 0,
                          ),
                          Positioned(
                            top: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.account_circle, size: 30),
                                  Text(
                                    "ช่างภาพแนะนำ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ]),
          )

          // Container(
          //   height: 80,
          //   margin: EdgeInsets.only(top: 20),
          //   child: GridView.count(
          //     crossAxisCount: 2,
          //     padding: EdgeInsets.symmetric(vertical: 5),
          //     crossAxisSpacing: 0,
          //     mainAxisSpacing: 0,
          //     childAspectRatio: 0.65,
          //     children: [
          //       Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(left: 0),
          //             child: Container(
          //               height: 200,
          //               width: 160,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(20),
          //                 boxShadow: [
          //                   BoxShadow(
          //                     color: Colors.grey,
          //                     spreadRadius: 5,
          //                     blurRadius: 7,
          //                     offset:
          //                         Offset(0, 3), // changes position of shadow
          //                   ),
          //                 ],
          //               ),
          //               child: Column(
          //                 children: [
          //                   ClipRRect(
          //                     borderRadius: BorderRadius.circular(20),
          //                     child: Image.asset(
          //                       "photo/cat.jpeg",
          //                       height: 160,
          //                       width: 160,
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(top: 10),
          //                     child: TextButton(
          //                       onPressed: () {},
          //                       child: Text(
          //                         "Myname",
          //                         style: TextStyle(
          //                           color: Colors.black,
          //                           fontSize: 25,
          //                           fontFamily: 'Roboto',
          //                           fontWeight: FontWeight.w700,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildCostItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item, style: TextStyle(fontWeight: FontWeight.bold)));
  DropdownMenuItem<String> buildLocationItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item, style: TextStyle(fontWeight: FontWeight.bold)));
}
