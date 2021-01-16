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
      appBar: AppBar(
        title: Text('My Subjects', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () => Navigator.pushNamed(context, studHome),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15)),
              Expanded(
                child: ListView.builder(
                  itemCount: _todos.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          child: InkWell(
                            highlightColor: Colors.white.withAlpha(50),
                            onTap: () {
                              _navigate(index);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.asset('assets/${_todos[index].title.toUpperCase()}.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _todos[index].title.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 5)),
                                      Text(
                                        'TOTAL TASKS : ${widget.todo[index].items.length} TASKS',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      Divider(
                                          color: Colors.grey[300], height: 25),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              child: LinearPercentIndicator(
                                                animation: true,
                                                lineHeight: 5.0,
                                                animationDuration: 2500,
                                                percent: _todos[index].percent / 100,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                linearStrokeCap:
                                                    LinearStrokeCap.roundAll,
                                                progressColor:
                                                    getCircleAvatarColor(
                                                        _todos[index]
                                                            .percent
                                                            .toInt()),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(_todos[index]
                                                      .percent
                                                      .round()
                                                      .toString() +
                                                  '%'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'QRScan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: DrawerHeader(
          child: CheckboxListTile(
            title: Text('Change Theme Color'),
            value: changeModeNotifier.value,
            onChanged: (newValue) => changeModeNotifier.value = newValue,
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
