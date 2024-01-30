import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/constants.dart';
import 'package:wype_user/model/booking.dart';

class BookingWidget extends StatelessWidget {
  BookingModel bookingDetail;
  BookingWidget({super.key, required this.bookingDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "#${bookingDetail.id}",
                style: GoogleFonts.readexPro(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: darkGradient),
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Service",
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                    Padding(
                      padding:  EdgeInsets.only(right: width(context) * 0.1),
                      child: Text(
                      "Time",
                      style: GoogleFonts.readexPro(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                                      ),
                    ),
                  // Text(
                  //   "Car",
                  //   style: GoogleFonts.readexPro(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.grey),
                  // ),
                ],
              ),
              5.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bookingDetail.serviceType,
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: darkGradient),
                  ),
                    Text(
                  "${bookingDetail.washTimings.toDate().day} ${DateFormat('MMMM').format(bookingDetail.washTimings.toDate()).substring(0,3)} at ${bookingDetail.washTimings.toDate().hour}:${bookingDetail.washTimings.toDate().minute}",
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: darkGradient),
                  ),
                  // Text(
                  //   bookingDetail.vehicle.model ?? "N/A",
                  //   style: GoogleFonts.readexPro(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //       color: darkGradient),
                  // ),
                ],
              )
            ],
          )),
          30.width,
          bookingDetail.bookingStatus == "on_going"
              ? Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.green,
                      size: 30,
                    ),
                    10.height,
                    Text(
                      "On-Going",
                      style: GoogleFonts.readexPro(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: darkGradient),
                    ),
                  ],
                )
              : bookingDetail.bookingStatus == "up_coming"
                  ? Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.exclamation,
                          color: Colors.amber,
                          size: 30,
                        ),
                        10.height,
                        Text(
                          "Up-Coming",
                          style: GoogleFonts.readexPro(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: darkGradient),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.circleCheck,
                          color: Colors.green,
                          size: 30,
                        ),
                        Text(
                          "Completed",
                          style: GoogleFonts.readexPro(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: darkGradient),
                        ),
                      ],
                    )
        ],
      ),
    );
  }
}
