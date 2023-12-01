import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/services/db_helper.dart';
import 'package:twitter_clone_extended/widgets/tweet.dart';
import 'package:twitter_clone_extended/screens/create_tweet.dart';
import '../models/tweet.dart';
// import 'package:twitter_clone_extended/utilities/convert_post_time.dart';
import 'package:twitter_clone_extended/utilities/convert_post_time.dart';

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

  Widget buildTweet(Tweet tweet, int index) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(top: 15, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.green,
                      )
                    ])),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tweet.userLongName,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '@${tweet.userShortName}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        convertPostTime(tweet.timeStamp, DateTime.now()),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Icon(Icons.expand_more)
                    ],
                  ),
                  // Tweet Description
                  Text(tweet.description),
                  // Tweet Image
                  tweet.imageURL != null
                      ? Image.network(tweet.imageURL!, scale: 0.5)
                      : Container(),
                  // Tweet Statistics (Comments, Retweets, Likes)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.comment),
                        Text('${tweet.numComments}')
                      ]),
                      Row(children: [
                        IconButton(icon: Icon(tweet.isRetweeted ? Icons.repeat : Icons.repeat_sharp), onPressed: (){
                          bool isRetweeted = !tweet.isRetweeted;
                          int numRetweets = tweet.isRetweeted
                              ? tweet.numRetweets - 1
                              : tweet.numRetweets + 1;
                          db.updateTweet(tweet.id, <String, dynamic>{
                            'numLikes': numRetweets,
                            'isLiked': isRetweeted
                          }).then((val) => setState(() {
                            tweets[index].numRetweets = numRetweets;
                            tweets[index].isLiked = isRetweeted;
                          }));
                        },),
                        Text('${tweet.numRetweets}')
                      ]),
                      Row(children: [
                        IconButton(
                            icon: Icon(tweet.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border),
                            onPressed: () {
                              bool isLiked = !tweet.isLiked;
                              int numLikes = tweet.isLiked
                                  ? tweet.numLikes - 1
                                  : tweet.numLikes + 1;
                              db.updateTweet(tweet.id, <String, dynamic>{
                                'numLikes': numLikes,
                                'isLiked': isLiked
                              }).then((val) => setState(() {
                                    tweets[index].numLikes = numLikes;
                                    tweets[index].isLiked = isLiked;
                                  }));
                            }),
                        Text('${tweet.numLikes}')
                      ]),
                      const Icon(Icons.bookmark)
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
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
              await db.insertTweet(tweetData).then((val) => setState(() {
                    tweets.insert(0, val);
                  }));
            },
          )
        ]),
        body: RefreshIndicator(
            onRefresh: () async {
              await db.getTweets().then((vals) {
                setState(() {
                  tweets = vals;
                });
              });
            },
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 0;
            },
            child: ListView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(right: 40),
                children: tweets
                    .map((tweet) => TweetWidget(tweet: tweet))
                    .toList())));
  }
}
