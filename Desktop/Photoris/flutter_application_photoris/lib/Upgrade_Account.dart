import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_photoris/action/photographer.dart';
import 'package:flutter_application_photoris/action/user.dart';
import 'package:flutter_application_photoris/setting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Upgrade extends StatefulWidget {
  const Upgrade({Key? key}) : super(key: key);

  @override
  State<Upgrade> createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photographer = FirebaseFirestore.instance
        .collection('Photographer')
        .where("uid", isEqualTo: user!.uid)
        .snapshots();

    final key = GlobalKey<_BodyState>();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: photographer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
              ),
            );
          }
          final dynamic _photographer = snapshot.data!.docs.first.data();
          final PhotographerModel photographer =
              PhotographerModel.fromJSON(_photographer);
          photographer.id = snapshot.data!.docs.first.id;

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
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(25))),
                      backgroundColor: Colors.black12,
                      elevation: 5,
                      title: Text(
                        'Profile',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        GestureDetector(
                          child: FlutterSwitch(
                            activeText: 'ว่าง',
                            inactiveText: 'ไม่ว่าง',
                            width: 90.0,
                            height: 35.0,
                            valueFontSize: 15.0,
                            toggleSize: 30.0,
                            value: photographer.status ?? false,
                            borderRadius: 30.0,
                            padding: 8.0,
                            toggleColor: Color.fromRGBO(225, 225, 225, 1),
                            activeColor: Color.fromRGBO(82, 215, 143, 1),
                            inactiveColor: Color.fromRGBO(215, 90, 82, 1),
                            showOnOff: true,
                            onToggle: (bool value) {
                              setState(() {
                                FirebaseFirestore.instance
                                    .collection("Photographer")
                                    .doc(photographer.id)
                                    .update({"status": value});
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Container(
                              margin: EdgeInsets.only(
                                right: 50,
                              ),
                              child: Icon(Icons.menu, size: 30)),
                          onPressed: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return photographersetting(onEdit: (_) {
                                    setState(() {
                                      isEdit = true;
                                    });
                                  }, onSave: () {
                                    key.currentState!.save();
                                    setState(() {
                                      isEdit = false;
                                    });
                                  });
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: StreamBuilder<DocumentSnapshot>(
                stream: _photographer["User"].snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...");
                  }
                  final _user = UserModel.fromJSON(snapshot.data!.data());
                  return Container(
                      child: Body(
                    isEdit: isEdit,
                    user: _user,
                    photographer: photographer,
                    key: key,
                  ));
                }),
            backgroundColor: Colors.black12,
          );
        });
  }
}

class Body extends StatefulWidget {
  Body({
    Key? key,
    required this.isEdit,
    required this.user,
    required this.photographer,
  }) : super(key: key);
  final bool isEdit;
  final UserModel user;
  final PhotographerModel photographer;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? cate;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final lineIdController = TextEditingController();

  save() async {
    print(nameController.text);
    widget.user.fullname = nameController.text;
    widget.user.phone = phoneController.text;
    widget.user.website = websiteController.text;
    widget.user.lineId = lineIdController.text;

    widget.photographer.cost = cost;
    widget.photographer.location = location;
    widget.photographer.category = category;

    await FirebaseFirestore.instance
        .collection("Photographer")
        .doc(widget.photographer.id)
        .set(widget.photographer.toJSON());

    await FirebaseFirestore.instance
        .collection("User")
        .doc(widget.user.userid)
        .set(widget.user.toJSON());
  }

