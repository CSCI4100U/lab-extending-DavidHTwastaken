class Tweet {
  String userShortName;
  String userLongName;
  DateTime timeStamp;
  String description;
  String? imageURL;
  int numComments;
  int numRetweets;
  int numLikes;

  // Constructor
  Tweet({
    required this.userShortName,
    required this.userLongName,
    required this.timeStamp,
    required this.description,
    this.imageURL,
    required this.numComments,
    required this.numRetweets,
    required this.numLikes,
  });

  // Method to convert the instance to a map
  Map<String, dynamic> toMap() {
    return {
      'userShortName': userShortName,
      'userLongName': userLongName,
      'timeStamp': timeStamp.toIso8601String(),
      'description': description,
      'imageURL': imageURL,
      'numComments': numComments,
      'numRetweets': numRetweets,
      'numLikes': numLikes,
    };
  }

  // Named constructor to create Tweet instance from a map
  Tweet.fromMap(Map<String, dynamic> map)
      : userShortName = map['userShortName'],
        userLongName = map['userLongName'],
        timeStamp = DateTime.parse(map['timeStamp']),
        description = map['description'],
        imageURL = map['imageURL'],
        numComments = map['numComments'],
        numRetweets = map['numRetweets'],
        numLikes = map['numLikes'];
}