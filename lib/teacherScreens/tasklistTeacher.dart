import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import 'package:schoolah_mobile_app/services/todo_data_service.dart';
import '../dependencies.dart';

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
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Text('Task Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () => Navigator.pushNamed(context, teacherSubject),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${_data.title}'.toUpperCase(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              Padding(padding: EdgeInsets.only(top: 15)),

              Expanded(
                child: ListView.builder(
                  itemCount: _data.items.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: Text(
                            '${index+1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        tileColor: Colors.greenAccent[400],
                        title: Text( _data.items[index].title),
                        onLongPress: () => setState(() => _data.items.removeAt(index)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('   '),
          FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColorLight,
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
