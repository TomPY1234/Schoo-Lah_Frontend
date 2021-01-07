import 'package:flutter/material.dart';

class StudentHomePageScreen extends StatefulWidget 
{
  @override 
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State <StudentHomePageScreen>
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
        title: Text('HI, AZMIN'),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              SizedBox(
                height: 220.0,
                child: Image.asset(
                  'assets/schoolah_logo.png',
                  width: 200.0,
                  height: 200.0,
                ),
              ),

              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {},
                label: Text(
                  'My Subjects',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
                icon: Icon(Icons.book_rounded),
              ),

              SizedBox(height: 30.0),

              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () => {},
                label: Text(
                  'Tuition Fee  ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
                icon: Icon(Icons.attach_money_rounded),
              ),
              
              SizedBox(height: 30.0),

              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {},
                label: Text(
                  'E-Bookstore ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
                ),
                icon: Icon(Icons.store_rounded),
              ),
            ],
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
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}