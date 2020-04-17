import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:sesnic_app/Utils/LocalBindings.dart';
import 'package:sesnic_app/screen/DasboardScreen.dart';
import 'package:sesnic_app/screen/LoginScreen.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:sesnic_app/screen/LoginScreen2.dart';
import 'package:sesnic_app/screen/LoginScreen3.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key key}) : super(key: key);

  @override
  _SplaceScreenState createState() => _SplaceScreenState();
}
class _SplaceScreenState extends State<SplaceScreen> {
  bool showIntro = false;
  @override
  void initState() {
    _getStting();
    super.initState();
  }

  _getStting() async {
    String themeData = await LocalStorage.sharedInstance.readValue('theme');
    if(themeData == null){
      setState(() {
      showIntro = true;
      });
    }else{
      showIntro = false;
    }
  }
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: LoginScreen3(), 2: DashboardScreen()};
  @override
  Widget build(BuildContext context) {
  return CustomSplash(
    imagePath: 'assets/logo-icon.png',
    backGroundColor: Colors.white,
    // backGroundColor: Color(0xfffc6042),
    animationEffect: 'zoom-out',
    logoSize: 50,
    home: LoginScreen3(),
    customFunction: duringSplash,
    duration: 2500,
    type: CustomSplashType.StaticDuration,
    outputAndHome: op,
  );
  }
}
class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Sesnic",
        styleTitle: TextStyle(
            color: Colors.cyan,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/logo-icon.png",
      ),
    );
    slides.add(
      new Slide(
        title: "MUSEUM",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/logo.png",
      ),
    );
    slides.add(
      new Slide(
        title: "COFFEE SHOP",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/logo.png",
      ),
    );
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()),
        ModalRoute.withName('/portal'));
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
