import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/widgets/tweet.dart';
import 'package:twitter_clone_extended/screens/feed.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Feed(title: 'Twitter Feed'),
    );
  }
}