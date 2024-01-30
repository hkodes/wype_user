import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wype_user/model/user_model.dart';

class BookingModel {
  String? id; // Document ID
  String bookingStatus;
  String serviceType;
  String userId;
  String address;
  Vehicle vehicle;
  int washCount;
  Timestamp washTimings;
  LatLngModel latlong;

  BookingModel({
    this.id,
    required this.bookingStatus,
    required this.serviceType,
    required this.userId,
    required this.address,
    required this.latlong,
    required this.vehicle,
    required this.washCount,
    required this.washTimings,
  });

  factory BookingModel.fromMap(String id, Map<String, dynamic> map) {
    return BookingModel(
      id: id,
      address: map['address'] ?? "",
      latlong: LatLngModel.fromJson(map['latlong']),
      bookingStatus: map['booking_status'] ?? '',
      serviceType: map['service_type'] ?? '',
      userId: map['user_id'] ?? '',
      vehicle: Vehicle.fromJson(map['vehicle'] ?? {}),
      washCount: map['wash_count'] ?? 0,
      washTimings: (map['wash_timings']),
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_status': bookingStatus,
      'service_type': serviceType,
      'user_id': userId,
      'address': address,
      'vehicle': vehicle.toJson(),
      'wash_count': washCount,
      'wash_timings': washTimings,
      'latlong': latlong.toJson(),
    };
  }
}



class LatLngModel {
  double lat;
  double long;

  LatLngModel({
    required this.lat,
    required this.long,
  });

  factory LatLngModel.fromJson(Map<String, dynamic> json) {
    return LatLngModel(
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}
