import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:wype_user/auth/login_page.dart';
import 'package:wype_user/home/home_plain.dart';
import 'package:wype_user/home/profile.dart';
import 'package:wype_user/onBoarding/add_vehicle.dart';
import 'package:wype_user/profile/my_booking.dart';

import '../constants.dart';
import '../services/firebase_services.dart';
import 'home.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  FirebaseService firebaseService = FirebaseService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  setLoader(bool val) {
    isLoading = val;
    setState(() {});
  }

  getCurrentUser() async {
    userData = await firebaseService.getUserDetails();
    if (userData == null) {
      LoginPage().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
    } else {
      subscriptionModel = await firebaseService.getSubscriptions();
      setLoader(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens() {
      return [
        PlainHome(),
        AddVehiclePage(isFromHome: true),
        BookingPage(),
        ProfilePage(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarItems = [
      PersistentBottomNavBarItem(
        title: "Home",
        icon: Icon(
          FontAwesomeIcons.home,
          size: 20,
        ),
        textStyle: GoogleFonts.lato(fontSize: 12),
        activeColorPrimary: darkGradient,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        title: "Vehicles",
        icon: Icon(
          FontAwesomeIcons.car,
          size: 20,
        ),
        textStyle: GoogleFonts.lato(fontSize: 12),
        activeColorPrimary: darkGradient,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        title: "Bookings",
        icon: Icon(
          FontAwesomeIcons.clock,
          size: 20,
        ),
        textStyle: GoogleFonts.lato(fontSize: 12),
        activeColorPrimary: darkGradient,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        title: "Profile",
        icon: Icon(
          Icons.person,
          size: 25,
        ),
        textStyle: GoogleFonts.lato(fontSize: 12),
        activeColorPrimary: darkGradient,
        inactiveColorPrimary: Colors.grey,
      ),
    ];

    PersistentTabView _buildScreens() {
      return PersistentTabView(context, controller: controller,
          onItemSelected: (val) {
        setState(() {
          FocusScope.of(context).unfocus();
        });
      },
          items: navBarItems,
          backgroundColor: Colors.white,
          screens: _screens(),
          navBarStyle: NavBarStyle.style8);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: darkGradient,
              ),
            )
          : _buildScreens(),
    );
  }
}
