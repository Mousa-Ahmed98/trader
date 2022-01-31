import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticker/ui/widgets/theme.dart';

import 'ticker.dart';

class Functions{
  static editModeSnackBar() {
    Get.closeAllSnackbars();
    Get.snackbar(
        'Unlock Edit Mode',
        'Press the blue icon to unlock edit mode',
        colorText: Get.isDarkMode ? Colors.white : darkGreyClr,
        isDismissible: true,
        messageText: Row(
          children: const [
            Text('Press the blue icon '),
            Icon(Icons.edit_sharp, size: 16, color: Colors.blue,),
            Text(' to unlock edit mode'),
          ],
        )
    );
  }

  static invalidSeconds(){
    Get.snackbar(
      'Warning!',
      'invalid second\'s format',
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
  static nameFieldIsRequired(){
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
  static invalidData(String message){
    Get.snackbar(
      'Required',
      message,
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

  static selectTimeFirst(){
    Get.snackbar(
      'Required',
      'Choose the entry time before seconds',
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

  static dateOrderingError() {
    Get.snackbar(
      'Warning!',
      'Exit Date Must Not Be Before Entry Date',
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