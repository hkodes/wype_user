import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/constants.dart';
import 'package:wype_user/onBoarding/add_address.dart';
import '../common/primary_button.dart';

class PlainHome extends StatelessWidget {
  const PlainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: width(context),
        height: height(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            40.height,
                     Image(
              image: AssetImage('assets/images/logo.png'),
              height: height(context) * 0.1,
            ),     
            20.height,
            Text(
              "Anytime, anywhere, will be there!",
              style: GoogleFonts.readexPro(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: lightGradient),
            ),
              20.height,
              Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: 
            Text(
              "The first sustainable and Eco-friendly car cleaning App Company in Qatar! We help our community with minimal water usage and environmentally friendly products for our services. Our team is composed of the most experienced professionals committed to offer the finest customer service to ensure you enjoy the journey.Offering you subscriptions within our application and distinct payment methods.",
              textAlign: TextAlign.center,
              style: GoogleFonts.readexPro(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkGradient),
            ),),
            25.height,
            Image(
              image: AssetImage('assets/images/carwash.jpeg'),
              height: height(context) * 0.2,
              width: width(context),
            ),
            40.height,
            Align(
              alignment: Alignment.center,
              child: PrimaryButton(
                  text: "Book Now",
                  onTap: () => navigation(
                      context,
                      AddAddressPage(
                        isFromHome: true,
                      ),
                      true)),
            ),
          ],
        ),
      ),
    );
  }
}
