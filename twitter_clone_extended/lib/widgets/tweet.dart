import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/utilities/convert_post_time.dart';
import 'package:twitter_clone_extended/models/tweet.dart';

class TweetWidget extends StatelessWidget {
  final Tweet tweet;

  const TweetWidget({
    super.key,
    required this.tweet
  });

  @override
  Widget build(BuildContext context) {
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
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  // Tweet Description
                  Text(tweet.description),
                  // Tweet Image
                  tweet.imageURL != null ? Image.network(tweet.imageURL!, scale: 0.5) : Container(),
                  // Tweet Statistics (Comments, Retweets, Likes)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.comment),
                        Text('${tweet.numComments}')
                      ]),
                      Row(children: [
                        const Icon(Icons.repeat_sharp),
                        Text('${tweet.numRetweets}')
                      ]),
                      Row(children: [
                        const Icon(Icons.favorite),
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
}