  selectbox(String name) {
    if (name == cate) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 12)],
      );
    } else {
      return BoxDecoration();
    }
  }

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.user.fullname!;
    phoneController.text = widget.user.phone!;
    websiteController.text = widget.user.website!;
    lineIdController.text = widget.user.lineId!;

    cost = widget.photographer.cost;
    location = widget.photographer.location;
    category = widget.photographer.category;

    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {
        currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  tapContent(List<Widget> widgets) {
    return widgets[currentTabIndex];
  }

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

  final categories = [
    "View",
    "Graduate",
    "Wedding",
    "Portrait",
    "Product",
    "Event"
  ];

  String? cost;
  String? location;
  bool status = false;
  String? category;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            backgroundColor: Colors.white,
            expandedHeight: widget.isEdit ? 800 : 660.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage("${widget.user.photo}"),
                            radius: 60.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.user.fullname}",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Text(
                            "Photographer",
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 45.0),
                            width: 250,
                            child: RaisedButton(
                              elevation: 5.0,
                              padding: EdgeInsets.all(10.0),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Upgrade()),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.pinkAccent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' 100 follow',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text(
                            "ข้อมูลส่วนตัว",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text(
                                "Name:",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              widget.isEdit
                                  ? Expanded(
                                      child: TextField(
                                        controller: nameController,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelStyle: new TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${widget.user.fullname}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 10),
                          child: Row(
                            children: [
                              Text(
                                "Tel:",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 80.0,
                              ),
                              widget.isEdit
                                  ? Expanded(
                                      child: TextField(
                                        controller: phoneController,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelStyle: new TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${widget.user.phone}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 10),
                          child: Row(
                            children: [
                              Text(
                                "Email:",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 55.0,
                              ),
                              Text(
                                "${widget.user.email}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 10),
                          child: Row(
                            children: [
                              Text(
                                "Website:",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              widget.isEdit
                                  ? Expanded(
                                      child: TextField(
                                        controller: websiteController,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelStyle: new TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${widget.user.website}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 10),
                          child: Row(
                            children: [
                              Text(
                                "Line:",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 65.0,
                              ),
                              widget.isEdit
                                  ? Expanded(
                                      child: TextField(
                                        controller: lineIdController,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelStyle: new TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${widget.user.lineId}",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 10),
                          child: Row(
                            children: [
                              Text(
                                "Location:",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              widget.isEdit
                                  ? Container(
                                      width: 200,
                                      height: 40,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            'สถานที่',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: location,
                                          iconSize: 20,
                                          elevation: 4,
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.white),
                                          items: locations
                                              .map(buildLocationItem)
                                              .toList(),
                                          onChanged: (value) => setState(
                                              () => this.location = value),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "$cost",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 10),
                          child: Row(
                            children: [
                              Text(
                                "เรตราคา:",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 35.0,
                              ),
                              widget.isEdit
                                  ? Container(
                                      width: 200,
                                      height: 40,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            'ใส่งบประมาณที่ต้องการ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: cost,
                                          iconSize: 20,
                                          elevation: 4,
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.white),
                                          items:
                                              costs.map(buildCostItem).toList(),
                                          onChanged: (value) =>
                                              setState(() => this.cost = value),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "$location",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 10),
                          child: Row(
                            children: [
                              Text(
                                "หมวด:",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 60.0,
                              ),
                              widget.isEdit
                                  ? Container(
                                      width: 195,
                                      height: 40,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            'เลือกหมวด',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          value: category,
                                          iconSize: 20,
                                          elevation: 4,
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: Colors.white),
                                          items: categories
                                              .map(buildCostItem)
                                              .toList(),
                                          onChanged: (value) => setState(
                                              () => this.category = value),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${widget.photographer.category}",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.pink,
              indicatorWeight: 4.0,
              physics: BouncingScrollPhysics(),
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.photo_album,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.article_rounded, color: Colors.black),
                ),
              ],
            ),
          ),
        ];
      },
      body: ListView(
        children: [
          tapContent([
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Portfolio",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Images(),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        "ความคิดเห็นจากลูกค้า",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "photo/Group10.png",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("10k"),
                        SizedBox(
                          width: 80,
                        ),
                        Image.asset(
                          "photo/Group11.png",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("10k"),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  hintText: "comment"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "photo/send.png",
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0; i < 10; i++)
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                            ),
                            radius: 25.0,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tosakan saran",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("ช่างภาพเหี้ยเกินนน!!"),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

DropdownMenuItem<String> buildCostItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item, style: TextStyle(fontWeight: FontWeight.bold)));
DropdownMenuItem<String> buildLocationItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item, style: TextStyle(fontWeight: FontWeight.bold)));

class Images extends StatefulWidget {
  const Images({Key? key}) : super(key: key);

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Icon(Icons.add, size: 60),
                ),
              ),
            ),
            for (int i = 0; i < 10; i++)
              Container(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "photo/cat.jpeg",
                        height: 200,
                        width: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
          ]),
    );
  }
}
