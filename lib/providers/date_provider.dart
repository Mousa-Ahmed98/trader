import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DateProvider with ChangeNotifier{
   String selectedDate = DateFormat.yMMMd().format(DateTime.now()).toString();
   bool isSelectedAll = true;

   setSelectedDate(String date){
    selectedDate = date;
    isSelectedAll = false;
    notifyListeners();
  }
}