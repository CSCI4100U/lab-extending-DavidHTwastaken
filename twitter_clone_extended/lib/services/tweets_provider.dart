import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/models/tweet.dart';
import 'package:twitter_clone_extended/services/db_helper.dart';

class TweetsProvider extends ChangeNotifier {
  Map<int?, List<Tweet>> _tweets = {};
  Map<int?, List<Tweet>> get tweets => {..._tweets};
  DatabaseHelper db = DatabaseHelper();

  TweetsProvider() {
    refresh();
  }

  Future<void> refresh() async {
    _tweets = await db.getTweets();
    notifyListeners();
  }

  void add(Tweet tweet) {
    if (_tweets.containsKey(tweet.originalTweetId)) {
      _tweets[tweet.originalTweetId]!.add(tweet);
    } else {
      _tweets[tweet.originalTweetId] = [tweet];
    }
    notifyListeners();
  }

  void hide(int index) {
    Tweet tweet = _tweets[null]![index];
    db.updateTweet(tweet.id, {'isHidden': true}).then((val) {
      _tweets[null]![index].isHidden = true;
      notifyListeners();
    });
  }

  void retweet(int index) {
    Tweet tweet = _tweets[null]![index];
    bool isRetweeted = !tweet.isRetweeted;
    int numRetweets =
        tweet.isRetweeted ? tweet.numRetweets - 1 : tweet.numRetweets + 1;
    db.updateTweet(tweet.id, <String, dynamic>{
      'numLikes': numRetweets,
      'isLiked': isRetweeted
    }).then((val) {
      _tweets[null]![index].numRetweets = numRetweets;
      _tweets[null]![index].isRetweeted = isRetweeted;
      notifyListeners();
    });
  }

  void like(int index) {
    Tweet tweet = _tweets[null]![index];
    bool isLiked = !tweet.isLiked;
    int numLikes = tweet.isLiked ? tweet.numLikes - 1 : tweet.numLikes + 1;
    db.updateTweet(tweet.id, <String, dynamic>{
      'numLikes': numLikes,
      'isLiked': isLiked
    }).then((val) {
      _tweets[null]![index].numLikes = numLikes;
      _tweets[null]![index].isLiked = isLiked;
      notifyListeners();
    });
  }

  void favourite(int index) {
    Tweet tweet = _tweets[null]![index];
    bool isFavourited = !tweet.isFavourited;
    db.updateTweet(tweet.id, <String, dynamic>{
      'isFavourited': isFavourited,
    }).then((val) {
      _tweets[null]![index].isFavourited = isFavourited;
      _tweets[null]!.sort((b,a){
        if((a.isFavourited && b.isFavourited) || !(a.isFavourited || b.isFavourited)){
          return a.timeStamp.compareTo(b.timeStamp);
        }
        return a.isFavourited ? 1 : -1;
      });
      notifyListeners();
    });
  }

  void addComment(Map<String, dynamic> comment, int index) async {
    Tweet tweet = _tweets[null]![index];
    Tweet newTweet = await db.insertTweet({...comment, 'originalTweetId': tweet.id});
    await db.updateTweet(tweet.id, {'numComments': tweet.numComments + 1});
    add(newTweet);
    notifyListeners();
  }
}
