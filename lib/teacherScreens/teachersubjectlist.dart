import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/services/todo_service_rest.dart';
import '../models/todo.dart';

class TeacherSubjectListScreen extends StatefulWidget {
  @override
  _TeacherSubjectListState createState() => _TeacherSubjectListState();
}

class _TeacherSubjectListState extends State<TeacherSubjectListScreen> {
  int _selectedIndex = 1;
  List<Todo> _todos;

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

  final dataService = TodoServiceRest();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
        future: dataService.getAllTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _todos = snapshot.data;
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
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () => Navigator.pushNamed(context, teachHome),
              ),
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
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0.0, 6),
                            ),
                          ],
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                  'Learning Today,\nLeading Tomorrow\n\n~ Present By\n     Schoo-Lah',
                                  style: TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.white)),
                              SizedBox(width: 10),
                              Image.asset('assets/subject.png', height: 120),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: 'My ', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Theme.of(context).primaryColorLight,
                            )),

                            TextSpan(text: 'Subjects', style: TextStyle(
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
                for (var todo in _todos)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.4),
                            blurRadius: 10,
                            offset: Offset(0.0, 6),
                          ),
                        ],
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {
                            dataService.setCurrentTodo(currtodo: todo);
                            Navigator.pushNamed(context, teachTask);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 140,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 4,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            'assets/${todo.title.toUpperCase()}.png',
                                            height: 80),
                                        SizedBox(height: 10),
                                        Text(
                                            'TOTAL TASKS CREATED : ${todo.items.length} TASKS',
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:
                                        Icon(Icons.arrow_forward_ios_outlined),
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
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
      endDrawer: Drawer(
        child: DrawerHeader(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Menu',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.black)),
                tileColor: Theme.of(context).accentColor,
              ),
              CheckboxListTile(
                title: Text('Change Theme Color', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                subtitle: changeModeNotifier.value ? Text('Dark Mode') : Text('Light Mode'),
                value: changeModeNotifier.value,
                onChanged: (newValue) => changeModeNotifier.value = newValue,
              ),
              ListTile(
                title: Text('Subjects',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, teacherSubject);
                },
                trailing: Image.asset('assets/study.png', height: 30),
              ),
              ListTile(
                title: Text('Students',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, '/teacherstudentlist');
                },
                trailing: Image.asset('assets/student.jpg', height: 24),
              ),
              ListTile(
                title: Text('QR History',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, teachQR);
                },
                trailing: Image.asset('assets/qrcode.png', height: 30),
              ),
              ListTile(
                title: Text('My Profile',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, teachProfile);
                },
                trailing: Icon(Icons.account_circle_rounded, size: 30),
              ),
              ListTile(
                title: Text('Logout',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
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
            Text('Fetching data... Please wait'),
          ],
        ),
      ),
    );
  }
}
