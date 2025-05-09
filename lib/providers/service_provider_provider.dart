import 'package:flutter/foundation.dart';
import '../models/service_provider.dart';

class ServiceProviderProvider with ChangeNotifier {
  List<ServiceProvider> _providers = [];
  bool _isLoading = false;
  String? _selectedCategoryId;
  String? _selectedLanguage;
  String? _selectedCity; // Add selected city
  // Add this for the multi-language filter UI
  final List<String> _selectedLanguages = [];
  double? _maxPrice;

  List<ServiceProvider> get providers {
    // Keep your existing filter logic and add city filter
    return _providers.where((provider) {
      bool matchesCategory = _selectedCategoryId == null ||
          provider.services.any((service) => service == getCategoryNameById(_selectedCategoryId!));

      bool matchesLanguage = _selectedLanguage == null ||
          provider.spokenLanguages.contains(_selectedLanguage);

      bool matchesPrice = _maxPrice == null || provider.servicePrice <= _maxPrice!;

      bool matchesCity = _selectedCity == null ||
          provider.city.toLowerCase() == _selectedCity!.toLowerCase();

      return matchesCategory && matchesLanguage && matchesPrice && matchesCity && provider.isAvailable;
    }).toList();
  }

  bool get isLoading => _isLoading;

  String? get selectedCategoryId => _selectedCategoryId;
  String? get selectedLanguage => _selectedLanguage;
  String? get selectedCity => _selectedCity; // Add getter for selected city
  // Add this getter for the UI
  List<String> get selectedLanguages => _selectedLanguages;
  double? get maxPrice => _maxPrice;

  void setSelectedCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void setSelectedLanguage(String? language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void setSelectedCity(String? city) { // Add method for setting selected city
    _selectedCity = city;
    notifyListeners();
  }

  // Add these methods for the filter UI
  void addSelectedLanguage(String language) {
    if (!_selectedLanguages.contains(language)) {
      _selectedLanguages.add(language);
      // Don't actually filter by this yet - we'll handle the UI part
      notifyListeners();
    }
  }

  void removeSelectedLanguage(String language) {
    if (_selectedLanguages.contains(language)) {
      _selectedLanguages.remove(language);
      notifyListeners();
    }
  }

  void clearSelectedLanguages() {
    if (_selectedLanguages.isNotEmpty) {
      _selectedLanguages.clear();
      notifyListeners();
    }
  }

  void setMaxPrice(double? price) {
    _maxPrice = price;
    notifyListeners();
  }

  String getCategoryNameById(String id) {
    switch (id) {
      case '1': return 'Ménage mensuel';
      case '2': return 'Ménage ponctuel';
      case '3': return 'Plomberie';
      case '4': return 'Chauffeur';
      case '5': return 'Garde d\'enfants';
      default: return '';
    }
  }

  // Get a list of all available cities from providers
  List<String> get availableCities {
    Set<String> cities = {};
    for (var provider in _providers) {
      cities.add(provider.city.toLowerCase());
    }
    return cities.map((city) => city[0].toUpperCase() + city.substring(1)).toList();
  }

  ServiceProviderProvider() {
    loadProviders();
  }

  Future<void> loadProviders() async {
    _isLoading = true;
    notifyListeners();

    // Mock data (will connect to backend later)
    await Future.delayed(const Duration(seconds: 1));
    _providers = [
      ServiceProvider(
          id: '1',
          name: 'Ahmed Hassan',
          phone: '+22226123456',
          city: 'nouakchott',
          photoUrl: 'images/provider1.jpeg',
          services: ['Plomberie'],
          spokenLanguages: ['Arabe', 'Français', 'Pulaar'],
          servicePrice: 250.0,
          isAvailable: true,
          nni: '2222222222'
      ),
      ServiceProvider(
          id: '2',
          name: 'neye moulay',
          phone: '+22233091086',
          city: 'nouakchott',
          photoUrl: 'images/provider2.jpeg',
          services: ['Ménage mensuel', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français', 'woloof'],
          servicePrice: 200.0,
          isAvailable: true,
          nni: '1234444444'
      ),
      ServiceProvider(
          id: '3',
          name: 'mahmoud vadel',
          phone: '+22222937273',
          city: 'nouadhibou',
          photoUrl: 'images/provider3.jpeg',
          services: ['Chauffeur','Plomberie'],
          spokenLanguages: ['Arabe', 'Français', 'bambara'],
          servicePrice: 400.0,
          isAvailable: true,
          nni: '1111444477'
      ),
      ServiceProvider(
          id: '4',
          name: 'mina nasser',
          phone: '+22234453242',
          city: 'nouakchott',
          photoUrl: 'images/provider4.jpeg',
          services: ['Garde d\'enfants'],
          spokenLanguages: ['soninke', 'Français', 'pulaar'],
          servicePrice: 250.0,
          isAvailable: true,
          nni: '5343434342'
      ),
      ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),
      ServiceProvider(
          id: '6',
          name: 'ahmed mohsen',
          phone: '+2223347456&',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Chauffeur', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'pulaar'],
          servicePrice: 380.0,
          isAvailable: true,
          nni: '3245356677878'
      ),ServiceProvider(
          id: '7',
          name: 'amine karam',
          phone: '+22247152321',
          city: 'nouakchott',
          photoUrl: 'images/provider5.jpeg',
          services: ['Ménage mensuel', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français', 'woloof'],
          servicePrice: 250.0,
          isAvailable: true,
          nni: '322345377878'
      ),ServiceProvider(
          id: '8',
          name: 'sidi dalo',
          phone: '+22222277374',
          city: 'atar',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', ],
          spokenLanguages: ['Arabe', 'bambara'],
          servicePrice: 200.0,
          isAvailable: true,
          nni: '11115677878'
      ),ServiceProvider(
          id: '9',
          name: 'sidi mohamed',
          phone: '+22227867232',
          city: 'kiffa',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'chauffeur'],
          spokenLanguages: ['Arabe', 'Français','woloof'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),ServiceProvider(
          id: '5',
          name: 'oumlkheri ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider5.jpeg',
          services: ['Plomberie', 'Ménage ponctuel'],
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  ServiceProvider getProviderById(String id) {
    return _providers.firstWhere((provider) => provider.id == id);
  }
}