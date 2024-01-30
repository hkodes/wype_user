import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../common/primary_button.dart';
import '../constants.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: FadeIn(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: height(context) * 0.07,
            ),
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => popNav(context),
                  child: Icon(
                    Icons.chevron_left,
                    size: 29,
                    color: lightGradient,
                  ),
                ),
                10.width,
                Text(
                  "Wallet",
                  style: GoogleFonts.readexPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: lightGradient),
                ),
              ],
            ),
            20.height,
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Available balance: ",
                  style: GoogleFonts.readexPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkGradient.withOpacity(0.6)),
                ),
                   Text(
                  "${userData?.wallet.toString() ?? "0"} QR" ,
                  style: GoogleFonts.readexPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkGradient),
                ),
              ],
            ),
            25.height,
             AppTextField(
                        textStyle: GoogleFonts.readexPro(),
                        textFieldType: TextFieldType.NUMBER,
                        decoration: inputDecoration(context,
                            labelText: "Enter Deposit Amount"),
                      ),
                        50.height,
                      Align(
                        alignment: Alignment.center,
                        child: PrimaryButton(
                          text: "Proceed",
                          onTap: () => popNav(context)
                        ),
                      ),
            
            ],),),);
  }
}