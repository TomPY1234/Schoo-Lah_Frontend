import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import 'package:schoolah_mobile_app/services/todo_service_rest.dart';
import 'widgets/student_drawer.dart';

class StudentTaskListScreen extends StatefulWidget {
  @override
  _StudentTaskListState createState() => _StudentTaskListState();
}

class _StudentTaskListState extends State<StudentTaskListScreen> {
  int _selectedIndex = 1;
  final dataService = TodoServiceRest();
  Todo todos;
  bool toggle = false;
  var count = new List(30);

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
      Navigator.pushNamed(context, studHome);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, studProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Todo>(
        future: dataService.getCurrentTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            todos = snapshot.data;
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
    bool _cancel(BuildContext context, bool _toggle, var _count) {
      if (_toggle == true) {
        for (int i = 0; i < todos.items.length; i++) {
          if (_count[i] == 1) {
            if (todos.items[i].completed == true) {
              setState(() => todos.items[i].completed = false);
            } else {
              setState(() => todos.items[i].completed = true);
            }
          }
        }
      }

      Navigator.pop(context, null);
      return _toggle = false;
    }

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
                onPressed: () => _cancel(context, toggle, count),
              ),
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                  '${todos.title}'.toUpperCase() +
                                      '\n\n${todos.percent.round()} % completed' +
                                      '\n\n${todos.items.asMap().length} Tasks in Total     ',
                                  style: TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.white)),
                              Image.asset('assets/subject.png', height: 120),
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
                                text: 'Tasks',
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
                for (var task in todos.items)
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
                        color: task.completed ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () => setState(() {
                            if (task.completed == true) {
                              task.completed = false;
                              toggle = true;
                            } else {
                              task.completed = true;
                              toggle = true;
                            }
                            count[todos.items.indexOf(task)] = 1;
                          }),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 80,
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
                                          child: Text('${task.title}',
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
                                    child: task.completed
                                        ? Image.asset('assets/tick.png',
                                            height: 80)
                                        : Image.asset('assets/cross.png',
                                            height: 80),
                                    decoration: BoxDecoration(
                                        color: task.completed
                                            ? Colors.greenAccent
                                            : Colors.orangeAccent,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () async {
                        final updateStatus = await dataService
                            .updateCurrentTodo(todo: todos, id: todos.id);
                        dataService.setCurrentTodo(currtodo: updateStatus);
                        Navigator.pop(context, updateStatus);
                      },
                      icon: Icon(Icons.update_outlined, size: 18),
                      label: Text("Update",
                          style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton.icon(
                      onPressed: () => _cancel(context, toggle, count),
                      icon: Icon(Icons.cancel_outlined, size: 18),
                      label: Text("Cancel",
                          style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(height: 10),
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
            Text('Fetching task... Please wait'),
          ],
        ),
      ),
    );
  }
}
