import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ticker/controllers/ticker_controller.dart';
import 'package:ticker/models/ticker.dart';
import 'package:ticker/ui/widgets/theme.dart';

import '../size_config.dart';

class SingleTicker extends StatelessWidget {
   SingleTicker({Key? key, required this.ticker, required this.maxHeight}) : super(key: key);
  final Ticker ticker;
  //final colors = [primaryClr, pinkClr, orangeClr];
  final colors = [Colors.green, Colors.red, orangeClr];
  final maxHeight;
  @override
  Widget build(BuildContext context) {
    DateTime? enDate = ticker.entryDate != null? DateTime.parse(ticker.entryDate!) : null;
    DateTime? exDate = ticker.exitDate != null? DateTime.parse(ticker.exitDate!) : null;
    String dateText = '';
    if(enDate!=null){
      dateText = DateFormat.yMMMd().format(enDate);
    }
    else{
      dateText = '.  .  .  ';
    }
    dateText = dateText + '-';
    if(exDate!=null){
      dateText =dateText + DateFormat.yMMMd().format(exDate);
    }
    else{
      dateText = dateText +  '  .  .  .  ';
    }
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(4),
      ),
      width: SizeConfig.screenWidth,
      //margin: EdgeInsets.only(bottom: getProportionateScreenHeight(maxHeight*.1)),
      margin: EdgeInsets.only(bottom: maxHeight*.1),
      child: Container(
        padding: EdgeInsets.all(maxHeight*.12),

        decoration: BoxDecoration(
            color: colors[ticker.color],
            borderRadius: BorderRadius.circular(14)
        ),

        //0.34
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //.54
                    SizedBox(
                      height: maxHeight*.2,
                      child: FittedBox(
                        child: Text(
                          ticker.name,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                     //.64
                     SizedBox(
                      height: maxHeight*.075,
                    ),
                    //.79
                    Row(
                      children: [
                        SizedBox(height: maxHeight*.15,child: FittedBox(child: Icon(Icons.calendar_today, size: 18,
                          color: Get.isDarkMode? Colors.grey[100] : darkGreyClr,),),),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          height: maxHeight*.15,
                          child: FittedBox(
                            child: Text(
                              dateText,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Get.isDarkMode? Colors.grey[100] : darkGreyClr,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                     SizedBox(
                      height: maxHeight*.075,
                    ),
                    SizedBox(
                      height: maxHeight*.15,
                      child: FittedBox(
                        child: Text(
                          calcNetProfitOnLose()!=null? calcNetProfitOnLose()!.toStringAsFixed(3) :  'Incomplete data',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: .50,
              height: maxHeight*.6,
              color: Colors.grey[200]!.withOpacity(.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: InkWell(
                child: SizedBox(
                  height: maxHeight*.1,
                  child: FittedBox(
                    child: Text(
                      'Delete',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Get.isDarkMode?Colors.white : darkGreyClr,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  showDeleteDialog(ticker.id!);
                  print('deleted');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDeleteDialog(int id){
    Get.dialog(
      AlertDialog(
        title: const Text('Delete this ticker!'),
        actions: [
          TextButton(child: const Text('Delete'), onPressed: () {
            TickerController.deleteTicker(id);
            Get.back();
          },),
          TextButton(child: const Text('Cancel'), onPressed: () => Get.back(),),
        ],
      ),
    );
  }

   double? calcProfitOnLose(){
     if(ticker.entryPrice != null && ticker.exitPrice != null &&  ticker.quantity != null){
       return ((ticker.exitPrice! - ticker.entryPrice!) * ticker.quantity!);
     }
     return null;
   }

   double? calcNetProfitOnLose(){
     if(ticker.commission != null && calcProfitOnLose()!=null){
       return (calcProfitOnLose()! - ticker.commission!);
     }
     else
       return null;
   }

}
