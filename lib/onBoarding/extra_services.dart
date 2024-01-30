import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/common/extra_service.dart';
import 'package:wype_user/common/primary_button.dart';
import 'package:wype_user/constants.dart';
import 'package:wype_user/profile/add_remove_service.dart';

class ExtraServices extends StatefulWidget {
  LatLng coordinates;
  String address;
  int selectedVehicleIndex;
  int selectedPackageIndex;
  ExtraServices(
      {super.key,
      required this.coordinates,
      required this.address,
      required this.selectedPackageIndex,
      required this.selectedVehicleIndex});

  @override
  State<ExtraServices> createState() => _ExtraServicesState();
}

class _ExtraServicesState extends State<ExtraServices> {
  List<String> washCounts = ["1", "4", "8", "12"];
  int selectedWashIndex = 0;
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
                Expanded(
                  child: Text(
                    "${subscriptionModel?.packages?[widget.selectedPackageIndex].name ?? "N/A"} - Extra Services",
                    style: GoogleFonts.readexPro(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: lightGradient),
                  ),
                ),
              ],
            ),
            25.height,
            ListView.builder(
                shrinkWrap: true,
                itemCount: subscriptionModel?.extraService?.length ?? 0,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      selectedWashIndex = index;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ExtraServiceContainer(
                          noOfWash:
                              subscriptionModel?.extraService?[index].name ??
                                  "N/A",
                          isSelected: selectedWashIndex == index,
                          price: subscriptionModel?.extraService?[index].price
                                  .toString() ??
                              "0"),
                    ),
                  );
                }),
            40.height,
            Align(
              alignment: Alignment.center,
              child: PrimaryButton(
                text: "Continue",
                onTap: () => AddRemoveService(
                  coordinates: widget.coordinates,
                  address: widget.address,
                  selectedPackageIndex: widget.selectedPackageIndex,
                  selectedVehicleIndex: widget.selectedVehicleIndex,
                  selectedWashIndex: selectedWashIndex,
                ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
