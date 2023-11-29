import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/services/db_helper.dart';
import 'package:twitter_clone_extended/widgets/tweet.dart';
import 'package:twitter_clone_extended/screens/create_tweet.dart';
import '../models/tweet.dart';

class Feed extends StatefulWidget {
  final String title;

  const Feed({super.key, required this.title});

  @override
  State<Feed> createState() => FeedState();
}

class FeedState extends State<Feed> {
  List<Tweet> tweets = [];
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    db.getTweets().then((vals) {
      setState(() {
        tweets = vals;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: [
          IconButton(
            icon: const Icon(Icons.create),
            onPressed: () async {
              Map<String, dynamic> tweetData = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateTweet()));
              tweetData['timeStamp'] = DateTime.now().toIso8601String();
              tweetData['numComments'] = 0;
              tweetData['numLikes'] = 0;
              tweetData['numRetweets'] = 0;
              Tweet newTweet = Tweet.fromMap(tweetData);
              await db.insertTweet(newTweet).then((val) => setState(() {
                    tweets.insert(0, newTweet);
                  }));
            },
          )
        ]),
        body: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(right: 40),
            children:
                tweets.map((tweet) => TweetWidget(tweet: tweet)).toList()));
  }
}
