import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MyAppBar extends StatelessWidget {

  final String title;
  final bool? back;
  final Icon? icon;
  final Function? onTapRight;
  final Function? onTapLeft;

  const MyAppBar({Key? key, required this.title, this.back, this.icon, this.onTapRight, this.onTapLeft}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final double safeArea = MediaQuery.of(context).padding.top;
    final double heightScreen = MediaQuery.of(context).size.height;
    final double widthScreen = MediaQuery.of(context).size.width;


    return Column(
      children: [
        Container(
          width: widthScreen,
          height: safeArea,
          color: azul_principal,
        ),
        Container(
          width: widthScreen,
          height: heightScreen * 0.10,
          decoration: BoxDecoration(
              color: azul_principal,
              border: Border(
                  bottom: BorderSide(width: 0.4, color: Colors.white))),
          child: Center(
            child: Stack(
              children: [
                back == true ? Row(
                  children: [
                    SizedBox(width: 8),
                    InkWell(
                        onTap: () {
                          if(onTapLeft == null) {
                            Get.back();
                          } else {
                            onTapLeft!.call();
                          }
                        },
                        child: Icon(Icons.arrow_back_ios, size: 32, color: Colors.white)),
                  ],
                ) : Container(height: 32),
                Container(
                  height: 32,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: widthScreen,
                  height: 32,
                  alignment: Alignment.centerRight,
//                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: icon != null ?
                    InkWell(
                      onTap: onTapRight!.call(),
                        child: icon) :
                    Container(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
