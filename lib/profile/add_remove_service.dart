import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/booking/select_slot.dart';
import 'package:wype_user/common/add_remove_widget.dart';
import 'package:wype_user/common/primary_button.dart';
import 'package:wype_user/constants.dart';

class AddRemoveService extends StatefulWidget {
  LatLng coordinates;
  String address;
  int selectedVehicleIndex;
  int selectedPackageIndex;
  int selectedWashIndex;
  AddRemoveService(
      {super.key,
      required this.coordinates,
      required this.address,
      required this.selectedPackageIndex,
      required this.selectedVehicleIndex,
      required this.selectedWashIndex});

  @override
  State<AddRemoveService> createState() => _AddRemoveServiceState();
}

class _AddRemoveServiceState extends State<AddRemoveService> {
  int? price;

  @override
  void initState() {
    super.initState();
    setPrice();
  }

  setPrice() {
    price =
        (subscriptionModel?.packages?[widget.selectedPackageIndex].price ?? 0) as int?;
  }

  List<int> addPriceIndex = [];
  List<int> removePriceIndex = [];

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
                    subscriptionModel
                            ?.packages?[widget.selectedPackageIndex].name ??
                        "N/A",
                    style: GoogleFonts.readexPro(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: lightGradient),
                  ),
                ),
              ],
            ),
            20.height,
            Text(
              "Add Services",
              style: GoogleFonts.readexPro(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkGradient),
            ),
            20.height,
            ListView.builder(
                shrinkWrap: true,
                itemCount: subscriptionModel?.addServices?.length ?? 0,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: InkWell(
                                        borderRadius: BorderRadius.circular(20),

                      onTap: () {
                        if (addPriceIndex.contains(index)) {
                          addPriceIndex.remove(index);

                          price = ((price ?? 0) -
                              (subscriptionModel?.addServices?[index].price ??
                                  0)) as int?;
                        } else {
                          addPriceIndex.add(index);
                          price = ((price ?? 0) +
                              (subscriptionModel?.addServices?[index].price ??
                                  0)) as int?;
                        }
                        setState(() {});
                      },
                      child: AddRemoveWidget(
                        title: subscriptionModel?.addServices?[index].name ??
                            "N/A",
                        subtitle:
                            subscriptionModel?.addServices?[index].subtitle ??
                                "N/A",
                        isOnlyRemove: false,
                        isSelected: addPriceIndex.contains(index),
                        price: subscriptionModel?.addServices?[index].price
                                .toString() ??
                            "N/A",
                      ),
                    ),
                  );
                }),
            20.height,
            Text(
              "Remove Services",
              style: GoogleFonts.readexPro(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkGradient),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: subscriptionModel?.removeService?.length ?? 0,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 0),
                    child: InkWell(
                      onTap: () {},
                      child: InkWell(
                                          borderRadius: BorderRadius.circular(20),

                        onTap: () {
                          if (removePriceIndex.contains(index)) {
                            removePriceIndex.remove(index);
                            price = ((price ?? 0) +
                                (subscriptionModel
                                        ?.removeService?[index].price ??
                                    0)) as int?;
                          } else {
                            removePriceIndex.add(index);
                            price = ((price ?? 0) -
                                (subscriptionModel
                                        ?.removeService?[index].price ??
                                    0)) as int?;
                          }
                          setState(() {});
                        },
                        child: AddRemoveWidget(
                          title:
                              subscriptionModel?.removeService?[index].name ??
                                  "N/A",
                          subtitle: subscriptionModel
                                  ?.removeService?[index].subtitle ??
                              "N/A",
                          isOnlyRemove: true,
                          isSelected: removePriceIndex.contains(index),
                          price: subscriptionModel?.removeService?[index].price
                                  .toString() ??
                              "N/A",
                        ),
                      ),
                    ),
                  );
                }),
            60.height,
            Align(
              alignment: Alignment.center,
              child: PrimaryButton(
                  text: "Pay $price QR",
                  onTap: () => SelectSlot(
                        selectedWashIndex: widget.selectedWashIndex,
                        price: double.parse(price.toString()),
                        coordinates: widget.coordinates,
                        address: widget.address,
                        selectedVehicleIndex: widget.selectedVehicleIndex,
                        selectedPackageIndex: widget.selectedPackageIndex,
                      ).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade)),
            ),
          ],
        ),
      ),
    );
  }
}
