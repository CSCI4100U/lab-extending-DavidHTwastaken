import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/services/db_helper.dart';
import 'package:twitter_clone_extended/widgets/tweet.dart';
import 'package:twitter_clone_extended/screens/create_tweet.dart';
import '../models/tweet.dart';

class Feed extends StatelessWidget {
  final String title;

  const Feed({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper db = DatabaseHelper();
    return Scaffold(
        appBar: AppBar(title: Text(title), actions: [IconButton(icon: const Icon(Icons.create),onPressed: () async{
          Map<String, dynamic> tweetData = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTweet()));
          tweetData['timeStamp'] = DateTime.now().toIso8601String();
          tweetData['numComments'] = 0;
          tweetData['numLikes'] = 0;
          tweetData['numRetweets'] = 0;
          await db.insertTweet(Tweet.fromMap(tweetData));
        },)]),
        body: FutureBuilder<List<Tweet>>(
          future: db.getTweets(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView(
                  key: super.key,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(right: 40),
                  children: snapshot.data!
                      .map((tweet) => TweetWidget(tweet: tweet))
                      .toList());
            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
