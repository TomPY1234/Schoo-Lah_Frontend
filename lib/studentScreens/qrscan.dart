import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'widgets/student_drawer.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QRScreen> {
  int _selectedIndex = 0;

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
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColorDark
              ],
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
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0.0, 6),
                            ),
                          ],
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('QR Scan \nAttendance\n\nSchoo-Lah',
                                  style: TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.white)),
                              SizedBox(width: 10),
                              Image.asset('assets/qrscancode.png', height: 120),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Successfully ',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColorLight,
                                )),
                            TextSpan(
                                text: 'Registered',
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
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          blurRadius: 10,
                          offset: Offset(0.0, 6),
                        ),
                      ],
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.qr_code_outlined, size: 60),
                                ),
                              ),
                              Flexible(
                                flex: 4,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset('assets/MATHEMATICS.png',
                                            height: 100),
                                        Text('\nMathematics Year 5\n',
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                                color: Colors.white)),
                                        Text('10:00 AM\n',
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                                color: Colors.white)),
                                        Text('Sun 31 Jan 2021',
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrangeAccent,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
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
      endDrawer: DrawerView(),
    );
  }
}
