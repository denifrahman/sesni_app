import 'package:flutter/material.dart';
import 'package:sesnic_app/Utils/navigation_right.dart';
import 'package:sesnic_app/widget/SettingWidget/SettingWidget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[Container(
          padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.settings),
              color: Colors.black,
              onPressed: ()=>_pengaturan(),
            ),)],
      ),
    );
  }

  _pengaturan() {
    Navigator.push(
      context,
      SlideRightRoute(page: SettingWidget()),
    );
  }
}
