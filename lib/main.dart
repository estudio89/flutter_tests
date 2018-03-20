import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_tests/camera.dart';
import 'package:flutter_tests/map.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:location/location.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "dart:convert";

final GoogleSignIn _googleSignIn = new GoogleSignIn(scopes: ['email','https://www.googleapis.com/auth/contacts.readonly']);
final FirebaseAuth _auth = FirebaseAuth.instance;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Testes',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Testes'),
      routes: <String, WidgetBuilder> {
        '/cam': (BuildContext context) => new MyCam(),
        '/map': (BuildContext context) => new MyMap(),
        "/webview": (_) => new WebviewScaffold(
              url: 'https://www.cartaoprogramavida.com.br/',
              appBar: new AppBar(
                title: new Text("Programa VIDA"),
              ),
              withZoom: true,
            )
      },
    );
  }
}

showPush(BuildContext context, String message) async {
  var dialog = new SimpleDialog(
      title: new Text(message),
      children: <Widget>[
        new SimpleDialogOption(
          onPressed: () { Navigator.of(context).pop(); },
          child: const Text('Ok'),
        )
      ],
    );

  showDialog(context: context, child: dialog);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print("----------> onMessage: $message");
        var msg = new JsonEncoder.withIndent("    ").convert(message);
        showPush(context, "onMessage: $msg");
      },
      onLaunch: (Map<String, dynamic> message) {
        print("----------> onLaunch: $message");
        var msg = new JsonEncoder.withIndent("    ").convert(message);
        showPush(context, "onLaunch: $msg");
      },
      onResume: (Map<String, dynamic> message) {
        print("----------> onResume: $message");
        var msg = new JsonEncoder.withIndent("    ").convert(message);
        showPush(context, "onResume: $msg");
      },
    );

    showFCMToken(_firebaseMessaging);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('Login com Facebook'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  loginF();
                }
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('Login com Google'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  loginG();
                }
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('Câmera'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cam');
                }
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('Mapas'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/map');
                }
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('Webview'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/webview');
                }
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('Location'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  showLocation(context);
                }
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('FCM Token'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  showFCMToken(_firebaseMessaging);
                }
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('Firebase Auth: Google'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  _testSignInWithGoogle();
                }
              ),
            ),
            new Container(
              margin: const EdgeInsets.all(10.0),
              width: 200.0,
              child: new RaisedButton(
                child: const Text('Firebase Auth: Facebook'),
                color: Colors.white,
                textColor: const Color(0xFF781DB0),
                shape: new RoundedRectangleBorder(
                  side: new BorderSide(width: 2.0, color: const Color(0xFF781DB0)),
                  borderRadius: new BorderRadius.circular(50.0)
                ),
                onPressed: () {
                  _testSignInWithFacebook();
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

loginF() async {
  var facebookLogin = new FacebookLogin();
  var result = await facebookLogin.logInWithReadPermissions(['email']);

  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      print('----------> Logged in: Access token: ${result.accessToken.token}.');
      break;
    case FacebookLoginStatus.cancelledByUser:
      print('----------> Cancelled by user.');
      break;
    case FacebookLoginStatus.error:
      print('----------> Error: ${result.errorMessage}.');
      break;
  }
}

loginG() async {
  try {
    await _googleSignIn.signIn();
    print('----------> Logged in: ${_googleSignIn.currentUser.displayName}, ${_googleSignIn.currentUser.email}.');
  } catch (error) {
    print('----------> Error: $error');
  }
}

showLocation(BuildContext context) async {
  var currentLocation = <String, double>{};
  var location = new Location();
  currentLocation = await location.getLocation;
  var title = 'Long: ${currentLocation["longitude"]}, Lat: ${currentLocation["latitude"]}';

  var dialog = new SimpleDialog(
      title: new Text(title),
      children: <Widget>[
        new SimpleDialogOption(
          onPressed: () { Navigator.of(context).pop(); },
          child: const Text('Ok'),
        )
      ],
    );

  showDialog(context: context, child: dialog);
}

showFCMToken(FirebaseMessaging instance) async {
  var token = await instance.getToken();
  print('---------> FCM Token: $token');
}

_testSignInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('---------> signInWithGoogle succeeded: $user');
  }

  _testSignInWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);

    final FirebaseUser user = await _auth.signInWithFacebook(accessToken: result.accessToken.token);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('---------> signInWithFacebook succeeded: $user');
  }