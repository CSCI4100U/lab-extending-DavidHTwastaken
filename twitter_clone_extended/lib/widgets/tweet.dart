import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/utilities/convert_post_time.dart';
import 'package:twitter_clone_extended/models/tweet.dart';
import 'package:twitter_clone_extended/services/tweets_provider.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_extended/screens/create_tweet.dart';
import 'package:twitter_clone_extended/widgets/replies.dart';

class TweetWidget extends StatelessWidget {
  final Tweet tweet;
  final int index;
  final List<Tweet> replies;
  const TweetWidget({
    super.key,
    required this.tweet,
    required this.index,
    required this.replies
  });

  @override
  Widget build(BuildContext context) {
    if (tweet.isHidden) {
      return Container();
    }
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
                      MenuAnchor(
                          builder: (context, controller, child) {
                            return IconButton(
                                onPressed: () {
                                  if (controller.isOpen) {
                                    controller.close();
                                  } else {
                                    controller.open();
                                  }
                                },
                                icon: const Icon(Icons.expand_more));
                          },
                          menuChildren: <MenuItemButton>[
                            MenuItemButton(
                                onPressed: () => Provider.of<TweetsProvider>(
                                    context,
                                    listen: false)
                                    .hide(index),
                                child: const Text('Hide Tweet'))
                          ])
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
                        MenuAnchor(
                            builder: (context, controller, child) {
                              return IconButton(
                                  onPressed: () {
                                    if (controller.isOpen) {
                                      controller.close();
                                    } else {
                                      controller.open();
                                    }
                                  },
                                  icon: const Icon(Icons.chat_bubble_outline));
                            },
                            menuChildren: <MenuItemButton>[
                              MenuItemButton(
                                  onPressed: () async {
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) =>
                                        const CreateTweet()))
                                        .then((comment) {
                                      Provider.of<TweetsProvider>(context,
                                          listen: false)
                                          .addComment(comment, index);
                                    });
                                  },
                                  child: const Text('Reply'))
                            ]),
                        Text('${tweet.numComments}')
                      ]),
                      Row(children: [
                        IconButton(
                          icon: Icon(tweet.isRetweeted
                              ? Icons.repeat_on_sharp
                              : Icons.repeat),
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
                      ),
                    ],
                  ),
                  RepliesWidget(replies)
                ],
              ),
            )
          ],
        ));
  }
}
