import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/common/price_container.dart';
import 'package:wype_user/constants.dart';

import 'extra_services.dart';

class SubscriptionPage extends StatefulWidget {
  LatLng coordinates;
  String address;
  int selectedVehicleIndex;
  SubscriptionPage(
      {super.key,
      required this.coordinates,
      required this.address,
      required this.selectedVehicleIndex});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
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
                  onTap: () => popNav(context),
                  child: Icon(
                    Icons.chevron_left,
                    size: 29,
                    color: lightGradient,
                  ),
                ),
                10.width,
                Text(
                  "Subscription",
                  style: GoogleFonts.readexPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: lightGradient),
                ),
              ],
            ),
            10.height,
            ListView.builder(
                shrinkWrap: true,
                itemCount: subscriptionModel?.packages?.length ?? 0,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => ExtraServices(
                        coordinates: widget.coordinates,
                        address: widget.address,
                        selectedVehicleIndex: widget.selectedVehicleIndex,
                        selectedPackageIndex: index,
                      ).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade),
                      child: PriceContainer(
                        title:
                            subscriptionModel?.packages?[index].name ?? "N/A",
                        subtitle:
                            subscriptionModel?.packages?[index].subtitle ??
                                "N/A",
                        price: subscriptionModel?.packages?[index].price
                                .toString() ??
                            "N/A",
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
