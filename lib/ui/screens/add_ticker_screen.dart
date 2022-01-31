// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:intl/intl.dart';
import 'package:ticker/controllers/ticker_controller.dart';
import 'package:ticker/models/enums.dart';
import 'package:ticker/models/funs.dart';
import 'package:ticker/models/ticker.dart';
import 'package:ticker/ui/widgets/add_button.dart';
import 'package:ticker/ui/widgets/input_field.dart';
import 'package:ticker/ui/widgets/theme.dart';
import 'package:get/get_core/src/get_main.dart';

class AddTickerScreen extends StatefulWidget {
  const AddTickerScreen({Key? key}) : super(key: key);

  @override
  _AddTickerScreenState createState() => _AddTickerScreenState();
}

class _AddTickerScreenState extends State<AddTickerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _entryPriceController = TextEditingController();
  final TextEditingController _exitPriceController = TextEditingController();
  final TextEditingController _entryCommentController = TextEditingController();
  final TextEditingController _exitCommentController = TextEditingController();

  final TextEditingController _dayOfTredaController = TextEditingController();
  final TextEditingController _floatController = TextEditingController();
  final TextEditingController _marketCapController = TextEditingController();
  final TextEditingController _reatController = TextEditingController();

  final TextEditingController _targetController = TextEditingController();
  final TextEditingController _stopController = TextEditingController();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _commissionController = TextEditingController();


  final TextEditingController _entrySecondsController = TextEditingController();
  final TextEditingController _exitSecondsController = TextEditingController();

  Icon startDateIcon = const Icon(Icons.calendar_today_outlined);
  Icon exitDateIcon = const Icon(Icons.calendar_today_outlined);
  Icon startTimeIcon = const Icon(Icons.access_time_outlined);
  Icon exitTimeIcon = const Icon(Icons.access_time_outlined);
  Icon exchangeIcon = const Icon(Icons.arrow_drop_down);
  //Icon operationIcon = const Icon(Icons.arrow_drop_down);
  Icon strategyIcon = const Icon(Icons.arrow_drop_down);
  Icon brokerIcon = const Icon(Icons.arrow_drop_down);
  Icon accountIcon = const Icon(Icons.arrow_drop_down);

  double? entryPrice = 0.0;
  double? exitPrice = 0.0;
  DateTime? entryDate;
  DateTime? exitDate;
  String? entryTime;
  String? exitTime;
  String? entryComment = '';
  String? exitComment = '';
  String? _selectedExchange;
  //String? _selectedOperation;
  String? _selectedStrategy;
  String? _selectedBroker;
  String? _selectedAccount;
  int? day_of_treda = 0;
  int? float = 0;
  int? market_cap = 0;
  int? reat = 0;
  double? target = 0.0;
  double? stop = 0.0;
  double? capital = 0.0;
  double? commission = 0.0;

  //final colors = [primaryClr, pinkClr, orangeClr];
  final colors = [Colors.green, Colors.red, orangeClr];

  List<String> exchangesList = [
    'NASDAQ',
    'NYCE',
  ];

  List<String> operationsList = [
    'Short',
    'Long',
  ];

  List<String> strategiesList = [
    'Mid-Day Low Float Runner',
    'Dip Buy',
    'Multi Day Breakout',
    'Hot Sector',
    'Day 2Runner',
    'Day 3Runner',
    'Day 4Runner',
    'Pre-Market Breakout',
    'Reverse Split'
  ];

  List<String> brokersList = [
    'Trader Zero',
    'Interactive Broker',
    'Td Amer Trade',
  ];

  List<String> accountsList = [
    'Real Account',
    'Demo Account',
  ];

  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back;
        return true;
      },
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Add Trade',
                  style: headingStyle,
                ),
                InputField(
                  title: 'Name',
                  hint: 'Enter name here',
                  controller: _nameController,
                  isCapital: true,
                ),
                InputField(
                  title: 'Quantity',
                  hint: 'Enter quantity here',
                  isNumber: true,
                  controller: _quantityController,
                ),
                /*InputField(
                  title: 'Operation',
                  hint: 'Operation type',
                  label: _selectedOperation,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: operationIcon,
                      onTap: () {
                        if (operationIcon.icon ==
                            Icons.highlight_remove_outlined) {
                          setState(() {
                            _selectedOperation = null;
                            operationIcon = const Icon(Icons.arrow_drop_down);
                          });
                        }
                      },
                      underline: Container(
                        width: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (value) => setState(() {
                        _selectedOperation = value.toString();
                        operationIcon =
                            const Icon(Icons.highlight_remove_outlined);
                      }),
                      items: operationsList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : darkGreyClr),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InputField(
                      title: 'Entry price',
                      hint: '$entryPrice\$',
                      isNumber: true,
                      controller: _entryPriceController,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Exit price',
                      hint: '$exitPrice\$',
                      isNumber: true,
                      controller: _exitPriceController,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InputField(
                      title: 'Target',
                      hint: '$target',
                      isNumber: true,
                      controller: _targetController,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Stop',
                      hint: '$stop',
                      isNumber: true,
                      controller: _stopController,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InputField(
                      title: 'Capital',
                      hint: '$capital',
                      isNumber: true,
                      controller: _capitalController,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Commission',
                      hint: '$commission',
                      isNumber: true,
                      controller: _commissionController,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Entry date',
                        hint: DateFormat.yMMMd()
                            .format(DateTime.now())
                            .toString(),
                        label: entryDate != null
                            ? DateFormat.yMMMd().format(entryDate!).toString()
                            : null,
                        widget: IconButton(
                          icon: startDateIcon,
                          onPressed: () {
                            if (startDateIcon.icon ==
                                Icons.highlight_remove_outlined) {
                              setState(() {
                                entryDate = null;
                                startDateIcon =
                                    const Icon(Icons.calendar_today_outlined);
                                return;
                              });
                            } else
                              return pickDate(isEntry: true);
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InputField(
                        title: 'Exit date',
                        hint: DateFormat.yMMMd()
                            .format(
                                DateTime.now().add(const Duration(minutes: 15)))
                            .toString(),
                        label: exitDate != null
                            ? DateFormat.yMMMd().format(exitDate!).toString()
                            : null,
                        widget: IconButton(
                          icon: exitDateIcon,
                          onPressed: () {
                            if (exitDateIcon.icon ==
                                Icons.highlight_remove_outlined) {
                              setState(() {
                                exitDate = null;
                                exitDateIcon =
                                    const Icon(Icons.calendar_today_outlined);
                                return;
                              });
                            } else
                              return pickDate(isEntry: false);
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: InputField(
                        title: 'Entry time',
                        hint: DateFormat('HH:mm a')
                            .format(DateTime.now())
                            .toString(),
                        label: entryTime,
                        widget: IconButton(
                          icon: startTimeIcon,
                          onPressed: () {
                            if (startTimeIcon.icon ==
                                Icons.highlight_remove_outlined) {
                              setState(() {
                                entryTime = null;
                                startTimeIcon =
                                const Icon(Icons.access_time_outlined);
                                return;
                              });
                            } else
                              return pickTime(isEntry: true);
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Flexible(
                      flex: 1,
                      child: InputField(
                        isNumber: true,
                        title: 'Sec',
                        hint: '00',
                        controller: _entrySecondsController,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: InputField(
                        title: 'Exit time',
                        hint: DateFormat('HH:mm a')
                            .format(
                                DateTime.now().add(const Duration(minutes: 15)))
                            .toString(),
                        label: exitTime,
                        widget: IconButton(
                          icon: exitTimeIcon,
                          onPressed: () {
                            if (exitTimeIcon.icon ==
                                Icons.highlight_remove_outlined) {
                              setState(() {
                                exitTime = null;
                                exitTimeIcon =
                                    const Icon(Icons.access_time_outlined);
                                return;
                              });
                            } else
                              return pickTime(isEntry: false);
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Flexible(
                      flex: 1,
                      child: InputField(
                        isNumber: true,
                        title: 'Sec',
                        hint: '00',
                        controller: _exitSecondsController,
                      ),
                    ),
                  ],
                ),
                InputField(
                  title: 'Exchange',
                  hint: 'Exchange type',
                  label: _selectedExchange,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      onTap: () {
                        if (exchangeIcon.icon ==
                            Icons.highlight_remove_outlined) {
                          setState(() {
                            _selectedExchange = null;
                            exchangeIcon = const Icon(Icons.arrow_drop_down);
                          });
                        }
                      },
                      icon: exchangeIcon,
                      underline: Container(
                        height: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (value) => setState(() {
                        _selectedExchange = value.toString();
                        exchangeIcon =
                            const Icon(Icons.highlight_remove_outlined);
                      }),
                      items: exchangesList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : darkGreyClr),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                InputField(
                  title: 'Strategy',
                  hint: 'Strategy type',
                  label: _selectedStrategy,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: strategyIcon,
                      onTap: () {
                        if (strategyIcon.icon ==
                            Icons.highlight_remove_outlined) {
                          setState(() {
                            _selectedStrategy = null;
                            strategyIcon = const Icon(Icons.arrow_drop_down);
                          });
                        }
                      },
                      underline: Container(
                        width: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (value) => setState(() {
                        _selectedStrategy = value.toString();
                        strategyIcon =
                            const Icon(Icons.highlight_remove_outlined);
                      }),
                      items: strategiesList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : darkGreyClr),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InputField(
                      title: 'Market cap',
                      hint: '$market_cap',
                      isNumber: true,
                      controller: _marketCapController,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Reat',
                      hint: '$reat',
                      isNumber: true,
                      controller: _reatController,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InputField(
                      title: 'Day of treda',
                      hint: '$day_of_treda',
                      isNumber: true,
                      controller: _dayOfTredaController,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Float',
                      hint: '$float',
                      isNumber: true,
                      controller: _floatController,
                    )),
                  ],
                ),
                InputField(
                  title: 'Broker',
                  hint: 'Broker type',
                  label: _selectedBroker,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: brokerIcon,
                      onTap: () {
                        if (brokerIcon.icon ==
                            Icons.highlight_remove_outlined) {
                          setState(() {
                            _selectedBroker = null;
                            brokerIcon = const Icon(Icons.arrow_drop_down);
                          });
                        }
                      },
                      underline: Container(
                        width: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (value) => setState(() {
                        _selectedBroker = value.toString();
                        brokerIcon =
                            const Icon(Icons.highlight_remove_outlined);
                      }),
                      items: brokersList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : darkGreyClr),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                InputField(
                  title: 'Account',
                  hint: 'Account type',
                  label: _selectedAccount,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: accountIcon,
                      onTap: () {
                        if (accountIcon.icon ==
                            Icons.highlight_remove_outlined) {
                          setState(() {
                            _selectedAccount = null;
                            accountIcon = const Icon(Icons.arrow_drop_down);
                          });
                        }
                      },
                      underline: Container(
                        width: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (value) => setState(() {
                        _selectedAccount = value.toString();
                        accountIcon =
                            const Icon(Icons.highlight_remove_outlined);
                      }),
                      items: accountsList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : darkGreyClr),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                InputField(
                  title: 'Entry comment',
                  hint: 'Why did you enter this trade',
                  controller: _entryCommentController,
                  maxLines: 6,
                ),
                InputField(
                  title: 'Exit comment',
                  hint: 'Why did you leave this trade',
                  controller: _exitCommentController,
                  maxLines: 6,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    AddTickerButton(
                      label: 'Add now',
                      onTap: () => addTicker(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isAllDataValid(){
    if (compareEntryAndExitDates() == false) {
      Functions.dateOrderingError();
      return false;
    }
    if(_nameController.text.isEmpty){
      Functions.nameFieldIsRequired();
      return false;
    }
    if(entryTime != null){
      if(_entrySecondsController.text.isEmpty){
        entryTime = entryTime! + ':00';
      }
      else if(areTwoValidDigits(_entrySecondsController.text) == -1 || areTwoValidDigits(_entrySecondsController.text) >= 60){
        Functions.invalidSeconds();
        return false;
      }
      else{
        if(areTwoValidDigits(_entrySecondsController.text)<10)
        entryTime = entryTime! + ':0' + areTwoValidDigits(_entrySecondsController.text).toString();
        else
          entryTime = entryTime! + ':' + areTwoValidDigits(_entrySecondsController.text).toString();
      }
    }
    if(exitTime != null){
      if(_exitSecondsController.text.isEmpty){
        exitTime = exitTime! + ':00';
      }
      else if(areTwoValidDigits(_exitSecondsController.text) == -1 || areTwoValidDigits(_exitSecondsController.text) >= 60){
        Functions.invalidSeconds();
        return false;
      }
      else{
        if(areTwoValidDigits(_exitSecondsController.text)<10)
          exitTime = exitTime! + ':0' + areTwoValidDigits(_exitSecondsController.text).toString();
        else
          exitTime = exitTime! + ':' + areTwoValidDigits(_exitSecondsController.text).toString();
      }
    }
    if(_quantityController.text.isNotEmpty && (int.tryParse(_quantityController.text)??-1) == -1){
        Functions.invalidData('Quantity must be integer, remove any dots');
        return false;
    }
    if(_entryPriceController.text.isNotEmpty && (double.tryParse(_entryPriceController.text)??-1) == -1.0){
      Functions.invalidData('Entry price invalid input');
      return false;
    }

    if(_exitPriceController.text.isNotEmpty && (double.tryParse(_exitPriceController.text)??-1) == -1.0){
      Functions.invalidData('Exit price invalid input');
      return false;
    }

    if(_dayOfTredaController.text.isNotEmpty && (int.tryParse(_dayOfTredaController.text)??-1) == -1){
      Functions.invalidData('Day of treda invalid input, remove any dots');
      return false;
    }

    if(_floatController.text.isNotEmpty && (int.tryParse(_floatController.text)??-1) == -1){
      Functions.invalidData('Float invalid input, remove any dots');
      return false;
    }

    if(_marketCapController.text.isNotEmpty && (int.tryParse(_marketCapController.text)??-1) == -1){
      Functions.invalidData('Market cap invalid input, remove any dots');
      return false;
    }

    if(_reatController.text.isNotEmpty && (int.tryParse(_reatController.text)??-1) == -1){
      Functions.invalidData('Reat invalid input, remove any dots');
      return false;
    }

    if(_targetController.text.isNotEmpty && (double.tryParse(_targetController.text)??-1) == -1.0){
      Functions.invalidData('Target invalid input');
      return false;
    }

    if(_stopController.text.isNotEmpty && (double.tryParse(_stopController.text)??-1) == -1.0){
      Functions.invalidData('Stop invalid input');
      return false;
    }

    if(_capitalController.text.isNotEmpty && (double.tryParse(_capitalController.text)??-1) == -1.0){
      Functions.invalidData('Capital invalid input');
      return false;
    }

    if(_commissionController.text.isNotEmpty && (double.tryParse(_commissionController.text)??-1) == -1.0){
      Functions.invalidData('Commission invalid input');
      return false;
    }
    return true;
  }

  addTicker() {
    if (isAllDataValid()) {
      addTickerToDb();
      Get.back();
    }
  }

  addTickerToDb() async {
    await TickerController.insertTicker(Ticker(
      name: _nameController.text,
      // color: _selectedColor,
      color: calcNetProfitOnLose() != null
          ? calcNetProfitOnLose()! > 0
              ? 0
              : calcNetProfitOnLose()! == 0
                  ? 2
                  : 1
          : 2,
      quantity: _quantityController.text.isNotEmpty
          ? int.parse(_quantityController.text)
          : null,
      entryPrice: _entryPriceController.text.isNotEmpty
          ? double.parse(_entryPriceController.text)
          : null,
      exitPrice: _exitPriceController.text.isNotEmpty
          ? double.parse(_exitPriceController.text)
          : null,
      entryDate: entryDate != null ? entryDate!.toString() : null,
      exitDate: exitDate != null ? exitDate!.toString() : null,
      entryTime: entryTime,
      exitTime: exitTime,
      entryComment: _entryCommentController.text.isEmpty
          ? null
          : _entryCommentController.text,
      exitComment: _exitCommentController.text.isEmpty
          ? null
          : _exitCommentController.text,
      exchange: getExchange,
      //operation: getOperation,
      strategy: getStrategy,
      account: getAccount,
      broker: getBroker,
      day_of_treda: _dayOfTredaController.text.isNotEmpty
          ? int.parse(_dayOfTredaController.text)
          : null,
      float: _floatController.text.isNotEmpty
          ? int.parse(_floatController.text)
          : null,
      market_cap: _marketCapController.text.isNotEmpty
          ? int.parse(_marketCapController.text)
          : null,
      reat: _reatController.text.isNotEmpty
          ? int.parse(_reatController.text)
          : null,

      target: _targetController.text.isNotEmpty
          ? double.parse(_targetController.text)
          : null,
      stop: _stopController.text.isNotEmpty
          ? double.parse(_stopController.text)
          : null,
      capital: _capitalController.text.isNotEmpty
          ? double.parse(_capitalController.text)
          : null,
      commission: _commissionController.text.isNotEmpty
          ? double.parse(_commissionController.text)
          : null,
    ));

    print('inserted successfully');
  }

  bool compareEntryAndExitDates() {
    if (entryDate != null && exitDate != null) {
      if (exitDate!.difference(entryDate!).inDays >= 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Exchange? get getExchange {
    if (_selectedExchange == 'NASDAQ') {
      return Exchange.nasdaq;
    } else if (_selectedExchange == 'NYCE') {
      return Exchange.nyce;
    }
    return null;
  }

  /*Operation? get getOperation {
    if (_selectedOperation == 'Long') {
      return Operation.long;
    } else if (_selectedOperation == 'Short') {
      return Operation.short;
    }
    return null;
  }*/

  Strategy? get getStrategy {
    if (_selectedStrategy == 'Day 2Runner') {
      return Strategy.day_2Runner;
    } else if (_selectedStrategy == 'Day 3Runner') {
      return Strategy.day_3Runner;
    } else if (_selectedStrategy == 'Day 4Runner') {
      return Strategy.day_4Runner;
    } else if (_selectedStrategy == 'Dip Buy') {
      return Strategy.dipBuy;
    } else if (_selectedStrategy == 'Hot Sector') {
      return Strategy.hotSector;
    } else if (_selectedStrategy == 'Mid-Day Low Float Runner') {
      return Strategy.midDayLowFloatRunner;
    } else if (_selectedStrategy == 'Multi Day Breakout') {
      return Strategy.multiDayBreakout;
    } else if (_selectedStrategy == 'Pre-Market Breakout') {
      return Strategy.preMarketBreakout;
    } else if (_selectedStrategy == 'Reverse Split') {
      return Strategy.reverseSplit;
    }
    return null;
  }

  Broker? get getBroker {
    if (_selectedBroker == 'Trader Zero') {
      return Broker.traderZero;
    } else if (_selectedBroker == 'Td Amer Trade') {
      return Broker.tdAmerTrade;
    } else if (_selectedBroker == 'Interactive Broker') {
      return Broker.interactiveBroker;
    }
    return null;
  }

  Account? get getAccount {
    if (_selectedAccount == 'Real Account') {
      return Account.realAccount;
    } else if (_selectedAccount == 'Demo Account') {
      return Account.demoAccount;
    }
    return null;
  }

  AppBar _appBar() {
    return AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
        ),
        backgroundColor: context.theme.backgroundColor);
  }

  pickDate({bool isEntry = false}) async {
    DateTime? _pickDate = await showDatePicker(
        context: context,
        initialDate: isEntry
            ? entryDate != null
                ? entryDate!
                : DateTime.now()
            : exitDate != null
                ? exitDate!
                : DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime(2017),
        lastDate: DateTime(2099));
    setState(() {
      if (_pickDate != null) {
        if (isEntry) {
          entryDate = _pickDate.toLocal();
          startDateIcon = const Icon(Icons.highlight_remove_outlined);
        } else {
          exitDate = _pickDate.toLocal();
          exitDateIcon = const Icon(Icons.highlight_remove_outlined);
        }
      }
    });
  }

  pickTime({bool isEntry = false}) async {
    TimeOfDay? _pickTime = await showTimePicker(
      context: context,
      initialTime: isEntry
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(
                const Duration(minutes: 15),
              ),
            ),
    );
    if (_pickTime != null) {
      setState(() {
        if (isEntry) {
          entryTime = '';
          if (_pickTime.hour < 10) entryTime = '0';
          entryTime = entryTime! + _pickTime.hour.toString() + ':';
          if (_pickTime.minute < 10) entryTime = entryTime! + '0';
          entryTime = entryTime! + _pickTime.minute.toString();
          startTimeIcon = const Icon(Icons.highlight_remove_outlined);
          print('entry time = $entryTime');
        } else {
          //exitTime = _pickTime.hour.toString() + ':' + _pickTime.minute.toString();
          exitTime = '';
          if (_pickTime.hour < 10) exitTime = '0';
          exitTime = exitTime! + _pickTime.hour.toString() + ':';
          if (_pickTime.minute < 10) exitTime = exitTime! + '0';
          exitTime = exitTime! + _pickTime.minute.toString();
          exitTimeIcon = const Icon(Icons.highlight_remove_outlined);
        }
      });
    }
  }

  double? calcNetProfitOnLose() {
    if (_entryPriceController.text.isNotEmpty &&
        _exitPriceController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _commissionController.text.isNotEmpty) {
      return ((
          (
          (double.tryParse(_exitPriceController.text) ?? 0)
              - (double.tryParse(_entryPriceController.text) ?? 0)
          )
          * (int.tryParse(_quantityController.text) ?? 0)
      )-(double.tryParse(_commissionController.text) ?? 0));
    }
    return null;
  }

  int areTwoValidDigits(text){
    return int.tryParse(text)??-1;
  }

}
