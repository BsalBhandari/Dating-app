import 'package:flutter/material.dart';
import 'package:genix/screens/mainscreen/Dashboard.dart';
import 'package:genix/screens/mainscreen/chat.dart';
import 'package:genix/screens/mainscreen/profile.dart';
import 'package:genix/screens/mainscreen/setting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  final List<Widget> screen = [Dashboard(), Chat(), Profile(), Setting()];

  Widget currentScreen = Dashboard();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40.0,
                      onPressed: () {
                        setState(() {
                          currentScreen = Dashboard();
                          _currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.dashboard,
                            color: _currentTab == 0 ? Colors.pink : Colors.grey,
                          ),
                          Text(
                            'DashBoard',
                            style: TextStyle(
                              color:
                                  _currentTab == 0 ? Colors.pink : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40.0,
                      onPressed: () {
                        setState(() {
                          currentScreen = Chat();
                          _currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.chat,
                            color: _currentTab == 1 ? Colors.pink : Colors.grey,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(
                              color:
                                  _currentTab == 1 ? Colors.pink : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40.0,
                      onPressed: () {
                        setState(() {
                          currentScreen = Profile();
                          _currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: _currentTab == 2 ? Colors.pink : Colors.grey,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color:
                                  _currentTab == 2 ? Colors.pink : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40.0,
                      onPressed: () {
                        setState(() {
                          currentScreen = Setting();
                          _currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: _currentTab == 3 ? Colors.pink : Colors.grey,
                          ),
                          Text(
                            'Setting',
                            style: TextStyle(
                              color:
                                  _currentTab == 3 ? Colors.pink : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
