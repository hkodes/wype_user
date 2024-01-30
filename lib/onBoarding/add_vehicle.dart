import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/common/car_container.dart';
import 'package:wype_user/model/user_model.dart';
import '../common/custom_dropdown.dart';
import '../common/primary_button.dart';
import '../constants.dart';
import 'subscriptions.dart';
import '../services/firebase_services.dart';

class AddVehiclePage extends StatefulWidget {
  bool isFromHome;
  LatLng? coordinates;
  String? address;
  AddVehiclePage(
      {super.key, required this.isFromHome, this.coordinates, this.address});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  String? selectedModel;
  String? selectedCompany;
  int? selectedIndex;

  FirebaseService firebaseService = FirebaseService();
  TextEditingController plateCont = TextEditingController();
  bool isAdding = false;

  addVehicleDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, dialogState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical:
                      (WidgetsBinding.instance.window.viewInsets.bottom > 0.0)
                          ? 0
                          : height(context) * 0.2),
              child: Dialog(
                elevation: 2,
                backgroundColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Select Vehicle",
                          style: GoogleFonts.readexPro(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: darkGradient),
                        ),
                      ),
                      20.height,
                      CustomDropDown(
                          hintText: "Select Vehicle Company",
                          selectedValue: selectedCompany,
                          maxLimit: models,
                          isNotification: true,
                          onChanged: (val) {
                            selectedCompany = val!;
                            dialogState(() {});
                          }),
                      20.height,
                      CustomDropDown(
                          hintText: "Select Vehicle Model",
                          selectedValue: selectedModel,
                          maxLimit: models,
                          isNotification: true,
                          onChanged: (val) {
                            selectedModel = val!;
                            dialogState(() {});
                          }),
                      10.height,
                      AppTextField(
                        textStyle: GoogleFonts.readexPro(),
                        textFieldType: TextFieldType.NAME,
                        controller: plateCont,
                        decoration: inputDecoration(context,
                            labelText: "Plate No- Optional"),
                      ),
                      30.height,
                      Align(
                        alignment: Alignment.center,
                        child: PrimaryButton(
                          text: isAdding ? loaderText : "Add",
                          onTap: () async {
                            if (selectedModel == null ||
                                selectedCompany == null) {
                              toast("Please add company and model");
                            } else {
                              isAdding = true;
                              dialogState(() {});
                              Vehicle vehicle = Vehicle(
                                  model: selectedModel,
                                  company: selectedCompany,
                                  numberPlate: plateCont.text.isEmpty
                                      ? "N/A"
                                      : plateCont.text);
                              userData?.vehicle?.add(vehicle);
                              await firebaseService.addVehicle(vehicle);
                              selectedCompany = null;
                              selectedModel = null;
                              plateCont.clear();
                              isAdding = false;
                              dialogState(() {});
                              popNav(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height(context) * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isFromHome
                    ? Text(
                        "Vehicles",
                        style: GoogleFonts.readexPro(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkGradient),
                      )
                    : InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => popNav(context),
                        child: Icon(
                          Icons.chevron_left,
                          size: 30,
                        ),
                      ),
                widget.isFromHome
                    ? Container()
                    : Text(
                        widget.isFromHome ? "Vehicles" : "Add Vehicle",
                        style: GoogleFonts.readexPro(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkGradient),
                      ),
                InkWell(
                  onTap: () => addVehicleDialog(),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkGradient,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            (userData?.vehicle?.isEmpty ?? true)
                ? Expanded(
                    child: Center(
                      child: Text(
                        "No Vehicles found",
                        style: GoogleFonts.readexPro(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkGradient),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: userData?.vehicle?.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              selectedIndex = index;
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CarContainer(
                                deleteCar: () {
                                  userData?.vehicle?.removeAt(index);
                                  setState(() {});
                                  firebaseService.deleteVehicle(userData?.vehicle);
                                },
                                isFromHome: widget.isFromHome,
                                name:
                                    userData?.vehicle?[index].company ?? "N/A",
                                model: userData?.vehicle?[index].model ?? "N/A",
                                registration:
                                    userData?.vehicle?[index].numberPlate ??
                                        "N/A",
                                isSelected: widget.isFromHome
                                    ? false
                                    : selectedIndex == index,
                              ),
                            ),
                          );
                        }),
                  ),
            widget.isFromHome
                ? Container()
                : Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: PrimaryButton(
                        text: "Next",
                        onTap: () {
                          if (selectedIndex == null) {
                            toast("Please select vehicle");
                          } else {
                            SubscriptionPage(
                              coordinates: widget.coordinates!,
                              address: widget.address!,
                              selectedVehicleIndex: selectedIndex!,
                            ).launch(context,
                                pageRouteAnimation: PageRouteAnimation.Fade);
                          }
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
