import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/services/todo_data_service.dart';
import '../dependencies.dart';
import '../models/todo.dart';
import '../studentScreens/tasklist.dart';

class StudentSubjectListScreen extends StatefulWidget {
  final List<Todo> todo;

  StudentSubjectListScreen(this.todo);
  @override
  _StudentSubjectListState createState() => _StudentSubjectListState();
}

class _StudentSubjectListState extends State<StudentSubjectListScreen> {
  int _selectedIndex = 1;
  int selected = 0;
  List<Todo> _todos;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, QRStudentcode);
    } else if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, studHome);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, studProfile);
    }
  }

  void _navigate(int index) async {
    Todo returnData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                StudentTaskListScreen(Todo.copy(widget.todo[index]))));

    if (returnData != null) {
      setState(() => widget.todo[index] = returnData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TodoDataService todoDataService = service();

    return FutureBuilder<List<Todo>>(
        future: todoDataService.getTodoList(),
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
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () => Navigator.pushNamed(context, studHome),
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Theme.of(context).accentColor, Colors.white],
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
                              Text('Learning Today,\nLeading Tomorrow\n\n~ Present By\n     Schoo-Lah', style: TextStyle(
                                fontFamily: "pop",
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                color: Colors.white
                              )),

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
                              color: Colors.black,
                            )),

                            TextSpan(text: 'Subjects', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Colors.orange,
                            )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                
                for (var todo in _todos) 
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
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
                          selected = _todos.indexOf(todo);
                          _navigate(selected); 
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/${todo.title.toUpperCase()}.png', height: 80),

                                      SizedBox(height: 10),

                                      Row(children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 15, right: 15),
                                            child: LinearPercentIndicator(
                                              animation: true,
                                              lineHeight: 16.0,
                                              animationDuration: 2500,
                                              percent: todo.percent / 100,
                                              backgroundColor: Colors.white,
                                              linearStrokeCap: LinearStrokeCap.roundAll,
                                              progressColor: getCircleAvatarColor(todo.percent.toInt()),
                                              center: Text(todo.percent.round().toString() + ' %', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 3),

                                      Text('TOTAL TASKS : ${todo.items.length} TASKS', style: TextStyle(
                                        fontFamily: "pop",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Colors.white)
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
                                    color: Colors.greenAccent,
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
                subtitle: changeModeNotifier.value ? Text('Pink') : Text('Orange'),
                value: changeModeNotifier.value,
                onChanged: (newValue) => changeModeNotifier.value = newValue,
              ),

              ListTile(
                title: Text('Subjects', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, studSubject); },
                trailing: Image.asset('assets/study.png', height: 30),
              ),

              ListTile(
                title: Text('Financial', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, studFee); },
                trailing: Image.asset('assets/financial.png', height: 30),
              ),

              ListTile(
                title: Text('E-Bookstore', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, studBook); },
                trailing: Image.asset('assets/ebook.png', height: 30),
              ),

              ListTile(
                title: Text('QR Scan', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, QRStudentcode); },
                trailing: Image.asset('assets/qrcode.png', height: 30),
              ),

              ListTile(
                title: Text('My Profile', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, studProfile); },
                trailing: Icon(Icons.account_circle_rounded, size: 30),
              ),

              ListTile(
                title: Text('Logout', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, '/login'); },
                trailing: Icon(Icons.logout),
              ),
            ],
          ),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
            Text('Fetching todo... Please wait'),
          ],
        ),
      ),
    );
  }
}

Color getCircleAvatarColor(int percent) {
  if (percent >= 80) {
    return Colors.lightGreenAccent;
  } else if (percent >= 60 && percent <= 79) {
    return Colors.yellow[600];
  } else if (percent >= 30 && percent <= 59) {
    return Colors.orangeAccent[400];
  } else {
    return Colors.red;
  }
}

Color getTileColor(int percent) {
  if (percent >= 80) {
    return Colors.green[200];
  } else if (percent >= 60 && percent <= 79) {
    return Colors.yellow[300];
  } else if (percent >= 30 && percent <= 59) {
    return Colors.orangeAccent[100];
  } else {
    return Colors.red[200];
  }
}