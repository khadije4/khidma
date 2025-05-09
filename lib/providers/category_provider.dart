import 'package:flutter/foundation.dart';
import '../models/service_category.dart';

class CategoryProvider with ChangeNotifier {
  List<ServiceCategory> _categories = [];
  bool _isLoading = false;

  List<ServiceCategory> get categories => [..._categories];
  bool get isLoading => _isLoading;

  CategoryProvider() {
    loadCategories();
  }

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    // Mock data (will connect to backend later)
    await Future.delayed(const Duration(seconds: 1));
    _categories = [
      ServiceCategory(
        id: '1',
        name: 'Ménage mensuel',
        description: 'Service régulier de nettoyage',
        type: 'Récurrent',
        iconPath: 'icons/cleaning.png',
      ),
      ServiceCategory(
        id: '2',
        name: 'Ménage ponctuel',
        description: 'Intervention unique',
        type: 'Ponctuel',
        iconPath: 'icons/cleaning_once.png',
      ),
      ServiceCategory(
        id: '3',
        name: 'Plomberie',
        description: 'Réparation et installation',
        type: 'Ponctuel',
        iconPath: 'icons/plumbing.png',
      ),
      ServiceCategory(
        id: '4',
        name: 'Chauffeur',
        description: 'Transport privé',
        type: 'Ponctuel/Régulier',
        iconPath: 'icons/driver.png',
      ),
      ServiceCategory(
        id: '5',
        name: 'Garde d\'enfants',
        description: 'Babysitting',
        type: 'Ponctuel/Régulier',
        iconPath: 'icons/babysitting.png',

      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}