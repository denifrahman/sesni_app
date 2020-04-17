import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sesnic_app/screen/BookingScreen.dart';
import 'package:sesnic_app/screen/DasboardScreen.dart';
import 'package:sesnic_app/screen/HistoryScreen.dart';
import 'package:sesnic_app/screen/NewsScreen.dart';
import 'package:sesnic_app/screen/ProfileScreen.dart';
import 'package:route_transitions/route_transitions.dart';

class BottomAnimateBar extends StatefulWidget {
  @override
  _BottomAnimateBarState createState() => _BottomAnimateBarState();
}

class _BottomAnimateBarState extends State<BottomAnimateBar> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    DashboardScreen(),
    NewsScreen(),
    HistoryScreen(),
    ProfileScreen(),
    BookingScreen()
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardScreen(); // Our first view in viewport

  _openBoodking() {

    Navigator.of(context).push(PageRouteTransition(
        animationType: AnimationType.slide_up,
        builder: (context) => BookingScreen()));
  }

  Future<bool> _onWillPop() {
    if (currentTab == 0) {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  /*Navigator.of(context).pop(true)*/
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    } else {
      setState(() {
        currentScreen = DashboardScreen();
        currentTab = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 20),
          child: FloatingActionButton(
            tooltip: 'Booking',
            backgroundColor: Color(0xff01a3a4),
            foregroundColor: Colors.redAccent,
            heroTag: Text('Book'),
            child: Icon(
              FontAwesomeIcons.stethoscope,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () => _openBoodking(),
          ),
        ),
        backgroundColor: Colors.grey[100],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 3,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            currentScreen =
                                DashboardScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.dashboard,
                              size: 18,
                              color: currentTab == 0
                                  ? Color(0xff01a3a4)
                                  : Colors.grey[700],
                            ),
                            Text(
                              'Beranda',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 0
                                    ? Color(0xff01a3a4)
                                    : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            currentScreen =
                                NewsScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.storage,
                              size: 18,
                              color: currentTab == 1
                                  ? Color(0xff01a3a4)
                                  : Colors.grey[700],
                            ),
                            Text(
                              'News',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 1
                                    ? Color(0xff01a3a4)
                                    : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // Right Tab bar icons
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            currentScreen =
                                HistoryScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.notifications_active,
                              size: 18,
                              color: currentTab == 2
                                  ? Color(0xff01a3a4)
                                  : Colors.grey[700],
                            ),
                            Text(
                              'Promo',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 2
                                    ? Color(0xff01a3a4)
                                    : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 20,
                        onPressed: () {
                          setState(() {
                            currentScreen =
                                ProfileScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 18,
                              color: currentTab == 3
                                  ? Color(0xff01a3a4)
                                  : Colors.grey[700],
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 3
                                    ? Color(0xff01a3a4)
                                    : Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
