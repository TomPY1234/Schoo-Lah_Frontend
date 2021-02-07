import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/services/user_service_rest.dart';
import 'package:schoolah_mobile_app/studentScreens/widgets/student_navbar.dart';
import '../models/user.dart';
import 'widgets/student_drawer.dart';

class StudentHomePageScreen extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePageScreen> {
  User user;

  @override
  Widget build(BuildContext context) {
    final dataService = UserServiceRest();

    return FutureBuilder<User>(
        future: dataService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data;
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              floating: true,
              elevation: 0,
              snap: true,
              backgroundColor: Theme.of(context).primaryColorDark,
              brightness: Brightness.light,
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColorDark
              ],
            ),
          ),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Hello,',
                          style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w300,
                              fontSize: 28,
                              color: Theme.of(context).primaryColorLight)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text('${user.name}',
                            style: TextStyle(
                                fontFamily: "pop",
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: Theme.of(context).primaryColorLight)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: homeCategoryItem(
                                    context,
                                    Colors.green,
                                    'assets/study.png',
                                    'Subjects',
                                    Colors.greenAccent,
                                    'Subjects'),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: homeCategoryItem(
                                    context,
                                    Colors.purple,
                                    'assets/financial.png',
                                    'Financial',
                                    Colors.purpleAccent,
                                    'Financial'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: homeCategoryItem(
                                    context,
                                    Colors.lime,
                                    'assets/ebook.png',
                                    'E-Bookstore',
                                    Colors.limeAccent,
                                    'E-Bookstore'),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: homeCategoryItem(
                                    context,
                                    Colors.orange,
                                    'assets/qrcode.png',
                                    'QR Scan',
                                    Colors.red,
                                    'QR Scan'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Popular ',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColorLight,
                                )),
                            TextSpan(
                                text: 'Subjects',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      horizontalScrollCourseItem(context, 'assets/SCIENCE.png',
                          'Science', 'Intresting in Science in Real Life'),
                      horizontalScrollCourseItem(
                          context,
                          'assets/BAHASA MALAYSIA.png',
                          'Bahasa Melayu',
                          'Memahami Bahasa Kebangsaan Kita'),
                      horizontalScrollCourseItem(
                          context,
                          'assets/MATHEMATICS.png',
                          'Mathematics',
                          'Calculation and Mathematics Logic'),
                      SizedBox(width: 16),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: 'News ', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Theme.of(context).primaryColorLight,
                            )),

                            TextSpan(text: 'Kementerian Pendidikan Malaysia ', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Theme.of(context).primaryColor,
                            )),

                            TextSpan(text: '(KPM)', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Theme.of(context).primaryColorLight,
                            )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 570,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      horizontalScrollNewsItem(context, 'assets/news1.jpg', 'Road to Success SPM 2020', '\nWatch Road to Success SPM 2020 \nevery day at DIDIK TV@NTV7'),

                      horizontalScrollNewsItem(context, 'assets/news2.jpg', 'Notis Pemakluman', '\nPemohoman Bagi Menduduki\nPeperiksaan Perkhidmatan Awam\nKementerian Pendidikan Malaysia\nSesi 1 Tahun 2021 Ditunda'),

                      horizontalScrollNewsItem(context, 'assets/news3.jpg', 'Buku Teks Digital Asas', '\nHow to download digital textbooks \nthrough DELIMa'),

                      SizedBox(width: 16),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('© SCHOO-LAH @ By Team Exia', style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Theme.of(context).primaryColorLight,
                    )),
                  ],
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(),
      endDrawer: DrawerView(),
    );
  }

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching current user... Please wait'),
          ],
        ),
      ),
    );
  }
}

//---------------------------------------------------------------------------------------
Widget homeCategoryItem(
    BuildContext context,
    Color primaryColor,
    String primaryIcon,
    String primaryTitle,
    Color secondaryColor,
    String dashboard) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: primaryColor.withOpacity(0.4),
          blurRadius: 10,
          offset: Offset(0.0, 6),
        ),
      ],
      color: primaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (dashboard == 'Subjects') {
            Navigator.pushNamed(context, studSubject);
          } else if (dashboard == 'Financial') {
            Navigator.pushNamed(context, studFee);
          } else if (dashboard == 'E-Bookstore') {
            Navigator.pushNamed(context, studBook);
          } else {
            Navigator.pushNamed(context, QRStudentcode);
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(primaryIcon, height: 45),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          primaryTitle,
                          style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_forward_ios_outlined),
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget horizontalScrollCourseItem(BuildContext context, String courseImage,
    String courseTitle, String courseDesc) {
  return Padding(
    padding: const EdgeInsets.only(left: 16),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Image.asset(courseImage),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(courseTitle + '\n~ ' + courseDesc,
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Theme.of(context).primaryColorLight)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget horizontalScrollNewsItem(BuildContext context, String newsImage, String newsTitle, String newsDesc)
{
  return Padding(
    padding: const EdgeInsets.only(left: 16),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Image.asset(newsImage),
              ),
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(newsTitle+'\n'+newsDesc, style: TextStyle(
                  fontFamily: "pop",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Theme.of(context).primaryColorLight),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}