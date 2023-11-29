import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/utilities/convert_post_time.dart';

class TweetWidget extends StatelessWidget {
  final String userShortName;
  final String userLongName;
  final DateTime timeStamp;
  final String description;
  final String imageURL;
  final int numComments;
  final int numRetweets;
  final int numLikes;

  const TweetWidget({
    super.key,
    required this.userShortName,
    required this.userLongName,
    required this.timeStamp,
    required this.description,
    required this.imageURL,
    required this.numComments,
    required this.numRetweets,
    required this.numLikes,
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
                        userLongName,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        '@$userShortName',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        convertPostTime(timeStamp),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  // User Long Name

                  // Tweet Description
                  Text(description),
                  // Tweet Image
                  Image.asset(imageURL, scale: 0.5),
                  // Tweet Statistics (Comments, Retweets, Likes)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.comment),
                        Text('$numComments')
                      ]),
                      Row(children: [
                        const Icon(Icons.repeat_sharp),
                        Text('$numRetweets')
                      ]),
                      Row(children: [
                        const Icon(Icons.favorite),
                        Text('$numLikes')
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
