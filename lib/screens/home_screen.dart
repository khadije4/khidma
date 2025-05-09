import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../providers/category_provider.dart';
import '../providers/service_provider_provider.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoryProvider>(context);
    final providerData = Provider.of<ServiceProviderProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.federalBlue,
                    AppColors.marianBlue,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'khidma',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Trouvez votre prestataire',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.person, color: Colors.white, size: 30),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/provider-login');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher un service...',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search, color: AppColors.honoluluBlue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Catégories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.federalBlue,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        // Clear any category filter and navigate to all providers
                        providerData.setSelectedCategory(null);
                        Navigator.of(context).pushNamed('/service-providers');
                      },
                    child: const Text('Voir tout'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: categoriesData.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: categoriesData.categories.length,
                  itemBuilder: (ctx, index) {
                    final category = categoriesData.categories[index];
                    return CategoryCard(
                      title: category.name,
                      description: category.description,
                      iconPath: category.iconPath, // Now using the iconPath from the category model
                      color: _getCategoryColor(index),
                      onTap: () {
                        providerData.setSelectedCategory(category.id);
                        Navigator.of(context).pushNamed('/service-providers');
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(int index) {
    final colors = [
      AppColors.federalBlue,
      AppColors.marianBlue,
      AppColors.honoluluBlue,
      AppColors.blueGreen,
      AppColors.pacificCyan,
    ];
    return colors[index % colors.length];
  }
}