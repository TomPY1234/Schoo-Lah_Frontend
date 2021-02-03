import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/book.dart';
import 'package:schoolah_mobile_app/services/book_service_rest.dart';

class BookstorePageScreen extends StatefulWidget {
  //final List<Book> books;
  //final User currUser;
  BookstorePageScreen();
  @override
  _BookstorePageState createState() => _BookstorePageState();
}

class _BookstorePageState extends State<BookstorePageScreen> {
  int _selectedIndex = 1;
  List<Book> books;
  //_BookstorePageState(s);
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
    final dataService = BookServiceRest();

    return FutureBuilder<List<Book>>(
        future: dataService.getAllBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            books = snapshot.data;
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
              backgroundColor: Colors.white,
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
              colors: [Theme.of(context).accentColor, Colors.white],
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
                              color: Colors.lime.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0.0, 6),
                            ),
                          ],
                          color: Colors.lime,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Schoo-Lah\n\nE-Bookstore',
                                  style: TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.white)),
                              SizedBox(width: 10),
                              Image.asset('assets/ebookstore.png', height: 120),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Popular ',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Colors.black,
                                )),
                            TextSpan(
                                text: 'E-Books',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Colors.orange,
                                )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                for (var ebook in books)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lime.withOpacity(0.4),
                            blurRadius: 10,
                            offset: Offset(0.0, 6),
                          ),
                        ],
                        color: Colors.lime,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Image.asset('${ebook.image}',
                                        height: 130),
                                    decoration: BoxDecoration(
                                        color: Colors.limeAccent,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        )),
                                  ),
                                ),
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
                                              '${ebook.title}\n\nPrice : \nRM ${ebook.price.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
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
                    changeModeNotifier.value ? Text('Pink') : Text('Orange'),
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
            Text('Fetching books... Please wait'),
          ],
        ),
      ),
    );
  }
}
