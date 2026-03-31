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
  final String nni; // Only for provider mode

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
}
