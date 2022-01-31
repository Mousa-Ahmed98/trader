
import 'package:ticker/models/enums.dart';

class Ticker {
  int? id;
  late String name;
  Exchange? exchange;
  int? quantity;
  Operation? operation;
  double? entryPrice;
  double? exitPrice;
  String? entryDate;
  String? exitDate;
  String? entryTime;
  String? exitTime;
  Strategy? strategy;
  String? entryComment;
  String? exitComment;
  late int color;
  Broker? broker;
  Account? account;
  int? float;
  int? market_cap;
  int? day_of_treda;
  int? reat;
  double? target;
  double? stop;
  double? capital;
  double? commission;

  Ticker({
    this.id,
    required this.name,
    required this.color,
    this.exchange,
    this.quantity,
    this.operation,
    this.entryPrice,
    this.exitPrice,
    this.entryDate,
    this.exitDate,
    this.entryTime,
    this.exitTime,
    this.strategy,
    this.entryComment,
    this.exitComment,
    this.broker,
    this.account,
    this.float,
    this.market_cap,
    this.day_of_treda,
    this.reat,
    this.target,
    this.stop,
    this.capital,
    this.commission,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'exchange': exchange.toString(),
      'quantity': quantity,
      'operation': operation.toString(),
      'entryPrice': entryPrice,
      'exitPrice': exitPrice,
      'entryDate': entryDate,
      'exitDate': exitDate,
      'entryTime': entryTime,
      'exitTime': exitTime,
      'strategy': strategy.toString(),
      'entryComment': entryComment,
      'exitComment': exitComment,
      'broker' : broker.toString(),
      'account' : account.toString(),
      'float' : float,
      'market_cap' : market_cap,
      'day_of_treda' : day_of_treda,
      'reat' : reat,
      'target' : target,
      'stop' : stop,
      'capital' : capital,
      'commission' : commission,
    };
  }


  Ticker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    exchange = _getExchange(json['exchange']);
    quantity = json['quantity'];
    operation = _getOperation(json['operation']);
    entryPrice = json['entryPrice'];
    exitPrice = json['exitPrice'];
    entryDate = json['entryDate'];
    exitDate = json['exitDate'];
    entryTime = json['entryTime'];
    exitTime = json['exitTime'];
    strategy = _getStrategy(json['strategy']);
    entryComment = json['entryComment'];
    exitComment = json['exitComment'];
    float = json['float'];
    market_cap = json['market_cap'];
    day_of_treda = json['day_of_treda'];
    reat = json['reat'];
    account = _getAccount(json['account']);
    broker = _getBroker(json['broker']);
    target = json['target'];
    stop = json['stop'];
    capital = json['capital'];
    commission = json['commission'];
  }

  Broker? _getBroker(String val){
    if(val == Broker.interactiveBroker.toString()) {
      return Broker.interactiveBroker;
    }
    else if(val == Broker.tdAmerTrade.toString()) {
      return Broker.tdAmerTrade;
    }
    else if(val == Broker.traderZero.toString()) {
      return Broker.traderZero;
    }
    return null;
  }
  Account? _getAccount(String val){
    if(val == Account.demoAccount.toString()) {
      return Account.demoAccount;
    }
    else if(val == Account.realAccount.toString()) {
      return Account.realAccount;
    }
    return null;
  }
  Exchange? _getExchange(String val){
    if(val == Exchange.nasdaq.toString()) {
      return Exchange.nasdaq;
    }
    else if(val == Exchange.nyce.toString()){
      return Exchange.nyce;
    }
    else {
      return null;
    }
  }
  Operation? _getOperation(String val){
    if(val == Operation.short.toString()) {
      return Operation.short;
    }
    else if(val == Operation.long.toString()){
      return Operation.long;
    }
    else {
      return null;
    }
  }
  Strategy? _getStrategy(String val) {

    if(val == Strategy.reverseSplit.toString()) {
      return Strategy.reverseSplit;
    }
    else if(val == Strategy.preMarketBreakout.toString()) {
      return Strategy.preMarketBreakout;
    }
    else if(val == Strategy.midDayLowFloatRunner.toString()) {
      return Strategy.midDayLowFloatRunner;
    }
    else if(val == Strategy.hotSector.toString()) {
      return Strategy.hotSector;
    }
    else if(val == Strategy.multiDayBreakout.toString()) {
      return Strategy.multiDayBreakout;
    }
    else if(val == Strategy.day_2Runner.toString()) {
      return Strategy.day_2Runner;
    }
    else if(val == Strategy.day_3Runner.toString()) {
      return Strategy.day_3Runner;
    }
    else if(val == Strategy.day_4Runner.toString()) {
      return Strategy.day_4Runner;
    }
    else {
      return null;
    }
  }

  String exchangeToString(Exchange? exchange){
    return exchange.toString();
  }

  String operationToString(Operation? operation){
    return operation.toString();
  }

  String strategyToString(Strategy? strategy){
    return strategy.toString();
  }

}
