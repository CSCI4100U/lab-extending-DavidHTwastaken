// The model assumes there is only one user
// as user identification has not been implemented
class Tweet {
  int id;
  String userShortName;
  String userLongName;
  DateTime timeStamp;
  String description;
  String? imageURL;
  int numComments;
  int numRetweets;
  int numLikes;
  bool isLiked;
  bool isRetweeted;
  bool isFavourited;
  bool isHidden;
  int? originalTweetId;

  // Constructor
  Tweet({
    required this.id,
    required this.userShortName,
    required this.userLongName,
    required this.timeStamp,
    required this.description,
    required this.numComments,
    required this.numRetweets,
    required this.numLikes,
    required this.isLiked,
    required this.isRetweeted,
    required this.isFavourited,
    required this.isHidden,
    this.originalTweetId,
    this.imageURL,
  });

  // Method to convert the instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userShortName': userShortName,
      'userLongName': userLongName,
      'timeStamp': timeStamp.toIso8601String(),
      'description': description,
      'imageURL': imageURL,
      'numComments': numComments,
      'numRetweets': numRetweets,
      'numLikes': numLikes,
      'isLiked': isLiked,
      'isRetweeted': isRetweeted,
      'isFavorited': isFavourited,
      'originalTweetId': originalTweetId,
      'isHidden': isHidden
    };
  }

  // Named constructor to create Tweet instance from a map
  Tweet.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        userShortName = map['userShortName'],
        userLongName = map['userLongName'],
        timeStamp = DateTime.parse(map['timeStamp']),
        description = map['description'],
        imageURL = map['imageURL'],
        numComments = map['numComments'],
        numRetweets = map['numRetweets'],
        numLikes = map['numLikes'],
        isLiked = map['isLiked'],
        isRetweeted = map['isRetweeted'],
        isFavourited = map['isFavourited'],
        originalTweetId = map['originalTweetId'],
  isHidden = map['isHidden'];
}
