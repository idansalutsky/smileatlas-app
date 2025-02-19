import 'dental_analysis.dart';

class UserModel {
  final String id;
  final String name;
  final String profileImage;
  final DentalAnalysis? latestAnalysis;

  UserModel({
    required this.id,
    required this.name,
    required this.profileImage,
    this.latestAnalysis,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImage: json['profileImage'] as String,
      latestAnalysis: json['latestAnalysis'] != null
          ? DentalAnalysis.fromJson(json['latestAnalysis'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'latestAnalysis': latestAnalysis?.toJson(),
    };
  }
}
