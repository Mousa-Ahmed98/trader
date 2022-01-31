// ignore_for_file: curly_braces_in_flow_control_structures, prefer_null_aware_operators, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ticker/controllers/ticker_controller.dart';
import 'package:ticker/models/enums.dart';
import 'package:ticker/models/funs.dart';
import 'package:ticker/models/ticker.dart';
import 'package:ticker/ui/widgets/add_button.dart';
import 'package:ticker/ui/widgets/input_field.dart';
import 'package:ticker/ui/widgets/theme.dart';
import 'package:get/get_core/src/get_main.dart';

class TickerDetailsScreen extends StatefulWidget {
  final Ticker ticker;

  const TickerDetailsScreen({Key? key, required this.ticker}) : super(key: key);

  @override
  _TickerDetailsScreenState createState() => _TickerDetailsScreenState();
}

class _TickerDetailsScreenState extends State<TickerDetailsScreen> {
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

  Icon entryDateIcon = const Icon(Icons.calendar_today_outlined);
  Icon exitDateIcon = const Icon(Icons.calendar_today_outlined);
  Icon startTimeIcon = const Icon(Icons.access_time_outlined);
  Icon exitTimeIcon = const Icon(Icons.access_time_outlined);
  Icon exchangeIcon = const Icon(Icons.arrow_drop_down);
  Icon operationIcon = const Icon(Icons.arrow_drop_down);
  Icon strategyIcon = const Icon(Icons.arrow_drop_down);
  Icon brokerIcon = const Icon(Icons.arrow_drop_down);
  Icon accountIcon = const Icon(Icons.arrow_drop_down);

  late Ticker ticker;
  late String name;
  int? quantity;
  double? entryPrice;

  double? exitPrice;
  DateTime? entryDate;
  DateTime? exitDate;
  String? entryTime;
  String? exitTime;
  String? entryComment;
  String? exitComment;
  String? _selectedExchange;
  String? _selectedOperation;
  String? _selectedStrategy;
  //int _selectedColor = 3;
  int? day_of_treda;
  int? float;
  int? market_cap;
  int? reat;
  String? _selectedBroker;
  String? _selectedAccount;

  double? target;
  double? stop;
  double? capital;
  double? commission;

  //pinkClr
  final colors = [Colors.green, Colors.red, orangeClr];
  bool editMode = false;
  List<String> exchangesList = [
    'NASDAQ',
    'NYCE',
  ];

