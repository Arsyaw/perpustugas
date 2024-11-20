import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      margin: EdgeInsets.all(270),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/ebook');
            },
            icon: Icon(
              Icons.book,
              size: 100,
            ),
          )
        ],
      ),
    );
  }
}
