import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/fees.dart';
import 'package:schoolah_mobile_app/services/fee_service_rest.dart';
import 'package:schoolah_mobile_app/studentScreens/widgets/student_navbar.dart';
import 'widgets/student_drawer.dart';

class TuitionFeeScreen extends StatefulWidget {
  @override
  _TuitionFeeState createState() => _TuitionFeeState();
}

class _TuitionFeeState extends State<TuitionFeeScreen> {
  List<Fee> fees;

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
                                Text(
                                    'Outstanding\n\n' +
                                        displayOutstanding(fees),
                                    style: TextStyle(
                                        fontFamily: "pop",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Colors.white)),
                                SizedBox(width: 30),
                                Image.asset('assets/finance.png', height: 120),
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
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
        bottomNavigationBar: NavigationBar(),
        endDrawer: DrawerView());
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
