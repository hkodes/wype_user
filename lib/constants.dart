import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wype_user/model/subscriptions_model.dart';
import 'package:wype_user/model/user_model.dart';

const Color backgroundColor = Colors.white;
Color greyBg = Colors.grey.shade200;
Color iconColor = Colors.blue.shade800;
String gptKey = "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";

const loaderText = "• • •";

var lightGradient = HexColor("54B2CF");
var darkGradient = HexColor("0D1634");

height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

navigation(BuildContext context, Widget navigateTo, bool? isRoot) {
  return Navigator.of(context, rootNavigator: isRoot ?? false).push(
    PageTransition(
        type: PageTransitionType.fade,
        isIos: false,
        duration: Duration(milliseconds: 200),
        child: navigateTo),
  );
}

popNav(BuildContext context) {
  return Navigator.of(context).pop();
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

InputDecoration inputDecoration(BuildContext context,
    {Widget? prefixIcon, String? labelText, double? borderRadius}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 12, bottom: 15, top: 15, right: 10),
    counterText: "",
    labelText: labelText,
    labelStyle: GoogleFonts.readexPro(color: Colors.grey.shade400),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: lightGray, width: 0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: GoogleFonts.readexPro(color: Colors.red, fontSize: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: lightGradient, width: 1.0),
    ),
    filled: true,
    fillColor: context.cardColor,
  );
}

Widget primaryButton(String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(35),
      color: darkGradient,
    ),
    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    child: Text(
      text,
      style: GoogleFonts.readexPro(color: Colors.white),
    ),
  );
}

List<String> models = ["BMW", "Audi"];

List<String> topServices = [
  "assets/icons/wash.png",
  "assets/icons/Interior Clean.png",
  "assets/icons/Polish.png",
  "assets/icons/Tire Dressing.png",
  "assets/icons/Engine Wash.png",
  "assets/icons/Spray.png",
  "assets/icons/Blower.png",
  "assets/icons/Carpet Clean.png",
];

String getAssetName(String fullPath) {
  // Split the path using the '/' separator
  List<String> pathSegments = fullPath.split('/');

  // The last segment will be the asset name
  String assetName = pathSegments.last;

  return assetName;
}

List<String> timings = [
  "9:00 AM",
  "9:30 AM",
  "10:00 AM",
  "Unavailable",
  "11:00 AM",
  "Unavailable",
  "12:00 PM",
  "1:00 PM",
  "2:00 PM",
  "Unavailable",
  "3:00 PM",
  "4:00 PM",
  "Unavailable",
  "Unavailable",
];
List<String> reSchedule = ["12 hrs", "24 hrs"];

UserModel? userData;

Subscriptions? subscriptionModel;
