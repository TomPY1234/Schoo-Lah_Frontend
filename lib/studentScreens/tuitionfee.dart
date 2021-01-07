import 'package:flutter/material.dart';

class TuitionFeeScreen extends StatefulWidget
{
  @override 
  _TuitionFeeState createState() => _TuitionFeeState();
}

class _TuitionFeeState extends State <TuitionFeeScreen>
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
        title: Text('TUITION FEE'),
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              topArea(),
              displayFeeList(),
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
        selectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
    );
  }
}

Card topArea() => Card(
  margin: EdgeInsets.all(10.0),
  elevation: 1.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(50.0))
  ),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: SizedBox(
      height: 180.0,
      width: 380.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Text(
            'OUTSTANDING',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)
          ),

          SizedBox(height: 10.0),

          Text(
            'RM 50.00',
            style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.red)
          ),
        ],
      ),
    ),
  ),
);

Container feeItems(String item, String charge, String dateString, String status, {Color oddColor = Colors.white})
{
  return 
  Container(
    decoration: BoxDecoration(color: oddColor),
    padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
    child: Column(
      children: <Widget> [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text(item, style: TextStyle(fontSize: 16.0)),
            Text(charge, style: TextStyle(fontSize: 16.0)),
          ],
        ),
        
        SizedBox(height: 10.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text(dateString, style: TextStyle(color: Colors.grey, fontSize: 14.0)),
            Text(status, style: TextStyle(color: Colors.grey, fontSize: 14.0)),
          ],
        ),
      ],
    ),
  );
}

displayFeeList() {
  return Container(
    margin: EdgeInsets.all(15.0),
    child: Column(
      children: <Widget> [
        feeItems("January Fee", "RM 50.00", "03-01-20", "PAID", oddColor: const Color(0xFFF7F7F9)),

        feeItems("Books x 5", "RM 100.00", "03-01-20", "PAID"),

        feeItems("February Fee", "RM 50.00", "14-02-20", "PAID", oddColor: const Color(0xFFF7F7F9)),

        feeItems("March Fee", "RM 50.00", "06-03-20", "PAID"),

        feeItems("April Fee", "RM 50.00", "??-??-??", "OUTSATNDING", oddColor: const Color(0xFFF7F7F9)),
      ]
    ),
  );
}

/*
Container(
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
            tileColor: Colors.green[50],
            title: Text('JANUARY FEE'),
            trailing: CircleAvatar(
              child: Text('P', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.green,
            ),
          ),
        ),
      )
*/

/*
child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                height: 180.0,
                width: 380.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Text(
                      'OUTSTANDING',
                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)
                    ),

                    SizedBox(height: 10.0),

                    Text(
                      'RM 50.00',
                      style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.red)
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 10.0),

            Container(
              child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => Divider(color: Colors.black),
              itemBuilder: (context, index) => ListTile(
                tileColor: Colors.green[50],
                title: Text('JANUARY FEE'),
                trailing: CircleAvatar(
                  child: Text('P', style: TextStyle(color: Colors.black)),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            ),
          ],
        ),
        */