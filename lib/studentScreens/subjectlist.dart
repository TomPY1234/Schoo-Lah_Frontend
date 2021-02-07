import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/services/todo_service_rest.dart';
import 'package:schoolah_mobile_app/studentScreens/widgets/student_navbar.dart';
import '../models/todo.dart';
import '../studentScreens/tasklist.dart';
import 'widgets/student_drawer.dart';

class StudentSubjectListScreen extends StatefulWidget {
  @override
  _StudentSubjectListState createState() => _StudentSubjectListState();
}

class _StudentSubjectListState extends State<StudentSubjectListScreen> {
  int selected = 0;
  List<Todo> _todos;

  void _navigate(int index) async {
    Todo returnData = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => StudentTaskListScreen()));

    if (returnData != null) {
      setState(() => _todos[index] = returnData);
    }
  }

  final dataService = TodoServiceRest();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
        future: dataService.getAllTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _todos = snapshot.data;
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
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                  'Learning Today,\nLeading Tomorrow\n\n~ Present By\n     Schoo-Lah',
                                  style: TextStyle(
                                      fontFamily: "pop",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Colors.white)),
                              SizedBox(width: 10),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.asset('assets/subject.png'),
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
                                text: 'My ',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColorLight,
                                )),
                            TextSpan(
                                text: 'Subjects',
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
                for (var todo in _todos)
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
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {
                            dataService.setCurrentTodo(currtodo: todo);

                            selected = _todos.indexOf(todo);
                            _navigate(selected);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 140,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  flex: 4,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            'assets/${todo.title.toUpperCase()}.png',
                                            height: 80),
                                        SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: LinearPercentIndicator(
                                                  animation: true,
                                                  lineHeight: 16.0,
                                                  animationDuration: 2500,
                                                  percent: todo.percent / 100,
                                                  backgroundColor: Colors.white,
                                                  linearStrokeCap:
                                                      LinearStrokeCap.roundAll,
                                                  progressColor:
                                                      getCircleAvatarColor(
                                                          todo.percent.toInt()),
                                                  center: Text(
                                                      todo.percent
                                                              .round()
                                                              .toString() +
                                                          ' %',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                            'TOTAL TASKS : ${todo.items.length} TASKS',
                                            style: TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:
                                        Icon(Icons.arrow_forward_ios_outlined),
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
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
      bottomNavigationBar:  NavigationBar(),
      endDrawer: DrawerView(),
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
            Text('Fetching subject... Please wait'),
          ],
        ),
      ),
    );
  }
}

Color getCircleAvatarColor(int percent) {
  if (percent >= 80) {
    return Colors.lightGreenAccent;
  } else if (percent >= 60 && percent <= 79) {
    return Colors.yellow[600];
  } else if (percent >= 30 && percent <= 59) {
    return Colors.orangeAccent[400];
  } else {
    return Colors.red;
  }
}

Color getTileColor(int percent) {
  if (percent >= 80) {
    return Colors.green[200];
  } else if (percent >= 60 && percent <= 79) {
    return Colors.yellow[300];
  } else if (percent >= 30 && percent <= 59) {
    return Colors.orangeAccent[100];
  } else {
    return Colors.red[200];
  }
}
