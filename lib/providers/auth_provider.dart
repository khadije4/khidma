import 'package:flutter/foundation.dart';
import '../models/service_provider.dart';

class AuthProvider with ChangeNotifier {
  ServiceProvider? _currentUser;
  bool _isLoading = false;
  String? _token;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _token != null;
  ServiceProvider? get currentUser => _currentUser;

  Future<bool> login(String phone, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Just mock login data for now (will connect to backend later)
    if (phone == '123456789' && password == 'password') {
      _token = 'mock_token';
      _currentUser = ServiceProvider(
        id: '1',
        name: 'ahmed salem',
        phone: phone,
        city: 'nouakchott',
        photoUrl: 'assets/images/avatar.png',
        services: ['Plomberie', 'Électricité'],
        spokenLanguages: ['Français', 'Arabe'],
        servicePrice: 300,
        isAvailable: true,
        nni: '1234567890',
      );

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> signup(ServiceProvider provider, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Just create a mock account for now
    _token = 'mock_token';
    _currentUser = provider;

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> toggleAvailability() async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Toggle availability (will connect to backend later)
    _currentUser = ServiceProvider(
      id: _currentUser!.id,
      name: _currentUser!.name,
      phone: _currentUser!.phone,
      city: _currentUser!.city,
      photoUrl: _currentUser!.photoUrl,
      services: _currentUser!.services,
      spokenLanguages: _currentUser!.spokenLanguages,
      servicePrice: _currentUser!.servicePrice,
      isAvailable: !_currentUser!.isAvailable,
      nni: _currentUser!.nni,
    );

    _isLoading = false;
    notifyListeners();
    return true;
  }
}