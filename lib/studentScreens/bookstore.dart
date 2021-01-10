import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/models/book.dart';
import 'package:schoolah_mobile_app/models/user.dart';

class BookstorePageScreen extends StatefulWidget {
  final List<Book> books;
  final User currUser;
  BookstorePageScreen(this.books, this.currUser);
  @override
  _BookstorePageState createState() => _BookstorePageState(this.books);
}

class _BookstorePageState extends State<BookstorePageScreen> {
  int _selectedIndex = 1;
  List<Book> books;
  _BookstorePageState(this.books);
  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(
          context, '/studentprofile'); //supposedly qrcode interface
    } else if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/studenthome');
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/studentprofile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkModeNotifier = Provider.of<ValueNotifier<bool>>(context);
    //final List<Book> currBook = studBooks();
    return Scaffold(
      appBar: AppBar(
        title: Text('BOOKSTORE'),
        centerTitle: true,
        actions: <Widget>[
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
          itemCount: widget.books.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
            thickness: 5.0,
          ),
          itemBuilder: (context, index) => ListTile(
            tileColor: Colors.deepOrange[700],
            leading: Image.asset(widget.books[index].image),
            title: Text(widget.books[index].title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0)),
            subtitle: Text('RM ${widget.books[index].price.toString()}',
                style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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
        selectedItemColor: Colors.grey[500],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: DrawerHeader(
            child: CheckboxListTile(
                title: Text('Change theme color'),
                value: darkModeNotifier.value,
                onChanged: (newValue) => darkModeNotifier.value = newValue)),
      ),
    );
  }

  /*List<Book> studBooks() {
    List<Book> currBook;
    for (var b in books) {
      if (b.year == widget.currUser.year) {
        print(b);
        currBook.add(b);
      }
    }
    return currBook;
  }*/
}
