import 'package:flutter/material.dart';
import 'package:twitter_clone_extended/models/tweet.dart';
import 'package:twitter_clone_extended/services/db_helper.dart';

class TweetsProvider extends ChangeNotifier{
  List<Tweet> tweets = [];
  DatabaseHelper db = DatabaseHelper();

  TweetsProvider(){
    refresh();
  }

  Future<void> refresh() async{
    tweets = await db.getTweets();
    notifyListeners();
  }
}