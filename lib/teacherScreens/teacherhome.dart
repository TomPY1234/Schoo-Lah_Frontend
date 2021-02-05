import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/services/user_service_rest.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';

class TeacherHomePageScreen extends StatefulWidget {
  User currUser;
  TeacherHomePageScreen(this.currUser);
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState(currUser);
}

class _TeacherHomePageState extends State<TeacherHomePageScreen> {
  User user;
  int _selectedIndex = 1;
  _TeacherHomePageState(this.user);

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/login');
    } else if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, teachHome);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, teachProfile);
    }
  }

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
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);
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
              colors: [Theme.of(context).accentColor, Theme.of(context).primaryColorDark],
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
                      Text('Hello,', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w300, fontSize: 28, color: Theme.of(context).primaryColorLight)),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text('${user.name}', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w700, fontSize: 30, color: Theme.of(context).primaryColorLight)),
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
                                    'Subjects'
                                  ),
                                ),
                              ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: homeCategoryItem(
                                  context,
                                  Colors.purple,
                                  'assets/student.jpg', 
                                  'Students',
                                  Colors.purpleAccent,
                                  'Students'
                                ),
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
                                  Colors.orange,
                                  'assets/qrcode.png',
                                  'QR History',
                                  Colors.red,
                                  'QR History'
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: homeCategoryItem(
                                  context,
                                  Colors.lime,
                                  'assets/comingsoon.png',
                                  'Coming Soon',
                                  Colors.limeAccent,
                                  'Coming Soon'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: 'Subjects ', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Theme.of(context).primaryColorLight,
                            )),

                            TextSpan(text: 'in Schoo-Lah', style: TextStyle(
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
                      horizontalScrollCourseItem(context, 'assets/SCIENCE.png', 'Science', 'Intresting in Science in Real Life'),

                      horizontalScrollCourseItem(context, 'assets/BAHASA MALAYSIA.png', 'Bahasa Melayu', 'Memahami Bahasa Kebangsaan Kita'),

                      horizontalScrollCourseItem(context, 'assets/MATHEMATICS.png', 'Mathematics', 'Calculation and Mathematics Logic'),

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

                      horizontalScrollNewsItem(context, 'assets/news2.jpg', 'Notis Pemakluman', '\nPemohoman Bagi Menduduki Peperiksaan\nPerkhidmatan Awam Kementerian\nPendidikan Malaysia Sesi 1 Tahun 2021\nDitunda'),

                      horizontalScrollNewsItem(context, 'assets/news3.jpg', 'Buku Teks Digital Asas', '\nHow to download digital textbooks \nthrough DELIMa'),

                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedFontSize: 12,
        onTap: _onItemTapped,
      ),

      endDrawer: Drawer(
        child: DrawerHeader(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Menu', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black)),
                tileColor: Theme.of(context).accentColor,
              ),

              CheckboxListTile(
                title: Text('Change Theme Color', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                subtitle: changeModeNotifier.value ? Text('Dark Mode') : Text('Light Mode'),
                value: changeModeNotifier.value,
                onChanged: (newValue) => changeModeNotifier.value = newValue,
              ),

              ListTile(
                title: Text('Subjects', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, teacherSubject); },
                trailing: Image.asset('assets/study.png', height: 30),
              ),

              ListTile(
                title: Text('Students', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, '/teacherstudentlist'); },
                trailing: Image.asset('assets/student.jpg', height: 24),
              ),

              ListTile(
                title: Text('QR History', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, teachQR); },
                trailing: Image.asset('assets/qrcode.png', height: 30),
              ),

              ListTile(
                title: Text('My Profile', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, teachProfile); },
                trailing: Icon(Icons.account_circle_rounded, size: 30),
              ),

              ListTile(
                title: Text('Logout', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, '/login'); },
                trailing: Icon(Icons.logout),
              ),
            ],
          ),
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
        ),
      ),
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
Widget homeCategoryItem(BuildContext context, Color primaryColor, String primaryIcon, String primaryTitle, Color secondaryColor, String dashboard)
{
  return Container(
    decoration: BoxDecoration(boxShadow: [
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
          if (dashboard == 'Subjects')
          { Navigator.pushNamed(context, teacherSubject); }
          else if (dashboard == 'Students')
          { Navigator.pushNamed(context, '/teacherstudentlist'); }
          else if (dashboard == 'QR History')
          { Navigator.pushNamed(context, teachQR); }
          else 
          {}
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
                        child: Text(primaryTitle, style: TextStyle(
                            fontFamily: "pop",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white
                          ),
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
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget horizontalScrollCourseItem(BuildContext context, String courseImage, String courseTitle, String courseDesc)
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
                child: Image.asset(courseImage),
              ),
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(courseTitle+'\n'+courseDesc, style: TextStyle(
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