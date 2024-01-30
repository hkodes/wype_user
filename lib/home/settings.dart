

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/auth/login_page.dart';
import 'package:wype_user/common/file_view.dart';
import 'package:wype_user/common/profile_container.dart';
import 'package:wype_user/constants.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: FadeIn(
          child: ListView(     physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: height(context) * 0.08,
          ),
          Row(
            children: [
              InkWell(
                onTap: () => popNav(context),
                child: Icon(
                  Icons.chevron_left,
                  size: 29,
                  color: lightGradient,
                ),
              ),
              10.width,
              Text(
                "Settings",
                style: GoogleFonts.readexPro(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: lightGradient),
              ),
            ],
          ),
          SizedBox(
            height: height(context) * 0.06,
          ),
          ProfileContainer(
              onTap: () => navigation(
                  context,
                  FileViewPage(
                    assetPath: 'assets/docs/aboutus.pdf',
                  ),
                  true),
              icon: FontAwesomeIcons.qrcode,
              text: "About Us"),
          10.height,
          ProfileContainer(
              onTap: () => navigation(
                  context,
                  FileViewPage(
                    assetPath: 'assets/docs/faq.pdf',
                  ),
                  true),
              icon: FontAwesomeIcons.qrcode,
              text: "FAQ"),
          10.height,
          ProfileContainer(
              onTap: () => navigation(
                  context,
                  FileViewPage(
                    assetPath: 'assets/docs/privacy.pdf',
                  ),
                  true),
              icon: FontAwesomeIcons.qrcode,
              text: "Privacy Policy"),
          10.height,
          ProfileContainer(
              onTap: () => navigation(
                  context,
                  FileViewPage(
                    assetPath: 'assets/docs/t&c.pdf',
                  ),
                  true),
              icon: FontAwesomeIcons.qrcode,
              text: "Terms & Condition"),
          10.height,
          ProfileContainer(
              onTap: () => navigation(context, LoginPage(), true),
              icon: FontAwesomeIcons.signOut,
              text: "Log out"),
        ],
      )),
    );
  }
}
