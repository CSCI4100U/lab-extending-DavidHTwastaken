import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:twitter_clone_extended/models/tweet.dart';

class DatabaseHelper {
  late Database db;
  final String tableName = 'tweets';

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
      imageURL TEXT
    )
    ''';
    db = await openDatabase(join(await getDatabasesPath(), 'tweets.db'),
        version: 1, onCreate: (database, version) => database.execute(sql));
  }

  Future<List<Tweet>> getTweets() async {
    await _init();
    return await db
        .query(tableName,orderBy: 'timeStamp')
        .then((list) => list.map((e) => Tweet.fromMap(e)).toList());
  }

  Future<void> insertTweet(Tweet tweet) async {
    await _init();
    await db.insert(tableName, tweet.toMap());
  }
}
