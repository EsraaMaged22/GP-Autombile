


class UserModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String nationalId;
  final String address;
  final String licenseNumber;
  final int numberOfCars;
  final String carDashboard;

  // Constructor for UserModel
  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.nationalId,
    required this.address,
    required this.licenseNumber,
    required this.numberOfCars,
    required this.carDashboard,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      nationalId: json['nationalId'] ?? '',
      address: json['address'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      numberOfCars: json['numberOfCars'] ?? 0,
      carDashboard: json['carDashboard'] ?? '',
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'nationalId': nationalId,
      'address': address,
      'licenseNumber': licenseNumber,
      'numberOfCars': numberOfCars,
      'carDashboard': carDashboard,
    };
  }
}