import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/service_provider.dart';
import '../utils/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  ServiceProvider? _currentUser;
  bool _isLoading = false;
  String? _token;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _token != null;
  ServiceProvider? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  // Initialize auth state from SharedPreferences
  Future<void> initAuth() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      _token = token;
      await _fetchUserProfile();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Login to the API
  Future<bool> login(String phone, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': phone,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _token = responseData['token'];

        // Save token to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('auth_token', _token!);

        // Fetch user profile with the new token
        await _fetchUserProfile();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = responseData['message'] ?? 'Authentication failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Network error: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Register a new user
  Future<bool> signup(ServiceProvider provider, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': provider.name,
          'phone': provider.phone,
          'password': password,
          'city': provider.city,
          'nni': provider.nni,
          // Optional fields
          'service': provider.service,
          'spoken_languages': provider.spokenLanguages.join(','),
          'service_price': provider.servicePrice,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Registration successful, now login
        return await login(provider.phone, password);
      } else {
        _errorMessage = responseData['message'] ?? 'Registration failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Network error: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Fetch user profile
  Future<bool> _fetchUserProfile() async {
    if (_token == null) return false;

    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/api/provider/profile'),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': _token!,
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);

        // Create ServiceProvider object from API response
        _currentUser = ServiceProvider.fromJson(userData);
        notifyListeners();
        return true;
      } else {
        // Token might be invalid, clear it
        await logout();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Network error: ${e.toString()}';
      return false;
    }
  }

  // Update user profile
  Future<bool> updateProfile(ServiceProvider updatedProvider) async {
    if (_token == null || _currentUser == null) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}/api/provider/profile'),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': _token!,
        },
        body: jsonEncode({
          'name': updatedProvider.name,
          'city': updatedProvider.city,
          'photo': updatedProvider.photoUrl,
          'service': updatedProvider.service,
          'spoken_languages': updatedProvider.spokenLanguages,
          'service_price': updatedProvider.servicePrice,
          'is_available': updatedProvider.isAvailable,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Update successful, refresh user data
        _currentUser = updatedProvider;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = responseData['message'] ?? 'Update failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Network error: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Toggle service provider availability
  Future<bool> toggleAvailability() async {
    if (_token == null || _currentUser == null) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}/api/provider/availability'),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': _token!,
        },
        body: jsonEncode({
          'is_available': !_currentUser!.isAvailable,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Update successful, update local state
        _currentUser = _currentUser!.copyWith(
          isAvailable: !_currentUser!.isAvailable,
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = responseData['message'] ?? 'Update failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Network error: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    _token = null;
    _currentUser = null;

    // Clear stored token
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');

    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}