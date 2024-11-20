import 'package:flutter/material.dart';
import 'package:perpus/ebook_view.dart';
import 'package:perpus/home_view.dart';
import 'package:perpus/login_view.dart';
import 'package:perpus/profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/login': (context) => LoginView(),
        '/ebook': (context) => EbookView(),
        '/profile': (context) => ProfileView(),
      },
    );
  }
}
