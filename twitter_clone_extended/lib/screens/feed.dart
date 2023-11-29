import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  final String title;
  const Feed({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: FutureBuilder<Tweet>(
          future:
        )

        ListView(
            key: super.key,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(right: 40),
            children:
        ));
  }