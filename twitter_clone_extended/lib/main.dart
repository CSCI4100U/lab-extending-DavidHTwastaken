import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/services/tweets_provider.dart';
import 'package:twitter_clone_extended/screens/feed.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TweetsProvider(),
        child: const MaterialApp(
          home: Feed(title: 'Twitter Feed'),
        ));
  }
}
