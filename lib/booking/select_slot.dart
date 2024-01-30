import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/booking/payment_response.dart';
import 'package:wype_user/model/booking.dart';
import 'package:wype_user/services/firebase_services.dart';

import '../common/primary_button.dart';
import '../constants.dart';

class SelectSlot extends StatefulWidget {
  LatLng coordinates;
  String address;
  int selectedVehicleIndex;
  int selectedPackageIndex;
  double price;
  int selectedWashIndex;

  SelectSlot(
      {super.key,
      required this.address,
      required this.coordinates,
      required this.price,
      required this.selectedPackageIndex,
      required this.selectedWashIndex,
      required this.selectedVehicleIndex});

  @override
  State<SelectSlot> createState() => _SelectSlotState();
}

class _SelectSlotState extends State<SelectSlot> {
  DateTime currentDateTime = DateTime.now();
  DateTime? selectedDate;
  String? pickedTime;
  FirebaseService firebaseService = FirebaseService();
  bool isLoading = false;

  setLoader(bool val) {
    isLoading = val;
    setState(() {});
  }

  void selectDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDateTime,
      firstDate: currentDateTime,
      lastDate: currentDateTime.add(30.days),
      builder: (_, child) {
        return Theme(
          data: ThemeData.dark(useMaterial3: true),
          child: child!,
        );
      },
    ).then((date) => {
          if (date != null) {selectedDate = date, setState(() {})}
        });
  }

  void selectTime(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: 200,
            height: 200,
            child: CupertinoPicker(
              itemExtent: 33,
              onSelectedItemChanged: (value) {
                if (timings[value] != "Unavailable") {
                  pickedTime = timings[value];
                } else {
                  pickedTime = null;
                }
                setState(() {});
              },
              children: List.generate(
                timings.length,
                (index) => Text(timings[index]),
              ),
            ),
          ),
        );
      },
    );

    // showTimePicker(
    //   context: context,
    //   initialTime: pickedTime ?? TimeOfDay.now(),
    //   builder: (_, child) {
    //     return Theme(
    //       data: ThemeData.dark(useMaterial3: true),
    //       child: child!,
    //     );
    //   },
    // ).then((time) => {
    //       if (time != null) {pickedTime = time, setState(() {})}
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: FadeIn(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(
              height: height(context) * 0.06,
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
                  "Book Slot",
                  style: GoogleFonts.readexPro(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: lightGradient),
                ),
              ],
            ),
            30.height,
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: darkGradient),
                ),
                child: Row(
                  children: [
                    Text(
                      selectedDate == null
                          ? "Date"
                          : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                      style: GoogleFonts.readexPro(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: grey),
                    ),
                    Spacer(),
                    Icon(
                      FontAwesomeIcons.calendar,
                      color: grey,
                    )
                  ],
                ),
              ),
            ),
            15.height,
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => selectTime(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: darkGradient),
                ),
                child: Row(
                  children: [
                    Text(
                      pickedTime == null ? "Time" : "$pickedTime",
                      style: GoogleFonts.readexPro(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: grey),
                    ),
                    Spacer(),
                    Icon(
                      FontAwesomeIcons.clock,
                      color: grey,
                    )
                  ],
                ),
              ),
            ),
            25.height,
            Text(
              "Select Address",
              style: GoogleFonts.readexPro(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: lightGradient),
            ),
            20.height,
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: darkGradient,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: darkGradient),
              ),
              child: Text(
                widget.address,
                style: GoogleFonts.readexPro(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            25.height,
            Text(
              "Payment Options",
              style: GoogleFonts.readexPro(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: lightGradient),
            ),
            20.height,
            Container(
              height: height(context) * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: darkGradient),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.apple,
                    color: darkGradient,
                  ),
                  10.width,
                  Text(
                    "Apple Pay",
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: lightGradient),
                  ),
                ],
              ),
            ),
            15.height,
            Container(
              height: height(context) * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: darkGradient),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.creditCard,
                    color: darkGradient,
                  ),
                  10.width,
                  Text(
                    "Card",
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: lightGradient),
                  ),
                ],
              ),
            ),
            15.height,
            Container(
              height: height(context) * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: darkGradient),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.creditCard,
                    color: darkGradient,
                  ),
                  10.width,
                  Text(
                    "Wallet",
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: lightGradient),
                  ),
                ],
              ),
            ),
            20.height,
            Align(
              alignment: Alignment.center,
              child: PrimaryButton(
                text: isLoading
                    ? loaderText
                    : "Proceed to Pay QR ${widget.price}",
                onTap: ()
                    // => navigation(context, PaymentResponse(), true),
                    async {
                  if (selectedDate == null || pickedTime == null) {
                    toast("Please select Date and Time");
                  } else {
                    setLoader(true);
                    try {
                      await firebaseService.createBookings(BookingModel(
                          latlong: LatLngModel(
                              lat: widget.coordinates.latitude,
                              long: widget.coordinates.longitude),
                          address: widget.address,
                          bookingStatus: "up_coming",
                          serviceType: subscriptionModel?.packages![widget.selectedPackageIndex].name ?? "N/A",
                          userId: userData?.id ?? "",
                          vehicle:
                              userData!.vehicle![widget.selectedVehicleIndex],
                          washCount: subscriptionModel!
                              .extraService![widget.selectedWashIndex].name
                              .toInt(),
                          washTimings: createTimestampFromDateAndTime(
                              selectedDate.toString() ,pickedTime!)));

                      setLoader(false);
                      navigation(context, PaymentResponse(), true);
                    } catch (e) {
                      print("Error: $e");
                      setLoader(false);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Timestamp createTimestampFromDateAndTime(String date, String time) {
  String combinedDateTimeString = '${date.substring(0,10)} $time';
  DateTime parsedDateTime = DateFormat("yyyy-MM-dd h:mm a").parse(combinedDateTimeString);
  Timestamp timestamp = Timestamp.fromDate(parsedDateTime);

  return timestamp;
}
