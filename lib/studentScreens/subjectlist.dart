import 'package:flutter/material.dart';

class StudentSubjectListScreen extends StatefulWidget
{
  @override 
  _StudentSubjectListState createState() => _StudentSubjectListState();
}

class _StudentSubjectListState extends State <StudentSubjectListScreen>
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
        title: Text('SUBJECT LIST'),
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
          itemCount: 3,
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemBuilder: (context, index) => ListTile(
            tileColor: Colors.yellow[700],
            title: Text('MATHEMATICS YEAR 3', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('TOTAL TASKS : 4 TASKS'),
            trailing: CircleAvatar(
              child: Text('50', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.yellow,
            ),
          ),
        ),
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
