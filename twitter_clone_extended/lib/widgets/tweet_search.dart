import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_extended/services/tweets_provider.dart';
import 'package:twitter_clone_extended/utilities/fuzzy_search.dart';
import '../models/tweet.dart';
import 'tweet.dart';

class TweetSearch extends StatelessWidget {
  const TweetSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TweetsProvider>(builder: (context, tweetsProvider,child){
      Map<int?, List<Tweet>> tweetsMap = tweetsProvider.tweets;
      return SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
        return IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            controller.openView();
          },
        );
      }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
        tweetsMap[null] =
            fuzzySearch(controller.text, tweetsProvider.tweets[null]!);
        List<Tweet> tweets = tweetsMap[null]!;
        return List<TweetWidget>.generate(tweetsMap[null]!.length, (index) {
          return TweetWidget(
              tweet: tweets[index],
              index: index,
              replies: tweetsMap.containsKey(tweets[index].id)
                  ? tweetsMap[tweets[index].id]!
                  : []);
        });
      });
    });
  }
}
