// ignore_for_file: void_checks, curly_braces_in_flow_control_structures, avoid_returning_null_for_void, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ticker/controllers/ticker_controller.dart';
import 'package:ticker/models/ticker.dart';
import 'package:ticker/ui/widgets/input_field.dart';
import 'package:ticker/ui/widgets/single_ticker.dart';
import 'package:ticker/ui/widgets/theme.dart';

import '../size_config.dart';
import 'ticker_details_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  DateTime? from;
  DateTime? to;
  Icon fromDateIcon = const Icon(Icons.calendar_today_outlined);
  Icon toDateIcon = const Icon(Icons.calendar_today_outlined);
  double maxHeight = 0;
  int selectedMode = 3;
  @override
  Widget build(BuildContext context) {
    print('set state haas been called');
    maxHeight = MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top-_appBar().preferredSize.height;
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: SlidingUpPanel(
        color: context.theme.backgroundColor,
        minHeight: maxHeight*.05,
        maxHeight: maxHeight*.7,
        parallaxEnabled: true,
        parallaxOffset: .5,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        body: getFilteredTrades(),
        panelBuilder: (sc) => buildPanel(sc),
        onPanelClosed: _refreshTickerList,
      ),
    );
  }

  Widget buildPanel(ScrollController scrollController){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.all(constraints.maxHeight*.02),
          child: ListView(
            padding: EdgeInsets.zero,
            controller: scrollController,
            children: [
              SizedBox(height: constraints.maxHeight*.01,),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: constraints.maxHeight*.02,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10
                      )
                    ),
                  ),
                ),
              ),
              SizedBox(height: constraints.maxHeight*.05,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InputField(
                      title: 'From',
                      hint: DateFormat.yMMMd()
                          .format(DateTime.now())
                          .toString(),
                      label: from != null
                          ? DateFormat.yMMMd().format(from!).toString()
                          : null,
                      widget: IconButton(
                        icon: fromDateIcon,
                        onPressed: () {
                          if (fromDateIcon.icon ==
                              Icons.highlight_remove_outlined) {
                            setState(() {
                              from = null;
                              fromDateIcon =
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
                      title: 'To',
                      hint: DateFormat.yMMMd()
                          .format(
                          DateTime.now().add(const Duration(minutes: 15)))
                          .toString(),
                      label: to != null
                          ? DateFormat.yMMMd().format(to!).toString()
                          : null,
                      widget: IconButton(
                        icon: toDateIcon,
                        onPressed: () {
                          if (toDateIcon.icon ==
                              Icons.highlight_remove_outlined) {
                            setState(() {
                              to = null;
                              toDateIcon =
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
              SizedBox(height: constraints.maxHeight*.07,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Mode', style: titleStyle,),
                  SizedBox(height: constraints.maxHeight*.02,),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedMode = 1;
                            });
                          },
                          child: Container(
                            height: constraints.maxHeight*.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              color: selectedMode == 1? Get.isDarkMode? Colors.white : darkGreyClr : context.theme.backgroundColor,
                            ),
                            child: Center(child: FittedBox(
                              child: Text('Only wins', style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green,
                                  //color: Colors.blue,
                                ),
                              ),),
                            ),),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedMode = 2;
                            });
                          },
                          child: Container(
                            height: constraints.maxHeight*.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectedMode == 2? Get.isDarkMode? Colors.white : darkGreyClr : context.theme.backgroundColor,
                            ),
                            child: Center(child: FittedBox(
                              child: Text('Only loses', style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red
                                  //color: Colors.blue,
                                ),
                              ),),
                            ),),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedMode = 3;
                            });
                          },
                          child: Container(
                            height: constraints.maxHeight*.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectedMode == 3? Get.isDarkMode? Colors.white : darkGreyClr : context.theme.backgroundColor,
                            ),
                            child: Center(child: FittedBox(
                              child: Text('Default', style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: selectedMode == 3? Get.isDarkMode? darkGreyClr : Colors.white : Get.isDarkMode? Colors.white : darkGreyClr,
                                  //color: Colors.blue,
                                ),
                              ),),
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight*.02,),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedMode = 4;
                            });
                          },
                          child: Container(
                            height: constraints.maxHeight*.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: selectedMode == 4? Get.isDarkMode? Colors.white : darkGreyClr : context.theme.backgroundColor,
                            ),
                            child: Center(child: FittedBox(
                              child: Text('Only incomplete', style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.orange,
                                  //color: Colors.blue,
                                ),
                              ),),
                            ),),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> _refreshTickerList() async {
    print('$selectedMode');
    TickerController.getAllTickers();
  }

  Widget getFilteredTrades(){
     return Container(
       margin: EdgeInsets.only(bottom: maxHeight * .17, top: maxHeight * .02),
       child: ListView.builder(
         itemCount: TickerController.tickerList.length,
         itemBuilder: (context, index) {
           Ticker t = (TickerController.tickerList[index] as Ticker);
           return getSingleTicker(t, index);
         },
       ),
     );
  }

  Widget getSingleTicker(Ticker ticker, int index) {
      final startDate =  ticker.entryDate != null ? DateTime.parse(ticker.entryDate!) : null;
      if(from != null && to != null){
        if(startDate != null && startDate.difference(from!).inDays >= 0 && to!.difference(startDate).inDays >= 0
        && selectedMode == 3)
          return buildListViewItem(index);
        else if(startDate != null && startDate.difference(from!).inDays >= 0 && to!.difference(startDate).inDays >= 0
            && selectedMode == 2 && winnerOrLoser(ticker) == false)
          return buildListViewItem(index);
        else if(startDate != null && startDate.difference(from!).inDays >= 0 && to!.difference(startDate).inDays >= 0
            && selectedMode == 1 && winnerOrLoser(ticker) == true)
          return buildListViewItem(index);
        else if(startDate != null && startDate.difference(from!).inDays >= 0 && to!.difference(startDate).inDays >= 0
            && selectedMode == 4 && winnerOrLoser(ticker) == null)
          return buildListViewItem(index);
        else
          return Container();
      }
      else if(from != null){
        if(startDate != null && startDate.difference(from!).inDays >= 0
            && selectedMode == 3)
          return buildListViewItem(index);
        else if(startDate != null && startDate.difference(from!).inDays >= 0
            && selectedMode == 2 && winnerOrLoser(ticker) == false)
          return buildListViewItem(index);
        else if(startDate != null && startDate.difference(from!).inDays >= 0
            && selectedMode == 1 && winnerOrLoser(ticker) == true)
          return buildListViewItem(index);
        else if(startDate != null && startDate.difference(from!).inDays >= 0
            && selectedMode == 4 && winnerOrLoser(ticker) == null)
          return buildListViewItem(index);
        else
          return Container();
      }
      else if( to != null){
        if(startDate != null && to!.difference(startDate).inDays >= 0
            && selectedMode == 3)
          return buildListViewItem(index);
        else if(startDate != null && to!.difference(startDate).inDays >= 0
            && selectedMode == 2 && winnerOrLoser(ticker) == false)
          return buildListViewItem(index);
        else if(startDate != null && to!.difference(startDate).inDays >= 0
            && selectedMode == 1 && winnerOrLoser(ticker) == true)
          return buildListViewItem(index);
        else if(startDate != null && to!.difference(startDate).inDays >= 0
            && selectedMode == 4 && winnerOrLoser(ticker) == null)
          return buildListViewItem(index);
        else
          return Container();
      }
      else{
        if(selectedMode == 3)
          return buildListViewItem(index);
        else if(selectedMode == 2 && winnerOrLoser(ticker) == false)
          return buildListViewItem(index);
        else if(selectedMode == 1 && winnerOrLoser(ticker) == true)
          return buildListViewItem(index);
        else if(selectedMode == 4 && winnerOrLoser(ticker) == null)
          return buildListViewItem(index);
        else
          return Container();
      }

  }

  SizedBox buildListViewItem(int index) {
    return SizedBox(
              height:SizeConfig.screenHeight>600? maxHeight * .17 : maxHeight * .23,
              child: AnimationConfiguration.staggeredList(
                position: index,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 300),
                  child: InkWell(
                    onTap: () => Get.to(
                            () => TickerDetailsScreen(
                          ticker: TickerController
                              .tickerList[index],
                        ))
                        ?.then((value) => _refreshTickerList()),
                    child: SizedBox(
                      child: SingleTicker(
                        ticker:
                        TickerController.tickerList[index],
                        maxHeight: SizeConfig.screenHeight>600? maxHeight * .17 : maxHeight * .23,
                      ),
                    ),
                  ),
                ),
              ),
            );
  }

  AppBar _appBar(){
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      title: const Text('Filter'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Get.isDarkMode? Colors.white : Colors.black,),
        onPressed: () => Get.back(),
      ),
    );
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
          from = _pickDate.toLocal();
          fromDateIcon = const Icon(Icons.highlight_remove_outlined);
        } else {
          to = _pickDate.toLocal();
          toDateIcon = const Icon(Icons.highlight_remove_outlined);
        }
      }
    });
  }

  double? calcProfitOnLose(Ticker ticker){
    if(ticker.entryPrice != null && ticker.exitPrice != null &&  ticker.quantity != null){
      return ((ticker.exitPrice! - ticker.entryPrice!) * ticker.quantity!);
    }
    return null;
  }

  bool? winnerOrLoser(Ticker ticker){
    if(ticker.commission != null && calcProfitOnLose(ticker)!=null){
      return (calcProfitOnLose(ticker)! - ticker.commission!)>0;
    }
    else
      return null;
  }
}
