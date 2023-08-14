import 'package:flutter/material.dart';
import 'package:voice_assistant_flutter_ml/home_page.dart';
import 'package:voice_assistant_flutter_ml/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CosmicAI',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,// change the whole app background color
        appBarTheme: const AppBarTheme(backgroundColor: Pallete.whiteColor),// change the color of the appbar
      ),
      home: const HomePage(),
    );
  }
}
