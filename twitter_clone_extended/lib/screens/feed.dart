import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/widgets/tweet_search.dart';
import 'package:twitter_clone_extended/services/db_helper.dart';
import 'package:twitter_clone_extended/screens/create_tweet.dart';
import 'package:twitter_clone_extended/widgets/tweets_list.dart';
import 'package:twitter_clone_extended/services/tweets_provider.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  final String title;

  const Feed({super.key, required this.title});

  @override
  State<Feed> createState() => FeedState();
}

class FeedState extends State<Feed> {
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    Provider.of<TweetsProvider>(context, listen: false).refresh();
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
              await db.insertTweet(tweetData).then((val) =>
                  Provider.of<TweetsProvider>(context, listen: false).add(val));
            },
          ),
          const TweetSearch()
        ]),
        body:
            Consumer<TweetsProvider>(builder: (context, tweetsProvider, child) {
          if (tweetsProvider.tweets.isEmpty) {
            return Center(
                child: Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 200),
                    width: 200,
                    child: const Text(
                      "There are currently no tweets to display. Tap the editing icon at the top right to create one.",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.5,
                    )));
          }
          return RefreshIndicator(
              onRefresh: () async {
                await tweetsProvider.refresh();
              },
              notificationPredicate: (ScrollNotification notification) {
                return notification.depth == 0;
              },
              child: TweetsList(tweetsProvider.tweets));
        }));
  }
}
