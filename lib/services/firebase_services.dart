import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wype_user/auth/verify_otp.dart';
import 'package:wype_user/constants.dart';
import 'package:wype_user/model/booking.dart';
import 'package:wype_user/model/user_model.dart';

import '../home/root.dart';
import '../model/subscriptions_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to send OTP using Firebase phone authentication
  Future<void> sendOtp(BuildContext context, String phone, bool isNewUser,
      String? name, String? gender) async {
    String phoneNumber = '+91${phone.trim()}'; // Modify country code if needed
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _onVerificationCompleted();
        },
        verificationFailed: (FirebaseAuthException e) {
          toast("Too many login attempts. Please try again later");
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          // toast('Code sent to $phoneNumber');
          VerifyOtp(
            verificationId: verificationId,
            contact: phone,
            isNewUser: isNewUser,
            name: name,
            gender: gender,
          ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      toast(e.toString());
    }
  }

  // Function to check if user document exists in Firestore
  Future<bool> _doesUserDocumentExist(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return snapshot.exists;
  }

  // Function to create user document in Firestore
  Future<void> _createUserDocument(
      String userId, Map<String, dynamic> userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userData);
  }

  // Callback when verification is completed automatically
  void _onVerificationCompleted() {}

  Future<void> login(
    BuildContext context,
    bool isNewUser,
    String? name,
    String? phone,
    String? gender,
    String? password,
  ) async {
    UserCredential authResult;
    if (isNewUser) {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: "${phone!.trim()}@wype.com", password: password!);
    } else {
      authResult = await _auth.signInWithEmailAndPassword(
          email: "${phone!.trim()}@wype.com", password: password!);
    }
    String userId = authResult.user!.uid;

    bool userExists = await _doesUserDocumentExist(userId);

    if (!userExists) {
      if (!isNewUser) {
        toast("User not found. Please Sign up");
      } else {
        if (name != null) {
          await _createUserDocument(
              userId,
              UserModel(
                  id: userId,
                  name: name,
                  contact: phone,
                  gender: gender,
                  points: 0,
                  wallet: 0,
                  vehicle: []).toJson());
          RootPage()
              .launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
        }
      }
    } else {
      RootPage().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
    }

    // Navigate to the next page or perform other actions as needed
  }

  // Callback when the user manually enters the OTP
  Future<void> onOtpEntered(
    String otp,
    String verificationId,
    BuildContext context,
    bool isNewUser,
    String? name,
    String? email,
    String? gender,
  ) async {
    try {
      UserCredential authResult =
          await _auth.signInWithEmailAndPassword(email: "", password: "");
      String userId = authResult.user!.uid;

      bool userExists = await _doesUserDocumentExist(userId);

      if (!userExists) {
        if (!isNewUser) {
          toast("User not found. Please Sign up");
        } else {
          if (name != null) {
            await _createUserDocument(
                userId,
                UserModel(
                    id: userId,
                    name: name,
                    // contact: number,
                    gender: gender,
                    vehicle: []).toJson());
            RootPage()
                .launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
          }
        }
      } else {
        RootPage().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
      }

      // Navigate to the next page or perform other actions as needed
    } catch (e) {
      toast("The sms code has expired");
      print('Error during OTP verification: $e');
      // Handle verification error
    }
  }

  List<Vehicle>? _parseVehicles(List<dynamic>? vehicleList) {
    if (vehicleList == null || vehicleList.isEmpty) {
      return [];
    }

    return vehicleList
        .map((vehicleData) => Vehicle(
              model: vehicleData['model'],
              company: vehicleData['company'],
              numberPlate: vehicleData['number_plate'],
            ))
        .toList();
  }

  Future<UserModel?> getUserDetails() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Retrieve user document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      // Check if the document exists
      if (userDoc.exists) {
        return UserModel(
          id: userDoc['id'],
          name: userDoc['name'],
          contact: userDoc['contact'],
          gender: userDoc['gender'],
          points: userDoc['points'],
          wallet: userDoc['wallet'],

          vehicle: _parseVehicles(userDoc['vehicle']),
          // Add other fields as needed
        );
      } else {
        return null;
      }
    }
  }

  Future<void> addVehicle(Vehicle vehicle) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          // If 'vehicles' field exists, update it with the new vehicle, else create a new list
          List<dynamic>? existingVehicles = userDoc['vehicle'];

          if (existingVehicles != null) {
            existingVehicles.add(vehicle.toJson());
          } else {
            existingVehicles = [vehicle.toJson()];
          }

          // Update user document in Firestore with the updated vehicles list
          await _firestore.collection('users').doc(user.uid).update({
            'vehicle': existingVehicles,
          });
        }
      }
    } catch (e) {
      toast("Vehicle added");
      print('Error adding vehicle: $e');
      // Handle error
    }
  }

  Future<void> deleteVehicle(List<Vehicle>? vehicle) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          await _firestore.collection('users').doc(user.uid).update({
            'vehicle':
                userData?.vehicle?.map((vehicle) => vehicle.toJson()).toList(),
          });
        }
      }
    } catch (e) {
      toast("Vehicle deleted");
      print(e.toString());
      // Handle error
    }
  }

  Future<Subscriptions?> getSubscriptions() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Retrieve user document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('subscriptions').doc("packages").get();

      // Check if the document exists
      if (userDoc.exists) {
        var docs = json.encode(userDoc.data());
        return Subscriptions.fromJson(json.decode(docs));
      }
    } else {
      return null;
    }
  }

  Timestamp add12HoursToTimestamp(Timestamp originalTimestamp) {
    DateTime originalDateTime = originalTimestamp.toDate();
    DateTime newDateTime = originalDateTime.add(Duration(hours: 12));
    Timestamp newTimestamp = Timestamp.fromDate(newDateTime);
    return newTimestamp;
  }

  createBookings(BookingModel booking) async {
    CollectionReference bookingsCollection = _firestore.collection('bookings');

    for (int i = 0; i < booking.washCount; i++) {
      booking.washTimings = add12HoursToTimestamp(booking.washTimings);
      if (userData != null && (userData?.id != null)) {
        await bookingsCollection.add(booking.toJson());
      } else {
        toast("Please try again later");
      }
    }
  }
}
