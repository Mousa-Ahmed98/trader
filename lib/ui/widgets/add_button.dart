import 'package:flutter/material.dart';

import 'theme.dart';

class AddTickerButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const AddTickerButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryClr,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: onTap,
    );
  }
}
