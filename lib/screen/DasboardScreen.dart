import 'package:flutter/material.dart';
import 'package:sesnic_app/widget/DashboardWidget/BodyWidget.dart';
import 'package:sesnic_app/widget/DashboardWidget/HeaderWidget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
            Positioned(
              top: 0,
              child: HeaderWidget()),
            Align(alignment: Alignment.bottomCenter,
            child: BodyWidget(),
            )
        ],
      ),
    );
  }
}