import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:twitter_clone_extended/models/tweet.dart';
import 'package:twitter_clone_extended/utilities/int_bool_conversion.dart';

class DatabaseHelper {
  late Database db;
  final String tableName = 'tweets';
  final defaults = {
    'timeStamp': DateTime.now().toIso8601String(),
    'numComments': 0,
    'numLikes': 0,
    'numRetweets': 0,
    'isLiked': false,
    'isRetweeted': false
  };
  final bools = ['isLiked','isRetweeted'];

  static final DatabaseHelper _instance = DatabaseHelper._();
  DatabaseHelper._();
  factory DatabaseHelper() {
    return _instance;
  }

  Future<void> _init() async {
    String sql = '''CREATE TABLE IF NOT EXISTS tweets (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userShortName TEXT NOT NULL,
      userLongName TEXT NOT NULL,
      timeStamp TEXT NOT NULL,
      description TEXT NOT NULL,
      numComments INT NOT NULL,
      numRetweets INT NOT NULL,
      numLikes INT NOT NULL,
      imageURL TEXT,
      originalTweetId INTEGER,
      isLiked BOOLEAN NOT NULL,
      isRetweeted BOOLEAN NOT NULL      
    )
    ''';
    db = await openDatabase(join(await getDatabasesPath(), 'tweets.db'),
        version: 1, onCreate: (database, version) => database.execute(sql));
  }

  Future<List<Tweet>> getTweets() async {
    await _init();
    return await db.query(tableName, orderBy: 'timeStamp').then((list) => list
        .map((e) => Tweet.fromMap({
              ...e,
              'isLiked': intToBool(e['isLiked'] as int),
              'isRetweeted': intToBool(e['isRetweeted'] as int)
            }))
        .toList());
  }

  Future<Tweet> insertTweet(Map<String, dynamic> tweet) async {
    await _init();
    Map<String,dynamic> data = {...defaults, ...tweet};
    int id = await db
        .insert(tableName, convertMapBoolsToInt(data));
    return Tweet.fromMap({...data, 'id': id});
  }

  Future<void> updateTweet(int id, Map<String, dynamic> values) async {
    await db.update(tableName, values, where: 'id = $id');
  }
}
