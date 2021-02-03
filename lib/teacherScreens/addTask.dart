import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import 'package:schoolah_mobile_app/services/todo_service_rest.dart';
import '../dependencies.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  //final Todo _data;

  //AddTaskScreen(this._data);
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  int _selectedIndex = 1;
  String title;
  Todo _data;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, teachQR);
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

  bool toggle = false;
  var count = new List(30);
  final dataService = TodoServiceRest();

  @override
  Widget build(BuildContext context) {
    //_data = todoDataService.getTodo();

    return FutureBuilder<Todo>(
        future: dataService.getCurrentTodo(),
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
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text('Add Task',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamed(context, teachTask),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(10.0),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: SizedBox(
                    height: 180.0,
                    width: 380.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.asset(
                              'assets/${_data.title.toUpperCase()}.png',
                              fit: BoxFit.cover,
                              width: double.infinity),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text('Enter Task Name',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.only(top: 15)),
              TextField(
                obscureText: false,
                onChanged: (value) => title = value,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'Task Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 15)),
              FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColorLight,
                heroTag: null,
                onPressed: () async {
                  dataService.createTodo(todo: _data, task: title);
                  final updateStatus = await dataService.updateCurrentTodo(
                      todo: _data, id: _data.id);
                  dataService.setCurrentTodo(currtodo: updateStatus);
                  Navigator.pushNamed(context, teacherSubject);
                },
                label: Text('Add Task',
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
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
            Text('Fetching current todo... Please wait'),
          ],
        ),
      ),
    );
  }
}
