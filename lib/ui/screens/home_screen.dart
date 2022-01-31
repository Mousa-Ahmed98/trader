// ignore_for_file: avoid_print, empty_catches, curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ticker/controllers/ticker_controller.dart';
import 'package:ticker/models/ticker.dart';
import 'package:ticker/providers/date_provider.dart';
import 'package:ticker/services/theme_services.dart';
import 'package:ticker/ui/size_config.dart';
import 'package:ticker/ui/widgets/add_button.dart';
import 'package:ticker/ui/widgets/date_bar.dart';
import 'package:ticker/ui/widgets/single_ticker.dart';
import 'package:ticker/ui/widgets/theme.dart';
import 'add_ticker_screen.dart';
import 'filters_screen.dart';
import 'ticker_details_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final TickerController _tickerController = TickerController();
  bool isSelectedAll = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    TickerController.getAllTickers();
    if (TickerController.tickerList.isEmpty) print('empty tickerlist');
    return Consumer<DateProvider>(builder: (context, value, child) {
        isSelectedAll = value.isSelectedAll;
        var _height = MediaQuery.of(context).size.height -
            _appBar(context).preferredSize.height -
            MediaQuery.of(context).padding.top;

        return Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: _appBar(context),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: _height * .09,
                    child: _taskBar(),
                  ),
                  SizedBox(
                    height: .16 * _height,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        children: [
                          Container(
                            width: 70,
                            height: constraints.maxHeight * .87,
                            margin: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: isSelectedAll
                                  ? primaryClr
                                  : context.theme.backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              child: const Center(
                                  child: FittedBox(
                                child: Text(
                                  'All',
                                  style: TextStyle(fontSize: 14),
                                ),
                              )),
                              onTap: () {
                                setState(() {
                                  //isSelectedAll = !isSelectedAll;
                                  value.isSelectedAll = true;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: constraints.maxHeight,
                              child: DateBar(
                                isSelectAll: isSelectedAll,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(
                    height: _height * .75,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Obx(() {
                        if (TickerController.tickerList.isEmpty) {
                          print('empty');
                          return const Center(child: Text('No data was found, add now!'),);
                        } else if (isSelectedAll) {
                          return RefreshIndicator(
                            onRefresh: () => _refreshTickerList(),
                            child: ListView.builder(
                              itemCount: TickerController.tickerList.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height:SizeConfig.screenHeight>600? constraints.maxHeight * .23 : constraints.maxHeight * .3,
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
                                            maxHeight:
                                            SizeConfig.screenHeight>600? constraints.maxHeight * .23 : constraints.maxHeight * .3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return RefreshIndicator(
                            onRefresh: () => _refreshTickerList(),
                            child: ListView.builder(
                              itemCount: TickerController.tickerList.length,
                              itemBuilder: (context, index) {
                                var selectedDate =
                                    Provider.of<DateProvider>(context, listen: true)
                                        .selectedDate;
                                DateTime? enDate =
                                    (TickerController.tickerList[index] as Ticker)
                                                .entryDate !=
                                            null
                                        ? DateTime.parse((TickerController
                                                .tickerList[index] as Ticker)
                                            .entryDate!)
                                        : null;
                                if (enDate == null ||
                                    DateFormat.yMMMd().format(enDate) !=
                                        selectedDate) {
                                  return Container();
                                }

                                return SizedBox(
                                  height:SizeConfig.screenHeight>600? constraints.maxHeight * .23 : constraints.maxHeight * .3,
                                  child: AnimationConfiguration.staggeredList(
                                      position: index,
                                      child: FadeInAnimation(
                                        duration: const Duration(milliseconds: 300),
                                        child: InkWell(
                                          onTap: () => Get.to(
                                              () => TickerDetailsScreen(
                                                    ticker: TickerController
                                                        .tickerList[index],
                                                  ))?.then(
                                              (value) => _refreshTickerList()),
                                          child: SingleTicker(
                                              ticker: TickerController
                                                  .tickerList[index],
                                              maxHeight:
                                              SizeConfig.screenHeight>600? constraints.maxHeight * .23 : constraints.maxHeight * .3),
                                        ),
                                      )),
                                );
                              },
                            ),
                          );
                        }
                      });
                    }),
                  ),
                  // SingleTicker(ticker: Ticker(color: 1, name: 'kkk', ), maxHeight: _height*.16*.23),
                  // SingleTicker(ticker: Ticker(color: 1, name: 'kkk', ), maxHeight: _height*.16*.23),
                  // SingleTicker(ticker: Ticker(color: 1, name: 'kkk', ), maxHeight: _height*.16*.23),
                  // SingleTicker(ticker: Ticker(color: 1, name: 'kkk', ), maxHeight: _height*.16*.23),
                  // SingleTicker(ticker: Ticker(color: 1, name: 'kkk', ), maxHeight: _height*.16*.23),
                  // SingleTicker(ticker: Ticker(color: 1, name: 'kkk', ), maxHeight: _height*.16*.23),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Get.isDarkMode
            ? Icons.wb_sunny_outlined
            : Icons.nightlight_round_outlined),
        iconSize: 24,
        onPressed: () {
          ThemeServices().switchTheme();
        },
        color: Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.filter_list_outlined,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
          onPressed: () => Get.to(() => const FilterScreen()),
          iconSize: 24,
        ),
      ],
    );
  }

  Future<void> _refreshTickerList() async {
    TickerController.getAllTickers();
  }

  LayoutBuilder _taskBar() {
    return LayoutBuilder(
        builder: (context, constraints) => Padding(
              padding: EdgeInsets.only(
                  left: 20, right: 10, top: constraints.maxHeight * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * .4,
                        child: FittedBox(
                          child: Text(
                            DateFormat.yMMMMd()
                                .format(DateTime.now())
                                .toString(),
                            style: subHeadingStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .55,
                        child: FittedBox(
                          child: Text(
                            'Today',
                            style: headingStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .75,
                    child: AddTickerButton(
                        label: '+ Add Trade',
                        onTap: () {
                          Get.to(() => const AddTickerScreen())
                              ?.then((value) => _refreshTickerList());
                        }),
                  )
                ],
              ),
            ));
  }

}
