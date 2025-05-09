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
          provider.service == getCategoryNameById(_selectedCategoryId!);

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
          service: 'Plomberie',
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
          service: 'Ménage mensuel',
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
          service: 'Chauffeur',
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
          service: 'Garde d\'enfants',
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
          service: 'Plomberie',
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
          photoUrl: 'images/provider6.jpeg',
          service: 'Chauffeur',
          spokenLanguages: ['Arabe', 'pulaar'],
          servicePrice: 380.0,
          isAvailable: true,
          nni: '3245356677878'
      ),
      ServiceProvider(
          id: '7',
          name: 'amine karam',
          phone: '+22247152321',
          city: 'nouakchott',
          photoUrl: 'images/provider7.jpeg',
          service: 'Ménage mensuel',
          spokenLanguages: ['Arabe', 'Français', 'woloof'],
          servicePrice: 250.0,
          isAvailable: true,
          nni: '322345377878'
      ),
      ServiceProvider(
          id: '8',
          name: 'sidi dalo',
          phone: '+22222277374',
          city: 'atar',
          photoUrl: 'images/provider8.jpeg',
          service: 'Plomberie',
          spokenLanguages: ['Arabe', 'bambara'],
          servicePrice: 200.0,
          isAvailable: true,
          nni: '11115677878'
      ),
      ServiceProvider(
          id: '9',
          name: 'sidi mohamed',
          phone: '+22227867232',
          city: 'kiffa',
          photoUrl: 'images/provider14.jpeg',
          service: 'Plomberie',
          spokenLanguages: ['Arabe', 'Français','woloof'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455677878'
      ),
      ServiceProvider(
          id: '10',
          name: 'mariem ahmed',
          phone: '+22230515163',
          city: 'nouadhibou',
          photoUrl: 'images/provider10.jpeg',
          service: 'Plomberie',
          spokenLanguages: ['Arabe', 'Français'],
          servicePrice: 180.0,
          isAvailable: true,
          nni: '32455997878'
      ),
    ServiceProvider(
    id: '11',
    name: 'Ahmed Ould Salem',
    phone: '+22230000111',
    city: 'nouakchott',
    photoUrl: 'images/provider11.jpeg',
    service: 'Plomberie',
    spokenLanguages: ['Arabe'],
    servicePrice: 180.0,
    isAvailable: true,
    nni: '20000000011',
    ),
    ServiceProvider(
    id: '12',
    name: 'Fatou Diop',
    phone: '+22230000112',
    city: 'nouadhibo',
    photoUrl: 'images/provider12.jpeg',
    service: 'Ménage ponctuel',
    spokenLanguages: ['Français'],
    servicePrice: 170.0,
    isAvailable: true,
    nni: '20000000012',
    ),
    ServiceProvider(
    id: '13',
    name: 'Baba Sy',
    phone: '+22230000113',
    city: 'rosso',
    photoUrl: 'images/provider13.jpeg',
    service: 'Chauffeur',
    spokenLanguages: ['Arabe', 'Français'],
    servicePrice: 200.0,
    isAvailable: true,
    nni: '20000000013',
    ),
    ServiceProvider(
    id: '14',
    name: 'Mariam Mint Sidi',
    phone: '+22230000114',
    city: 'kiffa',
    photoUrl: 'images/provider9.jpeg',
    service: 'Ménage mensuel',
    spokenLanguages: ['Français'],
    servicePrice: 160.0,
    isAvailable: true,
    nni: '20000000014',
    ),
    ServiceProvider(
    id: '15',
    name: 'Oumar Sow',
    phone: '+22230000115',
    city: 'atar',
    photoUrl: 'images/provider15.jpeg',
    service: 'Chauffeur',
    spokenLanguages: ['Arabe'],
    servicePrice: 190.0,
    isAvailable: true,
    nni: '20000000015',
    ),
    ServiceProvider(
    id: '16',
    name: 'Awa Kane',
    phone: '+22230000116',
    city: 'bogue',
    photoUrl: 'images/provider16.jpeg',
    service: 'Ménage ponctuel',
    spokenLanguages: ['Français'],
    servicePrice: 170.0,
    isAvailable: true,
    nni: '20000000016',
    ),
    ServiceProvider(
    id: '17',
    name: 'Cheikh Ould Bouna',
    phone: '+22230000117',
    city: 'nouadhibo',
    photoUrl: 'images/provider26.jpeg',
    service: 'Chauffeur',
    spokenLanguages: ['Arabe'],
    servicePrice: 210.0,
    isAvailable: true,
    nni: '20000000017',
    ),
    ServiceProvider(
    id: '18',
    name: 'Zeinab Mint Ahmed',
    phone: '+22230000118',
    city: 'bogue',
    photoUrl: 'images/provider18.jpeg',
    service: 'Garde d\'enfants',
    spokenLanguages: ['Français'],
    servicePrice: 165.0,
    isAvailable: true,
    nni: '20000000018',
    ),
    ServiceProvider(
    id: '19',
    name: 'Mohamed Abdallahi',
    phone: '+22230000119',
    city: 'kiffa',
    photoUrl: 'images/provider20.jpeg',
    service: 'Plomberie',
    spokenLanguages: ['Arabe'],
    servicePrice: 180.0,
    isAvailable: true,
    nni: '20000000019',
    ),
    ServiceProvider(
    id: '20',
    name: 'Hawa Fall',
    phone: '+22230000120',
    city: 'nouakchott',
    photoUrl: 'images/provider19.jpeg',
    service: 'Ménage mensuel',
    spokenLanguages: ['Français'],
    servicePrice: 160.0,
    isAvailable: true,
    nni: '20000000020',
    ),
    ServiceProvider(
    id: '21',
    name: 'Youssouf Diallo',
    phone: '+22230000121',
    city: 'rosso',
    photoUrl: 'images/provider21.jpeg',
    service: 'Plomberie',
    spokenLanguages: ['Pulaar'],
    servicePrice: 195.0,
    isAvailable: true,
    nni: '20000000021',
    ),
    ServiceProvider(
    id: '22',
    name: 'ahmed Saleh',
    phone: '+22230000122',
    city: 'atar',
    photoUrl: 'images/provider22.jpeg',
    service: 'Ménage ponctuel',
    spokenLanguages: ['Arabe', 'Français'],
    servicePrice: 170.0,
    isAvailable: true,
    nni: '20000000022',
    ),
    ServiceProvider(
    id: '23',
    name: 'Moussa Traoré',
    phone: '+22230000123',
    city: 'nouakchott',
    photoUrl: 'images/provider24.jpeg',
    service: 'Garde d\'enfants',
    spokenLanguages: ['Français'],
    servicePrice: 175.0,
    isAvailable: true,
    nni: '20000000023',
    ),
    ServiceProvider(
    id: '24',
    name: 'Aminata Dia',
    phone: '+22230000124',
    city: 'bogue',
    photoUrl: 'images/provider23.jpeg',
    service: 'Ménage mensuel',
    spokenLanguages: ['Soninké', 'Français'],
    servicePrice: 165.0,
    isAvailable: true,
    nni: '20000000024',
    ),
    ServiceProvider(
    id: '25',
    name: 'Elhassan Ould Taleb',
    phone: '+22230000125',
    city: 'nouadhibo',
    photoUrl: 'images/provider25.jpeg',
    service: 'Plomberie',
    spokenLanguages: ['Arabe'],
    servicePrice: 185.0,
    isAvailable: true,
    nni: '20000000025',
    ),
    ServiceProvider(
    id: '26',
    name: 'Salimata Ba',
    phone: '+22230000126',
    city: 'kiffa',
    photoUrl: 'images/provider17.jpeg',
    service: 'Garde d\'enfants',
    spokenLanguages: ['Français'],
    servicePrice: 180.0,
    isAvailable: true,
    nni: '20000000026',
    ),
    ServiceProvider(
    id: '27',
    name: 'Idrissa Sow',
    phone: '+22230000127',
    city: 'rosso',
    photoUrl: 'images/provider28.jpeg',
    service: 'Chauffeur',
    spokenLanguages: ['Pulaar'],
    servicePrice: 200.0,
    isAvailable: true,
    nni: '20000000027',
    ),
    ServiceProvider(
    id: '28',
    name: 'Nassr  Abdou',
    phone: '+22230000128',
    city: 'atar',
    photoUrl: 'images/provider30.jpeg',
    service: 'Ménage mensuel',
    spokenLanguages: ['Arabe', 'Français'],
    servicePrice: 160.0,
    isAvailable: true,
    nni: '20000000028',
    ),
    ServiceProvider(
    id: '29',
    name: 'Alioune Gaye',
    phone: '+22230000129',
    city: 'nouakchott',
    photoUrl: 'images/provider29.jpeg',
    service: 'Plomberie',
    spokenLanguages: ['Français'],
    servicePrice: 190.0,
    isAvailable: true,
    nni: '20000000029',
    ),
    ServiceProvider(
    id: '30',
    name: 'Seynabou Ndiaye',
    phone: '+22230000130',
    city: 'nouadhibo',
    photoUrl: 'images/provider27.jpeg',
    service: 'Garde d\'enfants',
    spokenLanguages: ['Français'],
    servicePrice: 175.0,
    isAvailable: true,
    nni: '20000000030',
    ),


    ];

    _isLoading = false;
    notifyListeners();
  }

  ServiceProvider getProviderById(String id) {
    return _providers.firstWhere((provider) => provider.id == id);
  }
}