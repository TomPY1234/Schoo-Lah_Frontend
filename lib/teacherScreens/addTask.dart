import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/task.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import '../models/mock_todos.dart' as data;

class AddTaskScreen extends StatefulWidget {
  final Todo _data;

  AddTaskScreen(this._data);
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  int _selectedIndex = 1;
  String title;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/teacherhome');
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/teacherprofile');
    }
  }

  bool toggle = false;
  var count = new List(30);

  bool _cancel(BuildContext context, bool _toggle, var _count) {
    if (_toggle == true) {
      for (int i = 0; i < widget._data.items.length; i++) {
        if (_count[i] == 1) {
          if (widget._data.items[i].completed == true) {
            setState(() => widget._data.items[i].completed = false);
          } else {
            setState(() => widget._data.items[i].completed = true);
          }
        }
      }
    }

    Navigator.pop(context, null);
    return _toggle = false;
  }

  @override
  Widget build(BuildContext context) {
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        //leading: Icon(Icons.settings, size: 40.0),
        title: Text('Add Task'),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.calendar_today_rounded, size: 35.0),
          SizedBox(width: 12.0)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange[200],
              Colors.orange[50],
              Colors.orange[200],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Add task for ${widget._data.title}',
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              TextField(
                obscureText: false,
                onChanged: (value) => title = value,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'Task name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 20.0),
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  final newTask = Todo(
                      title: '${widget._data.title}',
                      items: [Task(title: title, completed: false)]);
                  data.mockData.add(newTask);
                  Navigator.pushNamed(context, '/teachersubjectlist');
                },
                label: Text('       ADD       ',
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'QRHISTORY',
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
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: DrawerHeader(
          child: CheckboxListTile(
            title: Text('Change theme color'),
            value: changeModeNotifier.value,
            onChanged: (newValue) => changeModeNotifier.value = newValue,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange[200],
                Colors.orange[50],
                Colors.orange[200],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}
