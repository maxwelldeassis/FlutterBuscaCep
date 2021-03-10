import 'package:flutter/material.dart';
import 'screens/home.screen.dart';

main() {
  runApp(ViaCepApplication());
}

class ViaCepApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
