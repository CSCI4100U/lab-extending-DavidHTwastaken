import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/widgets/tweet.dart';

import '../models/tweet.dart';

class TweetsList extends StatelessWidget{
  final Map<int?,List<Tweet>> tweetsMap;

  const TweetsList(this.tweetsMap, {super.key});

  @override
  Widget build(BuildContext context){
    List<Tweet> tweets = tweetsMap[null]!;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(right: 40),
        itemCount: tweets.length,
        itemBuilder: (BuildContext context, int index) => TweetWidget(
            tweet: tweets[index],
            index: index,
            replies: tweetsMap
                .containsKey(tweets[index].id)
                ? tweetsMap[tweets[index].id]!
                : []));
  }
}