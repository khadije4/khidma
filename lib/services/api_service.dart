import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/service_provider.dart';

class ApiService {
  // Base URL for the API
  final String baseUrl = 'http://your-api-domain.com/api';  // Change this to your actual API URL

  // Get token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Save token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Headers with token for authenticated requests
  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': token ?? '',
    };
  }

  // Headers for non-authenticated requests
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // Provider Authentication
  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: _getHeaders(),
        body: jsonEncode({
          'phone': phone,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['token'] != null) {
        await _saveToken(data['token']);
        return {'success': true, 'message': 'Login successful'};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Provider Registration
  Future<Map<String, dynamic>> register(ServiceProvider provider, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: _getHeaders(),
        body: jsonEncode({
          'name': provider.name,
          'phone': provider.phone,
          'password': password,
          'city': provider.city,
          'nni': provider.nni,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'message': data['message'], 'user_id': data['user_id']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Registration failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Get Provider Profile
  Future<ServiceProvider?> getProviderProfile() async {
    try {
      final headers = await _getAuthHeaders();

      final response = await http.get(
        Uri.parse('$baseUrl/provider/profile'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ServiceProvider(
          id: data['id'],
          name: data['name'],
          phone: data['phone'],
          city: data['city'],
          photoUrl: data['photo'] ?? '',
          service: data['service'] ?? '',
          spokenLanguages: List<String>.from(data['spoken_languages'] ?? []),
          servicePrice: (data['service_price'] is num) ? data['service_price'].toDouble() : 0.0,
          isAvailable: data['is_available'] ?? false,
          nni: data['nni'] ?? '',
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting provider profile: ${e.toString()}');
      return null;
    }
  }

  // Update Provider Profile
  Future<Map<String, dynamic>> updateProviderProfile(ServiceProvider provider) async {
    try {
      final headers = await _getAuthHeaders();

      final response = await http.put(
        Uri.parse('$baseUrl/provider/profile'),
        headers: headers,
        body: jsonEncode({
          'name': provider.name,
          'city': provider.city,
          'photo': provider.photoUrl,
          'service': provider.service,
          'spoken_languages': provider.spokenLanguages,
          'service_price': provider.servicePrice,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': data['message']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Update failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Update Availability Status
  Future<Map<String, dynamic>> updateAvailability(bool isAvailable) async {
    try {
      final headers = await _getAuthHeaders();

      final response = await http.put(
        Uri.parse('$baseUrl/provider/availability'),
        headers: headers,
        body: jsonEncode({
          'is_available': isAvailable,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': data['message']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Update failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  // Client API - Get Available Services
  Future<List<String>> getServices() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/services'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((service) => service.toString()).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting services: ${e.toString()}');
      return [];
    }
  }

  // Client API - Search Providers
  Future<List<ServiceProvider>> searchProviders({
    String? service,
    String? city,
    String? language,
  }) async {
    try {
      final queryParams = <String, String>{};

      if (service != null) queryParams['service'] = service;
      if (city != null) queryParams['city'] = city;
      if (language != null) queryParams['language'] = language;

      final uri = Uri.parse('$baseUrl/providers/search').replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ServiceProvider(
          id: json['id'],
          name: json['name'],
          phone: json['phone'],
          city: json['city'],
          nni: json['nni'] ?? '',
          photoUrl: json['photo'] ?? '',
          service: json['service'] ?? '',
          spokenLanguages: List<String>.from(json['spoken_languages'] ?? []),
          servicePrice: (json['service_price'] is num) ? json['service_price'].toDouble() : 0.0,
          isAvailable: json['is_available'] ?? false,
        )).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error searching providers: ${e.toString()}');
      return [];
    }
  }

  // Client API - Get Provider Details
  Future<ServiceProvider?> getProviderDetails(int providerId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/providers/$providerId'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ServiceProvider(
          id: data['id'],
          name: data['name'],
          phone: data['phone'],
          city: data['city'],
          photoUrl: data['photo'] ?? '',
          service: data['service'] ?? '',
          spokenLanguages: List<String>.from(data['spoken_languages'] ?? []),
          nni: data['nni'] ?? '',
          servicePrice: (data['service_price'] is num) ? data['service_price'].toDouble() : 0.0,
          isAvailable: data['is_available'] ?? false,
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting provider details: ${e.toString()}');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}