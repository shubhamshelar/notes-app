import 'package:flutter/material.dart';
import 'package:notes/utils/app-theme.dart';
import 'package:notes/view/bottom-nav-bar.dart';
import 'package:notes/view/collection-screen.dart';
import 'package:notes/view/create-note-screen.dart';
import 'package:notes/view/note-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.myTheme,
      routes: {
        '/': (context) => SplashScreen(),
        '/notes': (context) => NotesScreen(),
        '/createNote': (context) => CreateNoteScreen(),
        '/collection': (context) => CollectionScreen(),
      },
      initialRoute: '/',
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => BottomNavBar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note,
              size: 150,
            ),
            SizedBox(height: 16),
            Text(
              'Notes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
