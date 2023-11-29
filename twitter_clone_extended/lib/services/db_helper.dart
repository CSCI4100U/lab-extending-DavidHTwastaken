import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  late Database db;

  static final DatabaseHelper _instance = DatabaseHelper._();
  DatabaseHelper._();
  factory DatabaseHelper(){
    return _instance;
  }

  Future<Database> get database async{
    return db;
  }

  Future<void> _init() async{
    db = await openDatabase(join(await getDatabasesPath(), 'tweets.db'), version: 1);
  }


}