import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/task_page.dart';
import 'package:flutter_application_2/screens/welcome_screen.dart';
import 'package:flutter_application_2/screens/dashboard.dart';


class MyStoreApp extends StatelessWidget {
  const MyStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO LIST',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: WelcomeScreen(), // WelcomeScreen() // Dashboard()
    );
  }
}