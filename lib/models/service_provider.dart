import 'package:flutter/foundation.dart';

class ServiceProvider {
  final String id;
  final String name;
  final String phone;
  final String city;
  final String photoUrl;
  final String service;
  final List<String> spokenLanguages;
  final double servicePrice;
  final bool isAvailable;
  final String nni; // National ID number or similar identifier

  ServiceProvider({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.photoUrl,
    required this.service,
    required this.spokenLanguages,
    required this.servicePrice,
    required this.isAvailable,
    required this.nni,
  });

  // Create a copy of the current instance with optional new values
  ServiceProvider copyWith({
    String? id,
    String? name,
    String? phone,
    String? city,
    String? photoUrl,
    String? service,
    List<String>? spokenLanguages,
    double? servicePrice,
    bool? isAvailable,
    String? nni,
  }) {
    return ServiceProvider(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      photoUrl: photoUrl ?? this.photoUrl,
      service: service ?? this.service,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      servicePrice: servicePrice ?? this.servicePrice,
      isAvailable: isAvailable ?? this.isAvailable,
      nni: nni ?? this.nni,
    );
  }

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'city': city,
      'photo': photoUrl,
      'service': service,
      'spoken_languages': spokenLanguages,
      'service_price': servicePrice,
      'is_available': isAvailable,
      'nni': nni,
    };
  }

  // Create model from JSON
  factory ServiceProvider.fromJson(Map<String, dynamic> json) {
    return ServiceProvider(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      photoUrl: json['photo'] ?? '',
      service: json['service'] ?? '',
      spokenLanguages: List<String>.from(json['spoken_languages'] ?? []),
      servicePrice: (json['service_price'] is num) ? json['service_price'].toDouble() : 0.0,
      isAvailable: json['is_available'] ?? false,
      nni: json['nni'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServiceProvider &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.city == city &&
        other.photoUrl == photoUrl &&
        other.service == service &&
        listEquals(other.spokenLanguages, spokenLanguages) &&
        other.servicePrice == servicePrice &&
        other.isAvailable == isAvailable &&
        other.nni == nni;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    phone.hashCode ^
    city.hashCode ^
    photoUrl.hashCode ^
    service.hashCode ^
    spokenLanguages.hashCode ^
    servicePrice.hashCode ^
    isAvailable.hashCode ^
    nni.hashCode;
  }
}