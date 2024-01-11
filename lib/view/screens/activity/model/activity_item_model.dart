class ActivityItemModel {
  final String vachelType;
  final String? title;
  final String? date;
  final String? orderStatus;
  final double? orderAmount;
  final RiderDetails? riderDetails;
  final TripDetails? tripDetails;
  final String createdAt;
  final String dropLocation;
  final String pickupLocation;

  ActivityItemModel({
    required this.vachelType,
    this.title,
    this.date,
    this.orderAmount,
    this.orderStatus,
    this.riderDetails,
    this.tripDetails,
    required this.createdAt,
    required this.dropLocation,
    required this.pickupLocation,
  });

  factory ActivityItemModel.fromMap(Map<String, dynamic> map) {
    return ActivityItemModel( // Provide a default value if null
      vachelType: map['vachelType'] ?? '',
      title: map['title'],
      date: map['date'],
      orderAmount: map['orderAmount']?.toDouble(),
      orderStatus: map['orderStatus'],
      riderDetails: map['riderDetails'] != null
          ? RiderDetails.fromMap(map['riderDetails'])
          : null,
      tripDetails: map['tripDetails'] != null
          ? TripDetails.fromMap(map['tripDetails'])
          : null,
      createdAt: map['createdAt'] ?? '',
      dropLocation: map['dropLocation'] ?? '',
      pickupLocation: map['pickupLocation'] ?? '',
    );
  }
}

class RiderDetails {
  final String? name;
  final String? image;
  final double? rating;
  final String? vehicleType;
  final String? vehicleName;
  final String? vehicleNumber;

  RiderDetails({
    this.name,
    this.image,
    this.rating,
    this.vehicleType,
    this.vehicleName,
    this.vehicleNumber,
  });

  factory RiderDetails.fromMap(Map<String, dynamic> map) {
    return RiderDetails(
      name: map['name'],
      image: map['image'],
      rating: map['rating']?.toDouble(),
      vehicleType: map['vehicleType'],
      vehicleName: map['vehicleName'],
      vehicleNumber: map['vehicleNumber'],
    );
  }
}

class TripDetails {
  final String? pickLocation;
  final String? destination;
  final double? totalDistance;
  final double? farePrice;
  final String? paymentMethod;

  TripDetails({
    this.pickLocation,
    this.destination,
    this.totalDistance,
    this.farePrice,
    this.paymentMethod,
  });

  factory TripDetails.fromMap(Map<String, dynamic> map) {
    return TripDetails(
      pickLocation: map['pickLocation'],
      destination: map['destination'],
      totalDistance: map['totalDistance']?.toDouble(),
      farePrice: map['farePrice']?.toDouble(),
      paymentMethod: map['paymentMethod'],
    );
  }
}