  /*List<String> operationsList = [
    'Short',
    'Long',
  ];*/

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
    ticker = widget.ticker;
    resetDefaultTickerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
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
                  'Trade Details',
                  style: headingStyle,
                ),
                InputField(
                  title: 'Name',
                  hint: 'Enter name here',
                  controller: _nameController,
                  isCapital: true,
                  enabled: editMode,
                  label: name,
                ),
                InputField(
                  title: 'Quantity',
                  hint: 'Enter quantity here',
                  isNumber: true,
                  controller: _quantityController,
                  enabled: editMode,
                  // ignore: prefer_null_aware_operators
                  label: quantity != null ? quantity.toString() : null,
                ),
                /*InputField(
                  title: 'Operation',
                  hint: 'Operation type',
                  enabled: editMode,
                  label: _selectedOperation,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: operationIcon,
                      onTap: () {
                        if (editMode == false) {
                          Functions.editModeSnackBar();
                          return;
                        } else if (operationIcon.icon ==
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
                        operationIcon =
                        const Icon(Icons.highlight_remove_outlined);
                        _selectedOperation = value.toString();
                      }),
                      items: operationsList
                          .map(
                            (e) => DropdownMenuItem(
                          enabled: editMode,
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
                      hint: entryPrice != null ? '$entryPrice\$' : '0.0\$',
                      isNumber: true,
                      controller: _entryPriceController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label: entryPrice != null ? entryPrice.toString() : null,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Exit price',
                      hint: exitPrice != null ? '$exitPrice\$' : '0.0\$',
                      isNumber: true,
                      controller: _exitPriceController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label: exitPrice != null ? exitPrice.toString() : null,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Target',
                        hint: target != null ? '$target\$' : '0.0\$',
                        isNumber: true,
                        controller: _targetController,
                        enabled: editMode,
                        // ignore: prefer_null_aware_operators
                        label: target != null ? target.toString() : null,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Stop',
                      hint: stop != null ? '$stop\$' : '0.0\$',
                      isNumber: true,
                      controller: _stopController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label: stop != null ? stop.toString() : null,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InputField(
                      title: 'Capital',
                      hint: capital != null ? '$capital\$' : '0.0\$',
                      isNumber: true,
                      controller: _capitalController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label: capital != null ? capital.toString() : null,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Commission',
                      hint: commission != null ? '$commission\$' : '0.0\$',
                      isNumber: true,
                      controller: _commissionController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label: commission != null ? commission.toString() : null,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Entry date',
                        hint:
                            intl.DateFormat.yMMMd().format(DateTime.now()).toString(),
                        enabled: editMode,
                        label: entryDate!=null? intl.DateFormat.yMMMd().format(entryDate!) : null,
                        widget: IconButton(
                          icon: entryDateIcon,
                          onPressed: () {
                            if (editMode == false) {
                              Functions.editModeSnackBar();
                              return;
                            } else if (entryDateIcon.icon ==
                                Icons.highlight_remove_outlined) {
                              setState(() {
                                entryDate = null;
                                entryDateIcon =
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
                        hint: intl.DateFormat.yMMMd()
                            .format(
                                DateTime.now().add(const Duration(minutes: 15)))
                            .toString(),
                        enabled: editMode,
                        label: exitDate!=null? intl.DateFormat.yMMMd().format(exitDate!) : null,
                        widget: IconButton(
                          icon: exitDateIcon,
                          onPressed: () {
                            if (editMode == false) {
                              Functions.editModeSnackBar();
                              return null;
                            } else if (exitDateIcon.icon ==
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
                //Entry Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: InputField(
                        title: 'Entry time',
                        hint: intl.DateFormat('HH:mm a')
                            .format(DateTime.now())
                            .toString(),
                        enabled: editMode,
                        label: entryTime,
                        widget: IconButton(
                          icon: startTimeIcon,
                          onPressed: () {
                            if (editMode == false) {
                              Functions.editModeSnackBar();
                              return null;
                            } else {
                              if (startTimeIcon.icon ==
                                  Icons.highlight_remove_outlined) {
                                setState(() {
                                  entryTime = null;
                                  startTimeIcon =
                                      const Icon(Icons.access_time_outlined);
                                  return null;
                                });
                              } else
                                return pickTime(isEntry: true);
                            }
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
                        title: 'Seconds',
                        hint: ticker.entryTime != null? _entrySecondsController.text : '00',
                        controller: _entrySecondsController,
                        label: ticker.entryTime != null? _entrySecondsController.text : null,
                        enabled: editMode,
                      ),
                    ),
                  ],
                ),
                //Exit Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: InputField(
                        title: 'Exit time',
                        hint: intl.DateFormat('HH:mm a')
                            .format(
                            DateTime.now().add(const Duration(minutes: 15)))
                            .toString(),
                        enabled: editMode,
                        label: exitTime,
                        widget: IconButton(
                          icon: exitTimeIcon,
                          onPressed: () {
                            if (editMode == false) {
                              Functions.editModeSnackBar();
                              return null;
                            } else if (exitTimeIcon.icon ==
                                Icons.highlight_remove_outlined) {
                              setState(() {
                                exitTime = null;
                                exitTimeIcon =
                                const Icon(Icons.access_time_outlined);
                              });
                              return;
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
                        title: 'Seconds',
                        hint: ticker.exitTime != null? _exitSecondsController.text : '00',
                        controller: _exitSecondsController,
                        label: ticker.exitTime != null? _exitSecondsController.text : null,
                        enabled: editMode,
                      ),
                    ),
                  ],
                ),
                InputField(
                  title: 'Exchange',
                  hint: 'Exchange type',
                  enabled: editMode,
                  label: _selectedExchange,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: exchangeIcon,
                      onTap: () {
                        if (editMode == false) {
                          Functions.editModeSnackBar();
                          return;
                        } else if (exchangeIcon.icon ==
                            Icons.highlight_remove_outlined) {
                          setState(() {
                            _selectedExchange = null;
                            exchangeIcon = const Icon(Icons.arrow_drop_down);
                          });
                        }
                      },
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
                              enabled: editMode,
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
                  enabled: editMode,
                  label: _selectedStrategy,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: strategyIcon,
                      onTap: () {
                        if (editMode == false) {
                          Functions.editModeSnackBar();
                        } else if (strategyIcon.icon ==
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
                        strategyIcon =
                            const Icon(Icons.highlight_remove_outlined);
                        _selectedStrategy = value.toString();
                      }),
                      items: strategiesList
                          .map(
                            (e) => DropdownMenuItem(
                              enabled: editMode,
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
                      hint: market_cap != null ? '$market_cap' : '0',
                      isNumber: true,
                      controller: _marketCapController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label: market_cap != null ? market_cap.toString() : null,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Reat',
                      hint: reat != null ? '$reat' : '0',
                      isNumber: true,
                      controller: _reatController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label: reat != null ? reat.toString() : null,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InputField(
                      title: 'Day of treda',
                      hint: day_of_treda != null ? '$day_of_treda' : '0',
                      isNumber: true,
                      controller: _dayOfTredaController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label:
                          day_of_treda != null ? day_of_treda.toString() : null,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InputField(
                      title: 'Float',
                      hint: float != null ? '$float' : '0',
                      isNumber: true,
                      controller: _floatController,
                      enabled: editMode,
                      // ignore: prefer_null_aware_operators
                      label: float != null ? float.toString() : null,
                    )),
                  ],
                ),
                InputField(
                  title: 'Broker',
                  hint: 'Broker type',
                  enabled: editMode,
                  label: _selectedBroker,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: brokerIcon,
                      onTap: () {
                        if (editMode == false) {
                          Functions.editModeSnackBar();
                          return;
                        } else if (brokerIcon.icon ==
                            Icons.highlight_remove_outlined) {
                          setState(() {
                            _selectedBroker = null;
                            brokerIcon = const Icon(Icons.arrow_drop_down);
                          });
                        }
                      },
                      underline: Container(
                        height: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (value) => setState(() {
                        _selectedBroker = value.toString();
                        brokerIcon = const Icon(Icons.highlight_remove_outlined);
                      }),
                      items: brokersList
                          .map(
                            (e) => DropdownMenuItem(
                              enabled: editMode,
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
                  enabled: editMode,
                  label: _selectedAccount,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: accountIcon,
                      onTap: () {
                        if (editMode == false) {
                          Functions.editModeSnackBar();
                          return;
                        } else if (accountIcon.icon ==
                            Icons.highlight_remove_outlined) {
                          setState(() {
                            _selectedAccount = null;
                            accountIcon = const Icon(Icons.arrow_drop_down);
                          });
                        }
                      },
                      underline: Container(
                        height: 0,
                      ),
                      style: subTitleStyle,
                      onChanged: (value) => setState(() {
                        _selectedAccount = value.toString();
                        accountIcon = const Icon(Icons.highlight_remove_outlined);
                      }),
                      items: accountsList
                          .map(
                            (e) => DropdownMenuItem(
                              enabled: editMode,
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
                  title: 'Position',
                  hint: '0.0',
                  enabled: false,
                  label: calcPosition().toStringAsFixed(3),
                  clickAble: false,
                ),
                InputField(
                  title: 'Risk',
                  hint: '0.0',
                  enabled: false,
                  label: calcRisk().toStringAsFixed(3),
                  clickAble: false,
                ),
                InputField(
                  title: 'Reword',
                  hint: '0.0',
                  enabled: false,
                  label: calcReword().toStringAsFixed(3),
                  clickAble: false,
                ),
                InputField(
                  title: 'Reword/Risk',
                  hint: '0.0',
                  enabled: false,
                  label: calcRewordOnRisk().toStringAsFixed(3),
                  clickAble: false,
                ),
                InputField(
                  title: 'Active minutes',
                  hint: '0',
                  enabled: false,
                  label: calcActiveMinutes(),
                  clickAble: false,
                ),
                InputField(
                  title: 'P/L',
                  hint: '0.0',
                  enabled: false,
                  label: calcProfitOnLose() != null ? calcProfitOnLose()!.toStringAsFixed(3) : '0.0',
                  clickAble: false,
                ),
                InputField(
                  title: 'Net P/L',
                  hint: '0.0',
                  enabled: false,
                  label: calcNetProfitOnLose() != null ? calcNetProfitOnLose()!.toStringAsFixed(3) : '0.0',
                  clickAble: false,
                ),
                InputField(
                  title: 'P/L%',
                  hint: '0.0',
                  enabled: false,
                  label: calcProfitOrLosePercentage() != null? calcProfitOrLosePercentage()!.toStringAsFixed(3) + '%' : '0.0%',
                  clickAble: false,
                ),
                InputField(
                  title: 'Entry comment',
                  hint: 'Why did you enter this trade',
                  controller: _entryCommentController,
                  enabled: editMode,
                  label: entryComment,
                  maxLines: 6,
                ),
                InputField(
                  title: 'Exit comment',
                  hint: 'Why did you leave this trade',
                  controller: _exitCommentController,
                  enabled: editMode,
                  label: exitComment,
                  maxLines: 6,
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    AddTickerButton(
                      label: 'Save edits',
                      onTap: () => addUpdatedTickerToDb(),
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

  double calcPosition(){
    if(entryPrice != null && quantity != null) {
      return (entryPrice! * quantity!);
    }
    return 0.0;
  }

  double calcRisk(){
    if(entryPrice != null && stop != null && quantity != null){
      //if(ticker.operation == Operation.short)
      //return ((stop! - entryPrice!) * quantity!);
      //else
        return ((entryPrice! - stop!) * quantity!);
    }
    return 0.0;
  }

  double calcReword(){
    if(entryPrice != null && target != null && quantity != null){
      //if(ticker.operation == Operation.short)
      //return ((entryPrice! - target!) * quantity!);
      //else
        return ((target! - entryPrice!) * quantity!);
    }
    return 0.0;
  }

  double calcRewordOnRisk(){
    if(calcRisk() != 0){
      return calcReword() / calcRisk();
    }
    else {
      return 0.0;
    }
  }

   String calcActiveMinutes(){
    var list1 = ticker.entryTime != null? ticker.entryTime!.split(':') : null;
    var list2 = ticker.exitTime != null? ticker.exitTime!.split(':') : null;
    DateTime? enDate = ticker.entryDate != null ? DateTime.parse(ticker.entryDate!) : null;
    DateTime? exDate = ticker.exitDate != null ? DateTime.parse(ticker.exitDate!) : null;


    if(enDate != null && exDate != null && list1 != null && list2 != null){
      var res = intl.DateFormat().dateTimeConstructor(exDate.year, exDate.month, exDate.day, int.parse(list2[0]), int.parse(list2[1]), int.parse(list2[2]), 0, false)
          .difference(intl.DateFormat().dateTimeConstructor(enDate.year, enDate.month, enDate.day, int.parse(list1[0]), int.parse(list1[1]), int.parse(list1[2]), 0, false)).inSeconds;
      if((res/60).toString().contains('.'))
      return "${(res/60).toString().split('.')[0]} minute, ${res % 60} second";
      else
        return "${(res-res%60) / 60} minute, ${res % 60} second";
    }
    //exDate.year, exDate.month, exDate.day, int.parse(list2[0]), int.parse(list2[1]), 0, 0, false
    else{
      return '0 minute, 0 second';
    }
  }

  double? calcProfitOnLose(){
    if(_entryPriceController.text.isNotEmpty && _exitPriceController.text.isNotEmpty &&  _quantityController.text.isNotEmpty){
      return (((double.tryParse(_exitPriceController.text) ?? 0) - (double.tryParse(_entryPriceController.text) ?? 0)) * (int.tryParse(_quantityController.text) ?? 0));
    }
    return null;
  }

  double? calcNetProfitOnLose(){
    if(commission != null && calcProfitOnLose()!=null){
      return calcProfitOnLose()! - commission!;
    }
    else
      return null;
  }

  double? calcProfitOrLosePercentage(){
    if(calcPosition() != 0.0 && calcNetProfitOnLose() != null){
      return (calcNetProfitOnLose()! / calcPosition()*100);
    }
    return null;
  }

  showSnackBar(){
    Get.snackbar('Warning!','Entry Date Must Be Before Exit Date',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode? Colors.white : Colors.black,
      snackStyle: SnackStyle.FLOATING,
      colorText: Colors.pink,
      icon: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.red,
      ),
    );
  }

  bool compareEntryAndExitDates(){
    if(entryDate != null && exitDate != null){
      if(exitDate!.difference(entryDate!).inDays >=0 ) {
        return true;
      } else {
        return false;
      }
    }
    else{
      return true;
    }
  }

  /*updateTicker() {
    if(compareEntryAndExitDates() == false){
      showSnackBar();
    }
    else if (_nameController.text.isNotEmpty) {
      addUpdatedTickerToDb();
      Get.back();
    } else {
      Get.snackbar(
        'Required',
        'Name field is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        snackStyle: SnackStyle.FLOATING,
        colorText: Colors.pink,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }
*/
  addUpdatedTickerToDb() async {
    if (isAllDataValid()) {
      print(entryTime);
      await TickerController.updateTicker(Ticker(
        id: ticker.id,
        name: _nameController.text,
        color: calcNetProfitOnLose() != null? calcNetProfitOnLose()! > 0? 0 : calcNetProfitOnLose() == 0? 2 : 1 : 2,
        quantity: _quantityController.text.isNotEmpty
            ? int.parse(_quantityController.text)
            : null,
        entryPrice: _entryPriceController.text.isNotEmpty
            ? double.parse(_entryPriceController.text)
            : null,
        exitPrice: _exitPriceController.text.isNotEmpty
            ? double.parse(_exitPriceController.text)
            : null,
        entryDate: entryDate!=null? entryDate.toString() : null,
        exitDate: exitDate!=null? exitDate.toString() : null,
        entryTime: entryTime,
        exitTime: exitTime,
        entryComment: _entryCommentController.text.isEmpty
            ? null
            : _entryCommentController.text,
        exitComment: _exitCommentController.text.isEmpty
            ? null
            : _exitCommentController.text,
        exchange: getStringToExchange,
        //operation: getStringOperation,
        strategy: getStringStrategy,
        broker: getStringToBroker,
        account: getStringToAccount,
        reat: _reatController.text.isNotEmpty
            ? int.parse(_reatController.text)
            : null,
        market_cap: _marketCapController.text.isNotEmpty
            ? int.parse(_marketCapController.text)
            : null,
        float: _floatController.text.isNotEmpty
            ? int.parse(_floatController.text)
            : null,
        day_of_treda: _dayOfTredaController.text.isNotEmpty
            ? int.parse(_dayOfTredaController.text)
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
      Get.back();
    } else
      print('Invalid data');
  }

  /*bool doesDataChanged() {
    if (_nameController.text != ticker.name) {
      return true;
    }
    if (_quantityController.text != ticker.quantity.toString()) {
      return true;
    }
    if (_selectedColor != ticker.color) {
      return true;
    }
    if (_entryPriceController.text != ticker.entryPrice.toString()) {
      return true;
    }
    if (_exitPriceController.text != ticker.exitPrice.toString()) {
      return true;
    }
    if (entryTime != ticker.entryTime) {
      return true;
    }
    if (exitTime != ticker.exitTime) {
      return true;
    }
    if (entryDate != ticker.entryDate) {
      return true;
    }
    if (exitDate != ticker.exitDate) {
      return true;
    }
    if (_entryCommentController.text != ticker.entryComment) {
      return true;
    }
    if (_exitCommentController.text != ticker.exitComment) {
      return true;
    }
    if (_reatController.text != ticker.reat.toString()) {
      return true;
    }
    if (_dayOfTredaController.text != ticker.day_of_treda.toString()) {
      return true;
    }
    if (_marketCapController.text != ticker.market_cap.toString()) {
      return true;
    }
    if (_floatController.text != ticker.float.toString()) {
      return true;
    }
    if (_selectedExchange != getExchangeToString(ticker.exchange)) {
      return true;
    }
    if (_selectedOperation != getOperationToString(ticker.operation)) {
      return true;
    }
    if (_selectedStrategy != getStrategyToString(ticker.strategy)) {
      return true;
    }
    if (_selectedBroker != getBrokerToString(ticker.broker)) {
      return true;
    }
    if (_selectedAccount != getAccountToString(ticker.account)) {
      return true;
    }
    if (_targetController.text != ticker.target.toString()) {
      return true;
    }
    if (_stopController.text != ticker.stop.toString()) {
      return true;
    }
    if (_capitalController.text != ticker.capital.toString()) {
      return true;
    }
    if (_commissionController.text != ticker.commission.toString()) {
      return true;
    }
    return false;
  }*/

  Broker? get getStringToBroker {
    if (_selectedBroker == 'Interactive Broker') {
      return Broker.interactiveBroker;
    } else if (_selectedBroker == 'Td Amer Trade') {
      return Broker.tdAmerTrade;
    } else if (_selectedBroker == 'Trader Zero') {
      return Broker.traderZero;
    }
    return null;
  }

  Account? get getStringToAccount {
    if (_selectedAccount == 'Demo Account') {
      return Account.demoAccount;
    } else if (_selectedAccount == 'Real Account') {
      return Account.realAccount;
    }
    return null;
  }

  Exchange? get getStringToExchange {
    if (_selectedExchange == 'NASDAQ') {
      return Exchange.nasdaq;
    } else if (_selectedExchange == 'NYCE') {
      return Exchange.nyce;
    } else {
      return null;
    }
  }

  Operation? get getStringOperation {
    return _selectedOperation == 'Long'
        ? Operation.long
        : _selectedOperation == 'Short'
            ? Operation.short
            : null;
  }

  Strategy? get getStringStrategy {
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
        actions: [
          IconButton(
              onPressed: () => setState(() {
                    editMode = !editMode;
                  }),
              icon: AnimationConfiguration.synchronized(
                child: FadeInAnimation(
                  curve: Curves.easeInCirc,
                  duration: const Duration(seconds: 1),
                  child: Icon(
                    editMode == true ? Icons.edit_off : Icons.edit,
                    size: 24,
                    //color: Get.isDarkMode ? Colors.white : darkGreyClr,
                    color: Colors.blue,
                  ),
                ),
              ))
        ],
        backgroundColor: context.theme.backgroundColor);
  }

  pickDate({bool isEntry = false}) async {
    DateTime? _pickDate = await showDatePicker(
        context: context,
        initialDate: isEntry
            ? DateTime.now()
            : DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime(2017),
        lastDate: DateTime(2099));
    setState(() {
      if (_pickDate != null) {
        if (isEntry) {
          entryDate = _pickDate.toLocal();
          entryDateIcon = const Icon(Icons.highlight_remove_outlined);
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
          if(_pickTime.hour<10)
            entryTime = '0';
          entryTime = entryTime! + _pickTime.hour.toString() + ':';
          if(_pickTime.minute<10)
            entryTime = entryTime! + '0';
          entryTime = entryTime! + _pickTime.minute.toString();
          startTimeIcon = const Icon(Icons.highlight_remove_outlined);
        } else {
          //exitTime = _pickTime.hour.toString() + ':' + _pickTime.minute.toString();
          exitTime = '';
          if(_pickTime.hour<10)
            exitTime = '0';
          exitTime = exitTime! + _pickTime.hour.toString() + ':';
          if(_pickTime.minute<10)
            exitTime = exitTime! + '0';
          exitTime = exitTime! + _pickTime.minute.toString();
          exitTimeIcon = const Icon(Icons.highlight_remove_outlined);
        }
      });
    }
  }


  String? getExchangeToString(Exchange? e) {
    if (e == Exchange.nasdaq) {
      return 'NAZDAQ';
    } else if (e == Exchange.nyce) {
      return 'NYCE';
    }
    return null;
  }

  /*String? getOperationToString(Operation? e) {
    if (e == Operation.short) {
      return 'Short';
    } else if (e == Operation.long) {
      return 'Long';
    }
    return null;
  }*/

  String? getStrategyToString(Strategy? e) {
    if (e == Strategy.day_2Runner) {
      return "Day 2Runner";
    } else if (e == Strategy.day_3Runner) {
      return 'Day 3Runner';
    } else if (e == Strategy.day_4Runner) {
      return 'Day 4Runner';
    } else if (e == Strategy.midDayLowFloatRunner) {
      return 'Mid-Day Low Float Runner';
    } else if (e == Strategy.multiDayBreakout) {
      return 'Pre-Market Breakout';
    } else if (e == Strategy.hotSector) {
      return 'Hot Sector';
    } else if (e == Strategy.preMarketBreakout) {
      return 'Pre-Market Breakout';
    } else if (e == Strategy.reverseSplit) {
      return 'Reverse Split';
    }
    return null;
  }

  String? getBrokerToString(Broker? e) {
    if (e == Broker.traderZero) {
      return 'Trader Zero';
    } else if (e == Broker.tdAmerTrade) {
      return 'Td Amer Trade';
    } else if (e == Broker.interactiveBroker) {
      return 'Interactive Broker';
    }
    return null;
  }

  String? getAccountToString(Account? e) {
    if (e == Account.demoAccount) {
      return 'Demo Account';
    } else if (e == Account.realAccount) {
      return 'Real Account';
    }
    return null;
  }

  resetDefaultTickerData() {
    name = ticker.name;
    quantity = ticker.quantity;
    entryPrice = ticker.entryPrice;
    exitPrice = ticker.exitPrice;
    entryDate = ticker.entryDate!=null? DateTime.parse(ticker.entryDate!) : null;
    exitDate = ticker.exitDate!=null? DateTime.parse(ticker.exitDate!) : null;
    entryTime = ticker.entryTime != null? ticker.entryTime!.split(':')[0] + ':' + ticker.entryTime!.split(':')[1] : null;
    exitTime = ticker.exitTime != null? ticker.exitTime!.split(':')[0] + ':' + ticker.exitTime!.split(':')[1] : null;
    entryComment = ticker.entryComment;
    exitComment = ticker.exitComment;
    day_of_treda = ticker.day_of_treda;
    reat = ticker.reat;
    market_cap = ticker.market_cap;
    float = ticker.float;
    target = ticker.target;
    stop = ticker.stop;
    capital = ticker.capital;
    commission = ticker.commission;
    _selectedExchange = getExchangeToString(ticker.exchange);
    //_selectedOperation = getOperationToString(ticker.operation);
    _selectedStrategy = getStrategyToString(ticker.strategy);
    _selectedBroker = getBrokerToString(ticker.broker);
    _selectedAccount = getAccountToString(ticker.account);
    //_selectedColor = calcProfitOnLose() != null? calcProfitOnLose()!>0? 0 : calcProfitOnLose()! == 0? 2 : 1 : 1;
    _nameController.text = ticker.name;
    if (ticker.quantity != null) {
      _quantityController.text = ticker.quantity.toString();
    }
    if (ticker.entryPrice != null) {
      _entryPriceController.text = ticker.entryPrice.toString();
    }
    if (ticker.exitPrice != null) {
      _exitPriceController.text = ticker.exitPrice.toString();
    }
    if (ticker.entryComment != null) {
      _entryCommentController.text = ticker.entryComment!;
    }
    if (ticker.exitComment != null) {
      _exitCommentController.text = ticker.exitComment!;
    }
    if (ticker.day_of_treda != null) {
      _dayOfTredaController.text = ticker.day_of_treda.toString();
    }
    if (ticker.float != null) {
      _floatController.text = ticker.float.toString();
    }
    if (ticker.reat != null) {
      _reatController.text = ticker.reat.toString();
    }
    if (ticker.market_cap != null) {
      _marketCapController.text = ticker.market_cap.toString();
    }
    if (ticker.target != null) {
      _targetController.text = ticker.target.toString();
    }
    if (ticker.stop != null) {
      _stopController.text = ticker.stop.toString();
    }
    if (ticker.capital != null) {
      _capitalController.text = ticker.capital.toString();
    }
    if (ticker.commission != null) {
      _commissionController.text = ticker.commission.toString();
    }

    if(ticker.entryTime != null){
      try{
        _entrySecondsController.text = ticker.entryTime!.split(':')[2];
      }catch(e){

      }
    }

    if(ticker.exitTime != null){
      try{
        _exitSecondsController.text = ticker.exitTime!.split(':')[2];
      }catch(e){

      }
    }

    entryDateIcon = entryDate == null
        ? const Icon(Icons.calendar_today_outlined)
        : const Icon(Icons.highlight_remove_outlined);
    exitDateIcon = exitDate == null
        ? const Icon(Icons.calendar_today_outlined)
        : const Icon(Icons.highlight_remove_outlined);
    startTimeIcon = entryTime == null
        ? const Icon(Icons.access_time_outlined)
        : const Icon(Icons.highlight_remove_outlined);
    exitTimeIcon = exitTime == null
        ? const Icon(Icons.access_time_outlined)
        : const Icon(Icons.highlight_remove_outlined);
    exchangeIcon = _selectedExchange == null
        ? const Icon(Icons.arrow_drop_down)
        : const Icon(Icons.highlight_remove_outlined);
    operationIcon = _selectedOperation == null
        ? const Icon(Icons.arrow_drop_down)
        : const Icon(Icons.highlight_remove_outlined);
    strategyIcon = _selectedStrategy == null
        ? const Icon(Icons.arrow_drop_down)
        : const Icon(Icons.highlight_remove_outlined);
    brokerIcon = _selectedBroker == null
        ? const Icon(Icons.arrow_drop_down)
        : const Icon(Icons.highlight_remove_outlined);
    accountIcon = _selectedAccount == null
        ? const Icon(Icons.arrow_drop_down)
        : const Icon(Icons.highlight_remove_outlined);
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
      else if(_exitSecondsController.text.isEmpty){
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

  int areTwoValidDigits(text){
    return int.tryParse(text)??-1;
  }
}
