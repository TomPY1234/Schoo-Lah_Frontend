import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/fees.dart';
import 'package:schoolah_mobile_app/services/fee_service_rest.dart';

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
      Navigator.pushNamed(context, '/login');
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
    final dataService = FeeServiceRest();

    return FutureBuilder<List<Fee>>(
        future: dataService.getAllFees(),
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              floating: true,
              elevation: 0,
              snap: true,
              backgroundColor: Theme.of(context).primaryColorDark,
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () => Navigator.pushNamed(context, studHome),
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Theme.of(context).accentColor, Theme.of(context).primaryColorDark],
            ),
          ),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0.0, 6),
                            ),
                          ],
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Outstanding\n\n' + displayOutstanding(fees),
                                  style: TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.white)),
                              SizedBox(width: 30),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.asset('assets/finance.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Transaction ',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColorLight,
                                )),
                            TextSpan(
                                text: 'History',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                for (var finance in fees)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.4),
                            blurRadius: 10,
                            offset: Offset(0.0, 6),
                          ),
                        ],
                        color: finance.feeStatus == 'PAID'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                              '${finance.monthFee.toUpperCase()}\nRM ${finance.amount}\n${finance.date}',
                                              style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: finance.feeStatus == 'PAID'
                                        ? Image.asset('assets/tick.png',
                                            height: 80)
                                        : Image.asset('assets/cross.png',
                                            height: 80),
                                    decoration: BoxDecoration(
                                        color: finance.feeStatus == 'PAID'
                                            ? Colors.greenAccent
                                            : Colors.orangeAccent,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(40),
                                          topLeft: Radius.circular(40),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
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
        selectedFontSize: 12,
        onTap: _onItemTapped,
      ),
      endDrawer: Drawer(
        child: DrawerHeader(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Menu',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.black)),
                tileColor: Theme.of(context).accentColor,
              ),
              CheckboxListTile(
                title: Text('Change Theme Color',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle:
                    changeModeNotifier.value ? Text('Dark Mode') : Text('Light Mode'),
                value: changeModeNotifier.value,
                onChanged: (newValue) => changeModeNotifier.value = newValue,
              ),
              ListTile(
                title: Text('Subjects',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, studSubject);
                },
                trailing: Image.asset('assets/study.png', height: 30),
              ),
              ListTile(
                title: Text('Financial',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, studFee);
                },
                trailing: Image.asset('assets/financial.png', height: 30),
              ),
              ListTile(
                title: Text('E-Bookstore',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, studBook);
                },
                trailing: Image.asset('assets/ebook.png', height: 30),
              ),
              ListTile(
                title: Text('QR Scan',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, QRStudentcode);
                },
                trailing: Image.asset('assets/qrcode.png', height: 30),
              ),
              ListTile(
                title: Text('My Profile',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, studProfile);
                },
                trailing: Icon(Icons.account_circle_rounded, size: 30),
              ),
              ListTile(
                title: Text('Logout',
                    style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                trailing: Icon(Icons.logout),
              ),
            ],
          ),
          decoration: BoxDecoration(color: Theme.of(context).accentColor),
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

displayOutstanding(List<Fee> _fees) {
  var display;

  for (int i = 0; i < _fees.length; i++) {
    if (_fees[i].feeStatus == 'Paid') {
      display = 'RM 0.00';
    } else {
      display = 'RM' + _fees[i].amount;
    }
  }

  return display;
}
