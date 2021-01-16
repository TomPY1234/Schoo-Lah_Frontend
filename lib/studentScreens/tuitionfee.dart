import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/fees.dart';
import 'package:schoolah_mobile_app/services/fee_data_service.dart';

import '../dependencies.dart';

class TuitionFeeScreen extends StatefulWidget {
  @override
  _TuitionFeeState createState() => _TuitionFeeState();
}

class _TuitionFeeState extends State<TuitionFeeScreen> {
  int _selectedIndex = 1;
  List<Fee> fees;

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

  @override
  Widget build(BuildContext context) {
    final FeeDataService feeDataService = service();

    return FutureBuilder<List<Fee>>(
        future: feeDataService.getFeeList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            fees = snapshot.data;
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
        title: Text('Financial Status', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(10.0),
                elevation: 1.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                  child: SizedBox(
                    height: 180.0,
                    width: 380.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('OUTSTANDING', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.0),
                        displayOutstanding(fees),
                      ],
                    ),
                  ),
                ),
              ),

              Divider(color: Colors.grey[300], height: 25),

              Text('Fee History'.toUpperCase(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              Padding(padding: EdgeInsets.only(top: 10)),

              Expanded(
                child: ListView.builder(
                  itemCount: fees.length,
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
                            '$index',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        tileColor: fees[index].feeStatus == 'PAID'
                            ? Colors.greenAccent[400]
                            : Colors.redAccent[400],
                        title: Text(
                          fees[index].monthFee.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'RM' + fees[index].amount,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
            Text('Fetching data... Please wait'),
          ],
        ),
      ),
    );
  }
}

Card topArea() => Card(
      margin: EdgeInsets.all(10.0),
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
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
            children: <Widget>[
              Text('OUTSTANDING',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text('RM 50.00',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ],
          ),
        ),
      ),
    );

displayOutstanding(List<Fee> _fees)
{
  var display;

  for (int i = 0; i < _fees.length; i++)
  {
    if (_fees[i].feeStatus == 'UNPAID')
    {
      display = Text(
        'RM' + _fees[i].amount,
        style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.red),
      );
    }
    else 
    {
      display = Text(
        'RM 0.00',
        style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.red),
      );
    }
  }

  return display;
}