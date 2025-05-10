class ApiConstants {
  // Base URL for the Flask API
  static const String baseUrl = 'http://10.0.2.2:5000'; // For Android emulator accessing local Flask server

  // Alternative URLs for different environments
  static const String localUrl = 'http://localhost:5000';
  static const String productionUrl = 'https://api.khidma-app.com'; // Replace with your production URL when deployed

  // API endpoints
  static const String loginEndpoint = '/api/auth/login';
  static const String registerEndpoint = '/api/auth/register';
  static const String profileEndpoint = '/api/provider/profile';
  static const String availabilityEndpoint = '/api/provider/availability';
  static const String servicesEndpoint = '/api/services';
  static const String providersSearchEndpoint = '/api/providers/search';

  // Header keys
  static const String authHeader = 'x-access-token';
  static const String contentTypeHeader = 'Content-Type';
  static const String contentTypeJson = 'application/json';
}