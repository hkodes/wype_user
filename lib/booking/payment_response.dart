import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/constants.dart';
import 'package:wype_user/home/home.dart';
import 'package:wype_user/home/root.dart';

import '../common/primary_button.dart';

class PaymentResponse extends StatefulWidget {
  const PaymentResponse({super.key});

  @override
  State<PaymentResponse> createState() => _PaymentResponseState();
}

class _PaymentResponseState extends State<PaymentResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: FadeIn(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.circleCheck,
                color: lightGradient,
                size: height(context) * 0.2,
              ),
              30.height,
              Text(
                "Payment Successfull",
                style: GoogleFonts.readexPro(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGradient),
              ),
              10.height,
              Text(
                "Ref No: 1298731298",
                style: GoogleFonts.readexPro(
                    fontSize: 17, fontWeight: FontWeight.w500, color: grey),
              ),
              10.height,
              Text(
                "Date: 20 Nv 2022",
                style: GoogleFonts.readexPro(
                    fontSize: 17, fontWeight: FontWeight.w500, color: grey),
              ),
              10.height,
              Text(
                "Time: 12 PM",
                style: GoogleFonts.readexPro(
                    fontSize: 17, fontWeight: FontWeight.w500, color: grey),
              ), 40.height,
            Align( 
              alignment: Alignment.center,
              child: PrimaryButton(
                text: "Back Home",
                onTap: () => RootPage().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
