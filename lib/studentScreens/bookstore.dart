import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/book.dart';
import 'package:schoolah_mobile_app/models/user.dart';
import 'package:schoolah_mobile_app/services/book_data_service.dart';

import '../dependencies.dart';

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
    final BookDataService bookDataService = service();

    return FutureBuilder<List<Book>>(
        future: bookDataService.getBookList(),
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
      appBar: AppBar(
        title: Text('E-Bookstore', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () => Navigator.pushNamed(context, studHome),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(10.0),
                elevation: 1.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image.asset(
                      'assets/E-Bookstore.png',
                      fit: BoxFit.cover,
                      width: double.infinity
                    ),
                ),
              ),

              Text('Explore all these Activity Books here !', textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              Divider(color: Colors.grey[500], height: 25),
              Padding(padding: EdgeInsets.only(top: 10)),

              Expanded(
                child: ListView.builder(
                  itemCount: books.length,
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
                          child: Image.asset(books[index].image),
                        ),
                        tileColor: Theme.of(context).primaryColorLight,
                        title: Text(books[index].title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.0)),
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
            Text('Fetching books... Please wait'),
          ],
        ),
      ),
    );
  }
}
