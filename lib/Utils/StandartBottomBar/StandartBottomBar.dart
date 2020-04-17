
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sesnic_app/Utils/ThemeChanger.dart';
import 'package:sesnic_app/screen/ActivityScreen.dart';
import 'package:sesnic_app/screen/BookingScreen.dart';
import 'package:sesnic_app/screen/DasboardScreen.dart';
import 'package:sesnic_app/screen/HistoryScreen.dart';
import 'package:sesnic_app/screen/ProfileScreen.dart';

class BottomMenu extends StatefulWidget {
  static const routeName = '/mengajar-screen';
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> with TickerProviderStateMixin {

  int i = 0;
  int _pState = 0;
  var pages = [new DashboardScreen(), new ActivityScreen(), new BookingScreen(), new HistoryScreen(), new ProfileScreen()];

  @override
  void initState() {
    super.initState();
  }
  Future<bool> _onWillPop() {
    if(i == 0){
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
    }else{
      setState(() {
        i=0;
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child)
      => WillPopScope(
        onWillPop: _onWillPop ,
        child: new Scaffold(
          body: pages[i],
          // drawer: new AppNavigationDrawer(),
          bottomNavigationBar: new BottomNavigationBar(

            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.grey.shade50,
                icon: Icon(FontAwesomeIcons.home, size: 20,),
                title: Text('Home', style: TextStyle(fontFamily: 'WorkSans', fontSize: 12)),
              ),BottomNavigationBarItem(
                backgroundColor: Colors.grey.shade50,
                icon: Icon(FontAwesomeIcons.bookmark,size: 20,),
                title: Text('Aktivitas', style: TextStyle(fontFamily: 'WorkSans',fontSize: 12)),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey.shade50,
                icon: Icon(FontAwesomeIcons.inbox,size: 20,),
                title: Text('Inbox', style: TextStyle(fontFamily: 'WorkSans',fontSize: 12)),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey.shade50,
                icon: Icon(FontAwesomeIcons.userCircle,size: 20,),
                title: Text('Account', style: TextStyle(fontFamily: 'WorkSans',fontSize: 12)),
              ),
            ],
            currentIndex: i,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey[500],
            selectedItemColor: Colors.white,
            elevation: 1,
            backgroundColor: notifier.darkTheme ? Colors.black:Colors.cyan[900],
            onTap: (index) {
              print (index);
              setState(() {
                _pState = i;
                i = index;

              });
            },
          ),
        ),
      ),
    );

  }
}
