import 'package:sqflite/sqflite.dart';
import 'package:ticker/models/ticker.dart';

class DBHelber {
  static Database? _db;
  static const int _version = 2;
  static const String _tableName = 'tick_table';


  static Future<void> initDb() async {
    try {
      if (_db == null) {
        String path = await getDatabasesPath() + 'ticke_db.db';

        _db = await openDatabase(
          path,
          version: _version,
          onCreate: (Database db, int version) async {
            print('database is being created');
            await db.execute('CREATE TABLE $_tableName('
                'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                'name STRING,'
                'color INT,'
                'exchange STRING, '
                'quantity INT, '
                'operation STRING, '
                'entryPrice REAL, '
                'exitPrice REAL,'
                'entryDate STRING,'
                'exitDate STRING, '
                'entryTime STRING,'
                'exitTime STRING, '
                'strategy STRING,'
                'entryComment TEXT,'
                'exitComment TEXT,'
                'broker STRING,'
                'account STRING,'
                'float INT,'
                'market_cap INT,'
                'day_of_treda INT,'
                'reat INT,'
                'target REAL,'
                'stop REAL,'
                'capital REAL,'
                'commission REAL)'
            );
            print('Database is created successfully');
          },
        );
      } else {
        print('Database is already has been created before');

      }
    } catch (e) {
      print('error happened');
      print(e.toString());
    }
  }

  static Future<void> insert(Ticker ticker) async{
    try{
      await _db!.insert(_tableName, ticker.toJson());
    }catch(e){
      print(e.toString());
    }
  }
  static Future<void> delete(int id) async{
    try{
      await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    }catch(e){
      print(e.toString());
    }
  }
  static Future<void> deleteAll() async{
    try{
      await _db!.delete(_tableName);
    }catch(e){
      print(e.toString());
    }
  }
  static Future<List<Map<String, dynamic>>> query() async{
      return await _db!.query(_tableName);
  }
  static Future<int> update(Ticker ticker) async{
    try{
     return await _db!.rawUpdate('''
     UPDATE tick_table 
     SET name = ?,
     color = ?, 
     exchange = ?, 
     quantity = ?, 
     operation = ?, 
     entryPrice = ?, 
     exitPrice = ?, 
     entryDate = ?, 
     exitDate = ?, 
     entryTime = ?, 
     exitTime = ?, 
     strategy = ?, 
     entryComment = ?, 
     exitComment = ?,
     broker = ?,
     account = ?,
     float = ?,
     market_cap = ?,
     day_of_treda = ?,
     reat = ?,
     target = ?,
     stop = ?,
     capital = ?,
     commission = ?
     WHERE id = ?
     ''',
       [
         ticker.name,
         ticker.color,
         ticker.exchangeToString(ticker.exchange),
         ticker.quantity,
         ticker.operationToString(ticker.operation),
         ticker.entryPrice,
         ticker.exitPrice,
         ticker.entryDate,
         ticker.exitDate,
         ticker.entryTime,
         ticker.exitTime,
         ticker.strategyToString(ticker.strategy),
         ticker.entryComment,
         ticker.exitComment,
         ticker.broker.toString(),
         ticker.account.toString(),
         ticker.float,
         ticker.market_cap,
         ticker.day_of_treda,
         ticker.reat,
         ticker.target,
         ticker.stop,
         ticker.capital,
         ticker.commission,
         ticker.id
       ]
     );
    }catch(e){
      print(e.toString());
      return -1;
    }

  }

}
