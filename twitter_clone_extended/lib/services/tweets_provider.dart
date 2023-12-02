import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/models/tweet.dart';
import 'package:twitter_clone_extended/services/db_helper.dart';

class TweetsProvider extends ChangeNotifier {
  List<Tweet> _tweets = [];
  List<Tweet> get tweets => [..._tweets];
  DatabaseHelper db = DatabaseHelper();

  TweetsProvider() {
    refresh();
  }

  Future<void> refresh() async {
    _tweets = await db.getTweets();
    notifyListeners();
  }

  void add(Tweet tweet) {
    _tweets.add(tweet);
    notifyListeners();
  }

  void retweet(int index) {
      Tweet tweet = _tweets[index];
      bool isRetweeted = !tweet.isRetweeted;
      int numRetweets = tweet.isRetweeted
          ? tweet.numRetweets - 1
          : tweet.numRetweets + 1;
      db.updateTweet(tweet.id, <String, dynamic>{
        'numLikes': numRetweets,
        'isLiked': isRetweeted
      }).then((val) {
        _tweets[index].numRetweets = numRetweets;
        _tweets[index].isLiked = isRetweeted;
      });
      notifyListeners();
  }

  void like(int index) {
    Tweet tweet = _tweets[index];
    bool isLiked = !tweet.isLiked;
    int numLikes = tweet.isLiked ? tweet.numLikes - 1 : tweet.numLikes + 1;
    db.updateTweet(tweet.id, <String, dynamic>{
      'numLikes': numLikes,
      'isLiked': isLiked
    }).then((val) {
      _tweets[index].numLikes = numLikes;
      _tweets[index].isLiked = isLiked;
    });
    notifyListeners();
  }

  void favourite(int index) {
    Tweet tweet = _tweets[index];
    bool isFavourited = !tweet.isFavourited;
    db.updateTweet(tweet.id, <String, dynamic>{
      'isFavourited': isFavourited,
    }).then((val) {
      _tweets[index].isFavourited = isFavourited;
    });
    notifyListeners();
  }
}
