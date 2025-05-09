import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../providers/service_provider_provider.dart';
import '../widgets/provider_card.dart';

class ServiceProvidersScreen extends StatelessWidget {
  const ServiceProvidersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providersData = Provider.of<ServiceProviderProvider>(context);
    final selectedCategoryName = providersData.selectedCategoryId != null
        ? providersData.getCategoryNameById(providersData.selectedCategoryId!)
        : 'Tous les prestataires';

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategoryName),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: AppColors.lightGrey.withOpacity(0.5),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher un prestataire...',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    _showFilterBottomSheet(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: providersData.isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : providersData.providers.isEmpty
                ? const Center(
              child: Text(
                'Aucun prestataire disponible',
                style: TextStyle(fontSize: 16),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: providersData.providers.length,
              itemBuilder: (ctx, index) {
                final provider = providersData.providers[index];
                return ProviderCard(
                  provider: provider,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/provider-detail',
                      arguments: provider.id,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final providersData = Provider.of<ServiceProviderProvider>(context, listen: false);

    // Updated languages list with local languages
    final languages = ['Arabe', 'Français', 'pulaar', 'soninke', 'wolof', 'bambara'];

    // List of cities
    final cities = ['Nouakchott', 'Nouadhibou', 'Kiffa', 'Kaédi', 'Rosso', 'Zouérat', 'Atar', 'Néma'];

    // Track selected languages locally in the bottom sheet
    List<String> tempSelectedLanguages = [];
    String? currentSelectedLanguage = providersData.selectedLanguage;
    if (currentSelectedLanguage != null) {
      tempSelectedLanguages.add(currentSelectedLanguage);
    }

    // Track selected cities locally in the bottom sheet
    List<String> tempSelectedCities = [];
    String? currentSelectedCity = providersData.selectedCity;
    if (currentSelectedCity != null) {
      tempSelectedCities.add(currentSelectedCity);
    }

    double currentMaxPrice = providersData.maxPrice ?? 500;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.75, // Increased height to accommodate the new filter
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filtres',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Prix maximum',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: currentMaxPrice,
                    min: 0,
                    max: 500,
                    divisions: 30,
                    label: '${currentMaxPrice.toStringAsFixed(0)} MRU',
                    onChanged: (newValue) {
                      setState(() {
                        currentMaxPrice = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Langues parlées',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      FilterChip(
                        label: const Text('Toutes'),
                        selected: tempSelectedLanguages.isEmpty,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              tempSelectedLanguages.clear();
                            });
                          }
                        },
                      ),
                      ...languages.map((lang) {
                        return FilterChip(
                          label: Text(lang),
                          selected: tempSelectedLanguages.contains(lang),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                // Clear previous selection since we only support one language
                                tempSelectedLanguages.clear();
                                tempSelectedLanguages.add(lang);
                              } else {
                                tempSelectedLanguages.remove(lang);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ],
                  ),

                  // Add City Filter
                  const SizedBox(height: 20),
                  const Text(
                    'Ville',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: [
                      FilterChip(
                        label: const Text('Toutes'),
                        selected: tempSelectedCities.isEmpty,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              tempSelectedCities.clear();
                            });
                          }
                        },
                      ),
                      ...cities.map((city) {
                        return FilterChip(
                          label: Text(city),
                          selected: tempSelectedCities.contains(city),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                // Clear previous selection since we only support one city
                                tempSelectedCities.clear();
                                tempSelectedCities.add(city);
                              } else {
                                tempSelectedCities.remove(city);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ],
                  ),

                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply filters
                        providersData.setMaxPrice(currentMaxPrice);
                        providersData.setSelectedLanguage(
                            tempSelectedLanguages.isEmpty ? null : tempSelectedLanguages.first
                        );
                        providersData.setSelectedCity(
                            tempSelectedCities.isEmpty ? null : tempSelectedCities.first
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text('Appliquer'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}