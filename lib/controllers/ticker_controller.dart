import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ticker/db/db_helber.dart';
import 'package:ticker/models/ticker.dart';

class TickerController{
static RxList tickerList = <Ticker>[].obs;
static Future<void> insertTicker(Ticker ticker) async{
  return await DBHelber.insert(ticker);
}

static void deleteTicker(int id) async{
  await DBHelber.delete(id);
  getAllTickers();

}

static void deleteAllTickers() async{
   DBHelber.deleteAll();
   getAllTickers();
}

static Future<int> updateTicker(Ticker ticker) async{
  return await DBHelber.update(ticker);
}

static Future<void> getAllTickers() async{
  final List<Map<String, dynamic>> list = await DBHelber.query();
  tickerList.assignAll(list.map((data) => Ticker.fromJson(data)).toList());
}
}