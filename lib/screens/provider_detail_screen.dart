import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/service_provider.dart';
import '../providers/service_provider_provider.dart';
import '../utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderDetailScreen extends StatelessWidget {
  const ProviderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerId = ModalRoute.of(context)!.settings.arguments as String;
    final providersData = Provider.of<ServiceProviderProvider>(context, listen: false);
    final provider = providersData.getProviderById(providerId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.federalBlue,
                          AppColors.honoluluBlue,
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              provider.photoUrl,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error for ${provider.photoUrl}');
                                return const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: AppColors.honoluluBlue,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          provider.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            icon: Icons.phone,
                            title: 'Téléphone',
                            value: provider.phone,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.location_on,
                            title: 'Ville',
                            value: provider.city,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.language,
                            title: 'Langues',
                            value: provider.spokenLanguages.join(', '),
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.monetization_on,
                            title: 'Prix',
                            value: '${provider.servicePrice.toStringAsFixed(0)} MRU',
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.event_available,
                            title: 'Disponibilité',
                            value: provider.isAvailable ? 'Disponible' : 'Indisponible',
                            valueColor: provider.isAvailable
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Services proposés',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        backgroundColor: AppColors.lightCyan,
                        label: Text(
                          provider.service,
                          style: const TextStyle(color: AppColors.federalBlue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.phone),
                label: const Text('Appeler'),
                onPressed: () => _makePhoneCall(provider.phone),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.honoluluBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.message),
                label: const Text('SMS'),
                onPressed: () => _sendSMS(provider.phone),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pacificCyan,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.honoluluBlue,
            size: 20,
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendSMS(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}