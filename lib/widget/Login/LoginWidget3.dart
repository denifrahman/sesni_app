import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sesnic_app/Utils/BottomAnimation.dart';
import 'dart:async';
import 'dart:convert' show json;

import "package:http/http.dart" as http;

class LoginWidget3 extends StatefulWidget {
  @override
  _LoginWidget3State createState() => new _LoginWidget3State();
}

class _LoginWidget3State extends State<LoginWidget3>
    with TickerProviderStateMixin {
  GoogleSignInAccount _currentUser;
  String _contactText;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  //The code is commented because instead of manual scrolling with animation,
  //Now PageView is being used

  /*double scrollPercent = 0.0;
  Offset startDrag;
  double startDragPercentScroll;
  double dragDirection; // -1 for left, +1 for right
  AnimationController controller_minus1To0;
  AnimationController controller_0To1;
  CurvedAnimation anim_minus1To0;
  CurvedAnimation anim_0To1;
  final numCards = 3;
  void _onHorizontalDragStart(DragStartDetails details) {
    startDrag = details.globalPosition;
    startDragPercentScroll = scrollPercent;
  }
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final currDrag = details.globalPosition;
    final dragDistance = currDrag.dx - startDrag.dx;
    if (dragDistance > 0) {
      dragDirection = 1.0;
    } else {
      dragDirection = -1.0;
    }
    final singleCardDragPercent = dragDistance / context.size.width;
    setState(() {
      scrollPercent =
          (startDragPercentScroll + (-singleCardDragPercent / numCards))
              .clamp(0.0 - (1 / numCards), (1 / numCards));
      print(scrollPercent);
    });
  }
  void _onHorizontalDragEnd(DragEndDetails details) {
    if (scrollPercent > 0.1666) {
      print("FIRST CASE");
      controller_0To1.forward(from: scrollPercent * numCards);
    } else if (scrollPercent < 0.1666 &&
        scrollPercent > -0.1666 &&
        dragDirection == -1.0) {
      print("SECOND CASE");
      controller_0To1.reverse(from: scrollPercent * numCards);
    } else if (scrollPercent < 0.1666 &&
        scrollPercent > -0.1666 &&
        dragDirection == 1.0) {
      print("THIRD CASE");
      controller_minus1To0.forward(from: scrollPercent * numCards);
    } else if (scrollPercent < -0.1666) {
      print("LAST CASE");
      controller_minus1To0.reverse(from: scrollPercent * numCards);
    }
    setState(() {
      startDrag = null;
      startDragPercentScroll = null;
    });
  }
  */

  @override
  void initState() {
    super.initState();
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _hadleChekSession();
      }
      print(_currentUser.authHeaders);
    });
//    _hadleChekSession();
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
      '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    print(response.body);
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  _hadleChekSession() async {
    _googleSignIn.isSignedIn().then((val) {
      if (val) {
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(pageBuilder: (BuildContext context,
                Animation animation, Animation secondaryAnimation) {
              return BottomAnimateBar();
            }, transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return new SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            }),
            (Route route) => false);
      }
    });
  }

  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.cyan[700],
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Center(
              child: new Image(
                  width: 220,
                  fit: BoxFit.fill,
                  image: new AssetImage('assets/logo-text.png')),
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.redAccent,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.cyan[800],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget LoginPage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('assets/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(90.0),
            child: Center(
              child: new Image(
                  width: 200,
                  fit: BoxFit.fitWidth,
                  image: new AssetImage('assets/logo.png')),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "EMAIL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[800],
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.cyan[800],
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'example@sesnic.id',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "PASSWORD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[800],
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.cyan[800],
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[800],
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.cyan[800],
                    onPressed: () => {},
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.25)),
                  ),
                ),
                Text(
                  "OR CONNECT WITH",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.25)),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            child: new Row(
              children: <Widget>[
//                new Expanded(
//                  child: new Container(
//                    margin: EdgeInsets.only(right: 8.0),
//                    alignment: Alignment.center,
//                    child: new Row(
//                      children: <Widget>[
//                        new Expanded(
//                          child: new FlatButton(
//                            shape: new RoundedRectangleBorder(
//                              borderRadius: new BorderRadius.circular(30.0),
//                            ),
//                            color: Color(0Xff3B5998),
//                            onPressed: () => {},
//                            child: new Container(
//                              child: new Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  new Expanded(
//                                    child: new FlatButton(
//                                      onPressed: ()=>{},
//                                      padding: EdgeInsets.only(
//                                        top: 20.0,
//                                        bottom: 20.0,
//                                      ),
//                                      child: new Row(
//                                        mainAxisAlignment:
//                                        MainAxisAlignment.spaceEvenly,
//                                        children: <Widget>[
//                                          Icon(
//                                            const IconData(0xea90,
//                                                fontFamily: 'icomoon'),
//                                            color: Colors.white,
//                                            size: 15.0,
//                                          ),
//                                          Text(
//                                            "FACEBOOK",
//                                            textAlign: TextAlign.center,
//                                            style: TextStyle(
//                                                color: Colors.white,
//                                                fontWeight: FontWeight.bold),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
                new Expanded(
                  child: new Container(
                    margin: EdgeInsets.only(left: 8.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Color(0Xffdb3236),
                            onPressed: () => {},
                            child: new Container(
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: new FlatButton(
                                      onPressed: () => _handleSignIn(),
                                      padding: EdgeInsets.only(
                                        top: 20.0,
                                        bottom: 20.0,
                                      ),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.googlePlusG,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Text(
                                            "GOOGLE",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget SignupPage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('assets/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(80.0),
            child: Center(
              child: new Image(
                  width: 200,
                  fit: BoxFit.fitWidth,
                  image: new AssetImage('assets/logo.png')),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "EMAIL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[800],
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.cyan[800],
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'samarthagarwal@live.com',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "PASSWORD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[800],
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.cyan[800],
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "CONFIRM PASSWORD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[800],
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.cyan[800],
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 24.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan[800],
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.cyan[800],
                    onPressed: () => {},
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  gotoLogin() {
    //controller_0To1.forward(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      _hadleChekSession();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
//      child: new GestureDetector(
//        onHorizontalDragStart: _onHorizontalDragStart,
//        onHorizontalDragUpdate: _onHorizontalDragUpdate,
//        onHorizontalDragEnd: _onHorizontalDragEnd,
//        behavior: HitTestBehavior.translucent,
//        child: Stack(
//          children: <Widget>[
//            new FractionalTranslation(
//              translation: Offset(-1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: SignupPage(),
//            ),
//            new FractionalTranslation(
//              translation: Offset(0 - (scrollPercent / (1 / numCards)), 0.0),
//              child: HomePage(),
//            ),
//            new FractionalTranslation(
//              translation: Offset(1 - (scrollPercent / (1 / numCards)), 0.0),
//              child: LoginPage(),
//            ),
//          ],
//        ),
//      ),
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            SingleChildScrollView(child: LoginPage()),
            HomePage(),
            SingleChildScrollView(child: SignupPage())
          ],
          scrollDirection: Axis.horizontal,
        ));
  }
}
