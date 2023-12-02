import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/services/db_helper.dart';
import 'package:twitter_clone_extended/screens/create_tweet.dart';
import '../models/tweet.dart';
import 'package:twitter_clone_extended/utilities/convert_post_time.dart';
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
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  (() {
                    if (tweet.imageURL != null) {
                      return Image.network(
                        tweet.imageURL!,
                        scale: 0.5,
                        errorBuilder: (context, exception, stacktrace) {
                          return Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 160,
                                  color: Colors.grey,
                                  child: const Text("Invalid image URL")));
                        },
                      );
                    }
                    return Container();
                  })(),
                  // Tweet Statistics (Comments, Retweets, Likes)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        MenuAnchor(menuChildren: <MenuItemButton>[MenuItemButton(onPressed: () async{
                          Map<String,dynamic> newTweet = await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CreateTweet()));

                        },child: const Text('Reply'))]),
                        IconButton(icon: const Icon(Icons.chat_bubble_outline),onPressed: (){

                        },),
                        Text('${tweet.numComments}')
                      ]),
                      Row(children: [
                        IconButton(
                          icon: Icon(tweet.isRetweeted
                              ? Icons.repeat
                              : Icons.repeat_sharp),
                          onPressed: () => Provider.of<TweetsProvider>(context,
                                  listen: false)
                              .retweet(index),
                        ),
                        Text('${tweet.numRetweets}')
                      ]),
                      Row(children: [
                        IconButton(
                            icon: Icon(tweet.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border),
                            onPressed: () => Provider.of<TweetsProvider>(
                                    context,
                                    listen: false)
                                .like(index)),
                        Text('${tweet.numLikes}')
                      ]),
                      IconButton(
                        icon: Icon(tweet.isFavourited
                            ? Icons.bookmark
                            : Icons.bookmark_border),
                        onPressed: () =>
                            Provider.of<TweetsProvider>(context, listen: false)
                                .favourite(index),
                      )
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
              await db.insertTweet(tweetData).then((val) =>
                  Provider.of<TweetsProvider>(context, listen: false).add(val));
            },
          )
        ]),
        body:
            Consumer<TweetsProvider>(builder: (context, tweetsProvider, child) {
          List<Tweet> tweets = tweetsProvider.tweets;
          return RefreshIndicator(
              onRefresh: () async {
                await tweetsProvider.refresh();
              },
              notificationPredicate: (ScrollNotification notification) {
                return notification.depth == 0;
              },
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(right: 40),
                  itemCount: tweets.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTweet(tweets[index], index)));
        }));
  }
}
