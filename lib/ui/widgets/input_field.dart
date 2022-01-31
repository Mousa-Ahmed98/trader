import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticker/models/funs.dart';
import 'package:ticker/ui/size_config.dart';
import 'package:ticker/ui/widgets/theme.dart';

class InputField extends StatefulWidget {
   InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.isNumber = false,
    this.label,
    this.isCapital = false,
    this.enabled = true,
    this.clickAble = true,
    this.maxLines,
  }) : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool? isNumber;
  String? label;
  final bool? isCapital;
  final bool enabled;
  final bool clickAble;
  final int? maxLines;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: titleStyle,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 14,
              right: widget.maxLines!=null? 14 : 0,
            ),
            margin: const EdgeInsets.only(top: 4),
            width: SizeConfig.screenWidth,
            height: widget.maxLines!=null? 120 : 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    focusColor: Get.isDarkMode? darkGreyClr : Colors.white,
                    onTap: (){
                      if(widget.clickAble == false){
                        return;
                      }
                      widget.enabled == false? Functions.editModeSnackBar() : {};
                    },
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          widget.label = value;
                        });
                      },
                      maxLines: widget.maxLines??1,
                      textAlign: widget.maxLines!=null? TextAlign.center : TextAlign.start,
                      keyboardType: widget.isNumber == true ? TextInputType.number : widget.maxLines!=null? TextInputType.multiline
                          : TextInputType.name,
                      textCapitalization: widget.isCapital == true? TextCapitalization.characters : TextCapitalization.none,
                      controller: widget.controller,
                      readOnly: widget.widget != null ? true : false,
                      autofocus: false,
                      cursorColor:
                          Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                      style: subTitleStyle,
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: hintStyle,
                        labelText: widget.label,
                        labelStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            //color: Get.isDarkMode ? Colors.white : Colors.black,
                            color: widget.widget != null ? Colors.blue : Get.isDarkMode? Colors.white : darkGreyClr,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        //enabled: widget != null? false : true,
                        alignLabelWithHint: false,
                        enabled: widget.widget != null? false : widget.enabled,
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                widget.widget ?? Container(),
              ],
            ),
          )
        ],
      ),
    );
  }



}
