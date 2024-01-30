import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/auth/login_page.dart';
import 'package:wype_user/common/profile_container.dart';
import 'package:wype_user/home/settings.dart';
import 'package:wype_user/profile/address_list.dart';
import 'package:wype_user/profile/points_page.dart';
import 'package:wype_user/profile/promo_codes.dart';
import 'package:wype_user/profile/wallet_page.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              height: height(context) * 0.08,
            ),
            Container(
              height: height(context) * 0.13,
              width: height(context) * 0.13,
              decoration: BoxDecoration(
                  border: Border.all(color: darkGradient),
                  color: white,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: Center(
                child: Text(
                  userData?.name.capitalizeFirstLetter().substring(0, 1) ?? "T",
                  style: GoogleFonts.readexPro(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: darkGradient),
                ),
              ),
            ),
            20.height,
            Align(
              alignment: Alignment.center,
              child: Text(
                userData?.name.capitalizeFirstLetter() ?? "",
                style: GoogleFonts.readexPro(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGradient),
              ),
            ),
            40.height,
            ProfileContainer(
                onTap: () => WalletPage().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade),
                icon: FontAwesomeIcons.wallet,
                subText: userData?.wallet == null
                    ? null
                    : "${userData?.wallet.toString()} QR",
                text: "Wallet"),
            10.height,
            ProfileContainer(
                // ignore: prefer_null_aware_operators
                subText: userData?.points == null
                    ? null
                    : userData?.points.toString(),
                onTap: () => PointsPage().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade),
                icon: FontAwesomeIcons.coins,
                text: "My Points"),
            10.height,
           
            ProfileContainer(
                onTap: () => PromoCodes().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade),
                icon: FontAwesomeIcons.qrcode,
                text: "Promo Codes"),
            // 10.height,
            // ProfileContainer(
            //     onTap: () => AddressList().launch(context,
            //         pageRouteAnimation: PageRouteAnimation.Fade),
            //     icon: FontAwesomeIcons.locationArrow,
            //     text: "Saved Address"),
            10.height,
            ProfileContainer(
                onTap: () => SettingPage().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade),
                icon: FontAwesomeIcons.cogs,
                text: "Settings"),

            10.height,
          ],
        ),
      ),
    );
  }
}
