import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ticker/providers/date_provider.dart';
import 'package:ticker/ui/widgets/theme.dart';
import 'package:intl/src/intl/date_format.dart' as date_format;

class DateBar extends StatefulWidget {

  final bool isSelectAll;

  const DateBar({Key? key, required this.isSelectAll,}) : super(key: key);
  @override
  _DateBarState createState() => _DateBarState();
}

class _DateBarState extends State<DateBar> {
  // ignore: prefer_final_fields
  DateTime _selectedDate = DateTime.now();



  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context, listen: false);
    return
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              margin: EdgeInsets.only(left: 20, top: constraints.maxHeight*.1),
              child: DatePicker(
                //DateTime(2021, 12, 23),
                DateTime.now().subtract(const Duration(days: 5)),
                initialSelectedDate: _selectedDate,
                width: 70,
                height: constraints.maxHeight*.9,
                //daysCount: DateTime.now().difference(DateTime(2021, 12, 23)).inDays+365,
                daysCount: 10,
                selectionColor: widget.isSelectAll? (!Get.isDarkMode? Colors.white : darkGreyClr) : (Get.isDarkMode? Colors.white : darkGreyClr),
                selectedTextColor: Colors.blue,
                onDateChange: (selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                    dateProvider.setSelectedDate(date_format.DateFormat.yMMMd().format(selectedDate).toString());
                  });
                },
                dateTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                dayTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }
        );
  }
}
