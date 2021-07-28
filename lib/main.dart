import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: Home());
  }
}

class Home extends StatelessWidget {
  const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
