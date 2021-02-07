import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/mainScreens/view.dart';
import 'package:schoolah_mobile_app/models/user.dart';
import 'package:schoolah_mobile_app/teacherScreens/studentlist_viewmodel.dart';
import 'package:schoolah_mobile_app/teacherScreens/widgets/teacher_drawer.dart';

class TeacherStudentListScreen extends StatefulWidget {
  @override
  _TeacherStudentListState createState() => _TeacherStudentListState();
}

class _TeacherStudentListState extends State<TeacherStudentListScreen> {
  int _selectedIndex = 1;
  List<User> students;

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
    return View<UserlistViewmodel>(
        initViewmodel: (viewmodel) => viewmodel.getStudentList(),
        builder: (context, viewmodel, _) {
          if (viewmodel.busy) {
            return _buildFetchingDataScreen();
          }
          students = viewmodel.users;
          return _buildMainScreen();
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
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, teachHome);
                  }),
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
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0.0, 6),
                            ),
                          ],
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                  'Total Students : \n\n${students.length} student(s)',
                                  style: TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.white)),
                              SizedBox(width: 20),
                              Image.asset('assets/classroom.png', height: 120),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'My ',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColorLight,
                                )),
                            TextSpan(
                                text: 'Students',
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
                for (var user in students)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.4),
                            blurRadius: 10,
                            offset: Offset(0.0, 6),
                          ),
                        ],
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                              '${user.name}\nYear ${user.year}\n${user.school}\n${user.phone}',
                                              style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Image.asset('assets/student.jpg',
                                        width: 60, color: Colors.deepPurple),
                                    decoration: BoxDecoration(
                                        color: Colors.purpleAccent,
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
      endDrawer: TeacherDrawerView(),
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
            Text('Fetching student list... Please wait'),
          ],
        ),
      ),
    );
  }
}
