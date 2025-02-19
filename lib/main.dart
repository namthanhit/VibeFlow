import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vibe_flow/ui/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vibe_flow/ui/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VibeFlow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _user != null
        ? MusicHomePage(onSignOut: _handleSignOut)
        : GoogleSignInDemo(onSignIn: (user) {
      setState(() {
        _user = user;
      });
    });
  }

  void _handleSignOut() {
    setState(() {
      _user = null;
    });
  }
}