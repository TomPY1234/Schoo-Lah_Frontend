import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/task.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import 'package:schoolah_mobile_app/services/todo_data_service.dart';
import 'package:schoolah_mobile_app/teacherScreens/addTask.dart';
import '../dependencies.dart';
import '../models/mock_todos.dart' as task;
import '../models/mock_todos.dart' as data;

class TaskListScreen extends StatefulWidget {
  //Todo _data;

  //TaskListScreen(this._data);
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // final TextEditingController _textFieldController = TextEditingController();
  int _selectedIndex = 1;
  String title;
  Todo _data;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/qrsubjectlist');
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

  /*void _navigate(Todo todo) async {
    Todo returnData = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddTaskScreen(todo)));

    if (returnData != null) {
      setState(() => todo = returnData);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final TodoDataService todoDataService = service();
    //_data = todoDataService.getTodo();

    return FutureBuilder<Todo>(
        future: todoDataService.getTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _data = snapshot.data;
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        //leading: Icon(Icons.settings, size: 40.0),
        title: Column(
          children: <Widget>[
            Text('${_data.title}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            //Text('YEAR 3', style: TextStyle(fontSize: 15)),
          ],
        ),
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
        child: ListView.separated(
          itemCount: _data.items.length,
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemBuilder: (context, index) => ListTile(
            tileColor: Colors.greenAccent[400],
            title: Text(
              _data.items[index].title,
              // style: widget._data.items[index].completed
              //     ? TextStyle(decoration: TextDecoration.lineThrough)
              //     : TextStyle(decoration: null),
            ),
            // onTap: () => setState(() {
            //   if (widget._data.items[index].completed == true) {
            //     widget._data.items[index].completed = false;
            //     toggle = true;
            //     count[index] = 1;
            //   } else {
            //     widget._data.items[index].completed = true;
            //     toggle = true;
            //     count[index] = 1;
            //   }
            // }),
            onLongPress: () => setState(() => _data.items.removeAt(index)),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('   '),
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {
              Navigator.pushNamed(context, teachAddTask);
              //_navigate(_data);
            },
            tooltip: 'Add Item',
            label: Text('Add'),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'QRGenerator',
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
        selectedItemColor: Colors.grey[500],
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

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching current todo... Please wait'),
          ],
        ),
      ),
    );
  }
}
