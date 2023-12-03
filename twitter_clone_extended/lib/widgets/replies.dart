import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/models/tweet.dart';
import 'package:twitter_clone_extended/utilities/convert_post_time.dart';

class RepliesWidget extends StatelessWidget {
  final List<Tweet> replies;

  const RepliesWidget(this.replies, {super.key});

  Widget buildReply(Tweet tweet) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                ],
              ),
              const SizedBox(height: 10),
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
                              height: 120,
                              color: Colors.grey,
                              child: const Text("Invalid image URL")));
                    },
                  );
                }
                return Container();
              })(),
              const SizedBox(height: 40)
            ]),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
            children: List<Widget>.generate(
                replies.length, (index) => buildReply(replies[index]))));
  }
}
