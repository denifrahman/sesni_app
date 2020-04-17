import 'package:flutter/material.dart';
import 'package:sesnic_app/screen/InboxScreen.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  GoogleSignInAccount _currentUser;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.signInSilently();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return _currentUser ==  null ? Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: PKCardProfileSkeleton(
        isCircularImage: true,
        isBottomLinesActive: true,
      ),
    ):
     Container(
      height: MediaQuery.of(context).size.height / 2 - 80,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
          image: DecorationImage(
              image: AssetImage("assets/background1.png"), fit: BoxFit.cover)
//        gradient: new LinearGradient(
//            colors: [Color(0xff01a3a4), Color(0xff1dd1a1)],
//            begin: const FractionalOffset(0.0, 0.2),
//            end: const FractionalOffset(1.0, 0.0),
//            stops: [0.0, 1.0],
//            tileMode: TileMode.clamp),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 30, left: 25),
                  child: Image(
                      width: 100,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/logo-text.png')),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 30, right: 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.mail_outline,
                            color: Colors.white,
                          ),
                          onPressed: () => _inbox(),
                        )),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FittedBox(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child:ClipOval(
                          child: Image.network(
                            _currentUser.photoUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ),
                    Container(
                      height: 15,
                    ),
                    Text(
                      _currentUser.displayName,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(_currentUser.email,
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _inbox() {
    Navigator.of(context).push(PageRouteTransition(
        animationType: AnimationType.slide_up,
        builder: (context) => InboxScreen()));
  }

  _search() {}
}
