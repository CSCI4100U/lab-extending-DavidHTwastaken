import '../models/tweet.dart';

List<Tweet> fuzzySearch(String query, List<Tweet> tweets){
  List<Tweet> results = [];
  query = query.toLowerCase();

  for (int i = 0; i < tweets.length; i++) {
    Tweet tweet = tweets[i];
    if (tweet.userLongName.toLowerCase().contains(query) ||
        tweet.userShortName.toLowerCase().contains(query) ||
        tweet.description.toLowerCase().contains(query)) {
      results.add(tweet);
    }
  }
  results.sort((a, b) {
    int aScore = 0;
    int bScore = 0;
    if (a.userLongName.toLowerCase().contains(query.toLowerCase())) {
      aScore += 1;
    }
    if (a.userShortName.toLowerCase().contains(query.toLowerCase())) {
      aScore += 1;
    }
    if (a.description.toLowerCase().contains(query.toLowerCase())) {
      aScore += 1;
    }
    if (b.userLongName.toLowerCase().contains(query.toLowerCase())) {
      bScore += 1;
    }
    if (b.userShortName.toLowerCase().contains(query.toLowerCase())) {
      bScore += 1;
    }
    if (b.description.toLowerCase().contains(query.toLowerCase())) {
      bScore += 1;
    }
    return bScore - aScore;
  });
  return results;
}