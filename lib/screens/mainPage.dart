import 'package:flutter/material.dart';
import '../services/apiService.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Text('This is the main page'),
      ),
    );
  }
}
