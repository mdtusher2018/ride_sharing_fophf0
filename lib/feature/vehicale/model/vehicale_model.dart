class Vehicle {
  final String id;
  final String user;
  final String vehicleType;
  final String registration;
  final int year;
  final String brand;
  final String vehicleModel;
  final String licensePlateNumber;
  final List<String> vehicleImages;
  final String status;
  final DateTime submittedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Vehicle({
    required this.id,
    required this.user,
    required this.vehicleType,
    required this.registration,
    required this.year,
    required this.brand,
    required this.vehicleModel,
    required this.licensePlateNumber,
    required this.vehicleImages,
    required this.status,
    required this.submittedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      user: json['user'],
      vehicleType: json['vehicleType'],
      registration: json['registration'],
      year: json['year'],
      brand: json['brand'],
      vehicleModel: json['vehicleModel'],
      licensePlateNumber: json['licensePlateNumber'],
      vehicleImages: List<String>.from(json['vehicleImages']),
      status: json['status'],
      submittedAt: DateTime.parse(json['submittedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }
}
