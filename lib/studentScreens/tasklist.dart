import 'package:flutter/material.dart';

class StudentTaskListScreen extends StatefulWidget
{
  @override 
  _StudentTaskListState createState() => _StudentTaskListState();
}

class _StudentTaskListState extends State <StudentTaskListScreen>
{
  int _selectedIndex = 1;

  void _onItemTapped(int index)
  {
    if (index == 0)
    { setState(() { _selectedIndex = index; }); }
    else if (index == 1)
    { setState(() { _selectedIndex = index; });}
    else 
    { setState(() { _selectedIndex = index; });}
  }

  @override 
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.settings, size: 40.0),
        title: Column(
          children: <Widget> [
            Text('MATHEMATICS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('YEAR 3', style: TextStyle(fontSize: 15)),
          ],
        ),
        centerTitle: true,
        actions: <Widget> [
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
          itemCount: 4,
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemBuilder: (context, index) => ListTile(
            tileColor: Colors.greenAccent[400],
            title: Text(
              'Exercise 1 : Number Up to 10 000', 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough
              )
            ),
            onTap: () {},
          ),
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {},
            label: Text('Update'),
            icon: Icon(Icons.check_circle),
          ),
          
          Text('   '),
          
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {},
            label: Text('Cancel'),
            icon: Icon(Icons.cancel),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem> [
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
        selectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
    );
  }
}
