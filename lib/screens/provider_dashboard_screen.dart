import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_theme.dart';
import '../providers/auth_provider.dart';
import '../models/service_provider.dart';
import '../widgets/job_request_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/availability_toggle.dart';

class ProviderDashboardScreen extends StatefulWidget {
  const ProviderDashboardScreen({Key? key}) : super(key: key);

  @override
  _ProviderDashboardScreenState createState() => _ProviderDashboardScreenState();
}

class _ProviderDashboardScreenState extends State<ProviderDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final ServiceProvider? provider = auth.currentUser as ServiceProvider?;

    if (provider == null) {
      // Not logged in or not a provider, redirect to login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // List of screens for bottom navigation
    final List<Widget> screens = [
      _buildHomeTab(provider),
      _buildJobsTab(provider),
      _buildProfileTab(provider),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
              Navigator.of(context).pushNamed('/notifications');
            },
          ),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.honoluluBlue,
        unselectedItemColor: AppColors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Tableau de bord',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Demandes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab(ServiceProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Message
          Card(
            color: AppColors.lightCyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(provider.photoUrl),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bienvenue, ${provider.name}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.federalBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              provider.service,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.marianBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AvailabilityToggle(
                    isAvailable: provider.isAvailable,
                    onToggle: (value) {
                      // Update availability in database
                      // This would be implemented in your auth provider
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Statistics Section
          const Text(
            'Vos statistiques',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.federalBlue,
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'Demandes',
                  value: '12',
                  icon: Icons.work,
                  color: AppColors.honoluluBlue,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatsCard(
                  title: 'Complétées',
                  value: '8',
                  icon: Icons.check_circle,
                  color: AppColors.pacificCyan,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'Évaluations',
                  value: '4.8',
                  icon: Icons.star,
                  color: AppColors.blueGreen,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatsCard(
                  title: 'Revenus',
                  value: '1200 MRU',
                  icon: Icons.monetization_on,
                  color: AppColors.vividSkyBlue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Recent Job Requests
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Demandes récentes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.federalBlue,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1; // Switch to Jobs tab
                  });
                },
                child: const Text('Voir tout'),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Sample job requests - in a real app, these would come from a database
          JobRequestCard(
            clientName: 'Fatima Zahra',
            service: 'Ménage mensuel',
            date: '10 Mai 2025',
            time: '14:00 - 17:00',
            address: 'nouakchott',
            price: '300 MRU',
            status: 'En attente',
            onAccept: () {
              // Accept job logic
            },
            onReject: () {
              // Reject job logic
            },
          ),
          const SizedBox(height: 10),
          JobRequestCard(
            clientName: 'Mohammed Ali',
            service: 'Plomberie',
            date: '12 Mai 2025',
            time: '10:00 - 12:00',
            address: 'Hay Hassani, Casablanca',
            price: '450 MRU',
            status: 'En attente',
            onAccept: () {
              // Accept job logic
            },
            onReject: () {
              // Reject job logic
            },
          ),
        ],
      ),
    );
  }

  Widget _buildJobsTab(ServiceProvider provider) {
    // We'll create three tabs for different job statuses
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: AppColors.honoluluBlue,
            unselectedLabelColor: AppColors.grey,
            tabs: [
              Tab(text: 'En attente'),
              Tab(text: 'Acceptées'),
              Tab(text: 'Complétées'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Pending jobs tab
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    JobRequestCard(
                      clientName: 'Fatima Zahra',
                      service: 'Ménage mensuel',
                      date: '10 Mai 2025',
                      time: '14:00 - 17:00',
                      address: 'Quartier Maarif, Casablanca',
                      price: '300 MRU',
                      status: 'En attente',
                      onAccept: () {
                        // Accept job logic
                      },
                      onReject: () {
                        // Reject job logic
                      },
                    ),
                    const SizedBox(height: 10),
                    JobRequestCard(
                      clientName: 'Mohammed Ali',
                      service: 'Plomberie',
                      date: '12 Mai 2025',
                      time: '10:00 - 12:00',
                      address: 'Hay Hassani, Casablanca',
                      price: '450 MRU',
                      status: 'En attente',
                      onAccept: () {
                        // Accept job logic
                      },
                      onReject: () {
                        // Reject job logic
                      },
                    ),
                  ],
                ),

                // Accepted jobs tab
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    JobRequestCard(
                      clientName: 'Yasmine El Amrani',
                      service: 'Garde d\'enfants',
                      date: '11 Mai 2025',
                      time: '09:00 - 14:00',
                      address: 'Anfa, Casablanca',
                      price: '500 MRU',
                      status: 'Acceptée',
                      onAccept: null,
                      onReject: null,
                      onComplete: () {
                        // Mark as complete logic
                      },
                    ),
                  ],
                ),

                // Completed jobs tab
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    JobRequestCard(
                      clientName: 'Karim Benjelloun',
                      service: 'Ménage ponctuel',
                      date: '05 Mai 2025',
                      time: '10:00 - 13:00',
                      address: 'Hay Mohammadi, Casablanca',
                      price: '250 MRU',
                      status: 'Complétée',
                      onAccept: null,
                      onReject: null,
                      rating: 5,
                    ),
                    const SizedBox(height: 10),
                    JobRequestCard(
                      clientName: 'Nadia Touhami',
                      service: 'Plomberie',
                      date: '03 Mai 2025',
                      time: '15:00 - 16:30',
                      address: 'Sidi Maârouf, Casablanca',
                      price: '350 MRU',
                      status: 'Complétée',
                      onAccept: null,
                      onReject: null,
                      rating: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab(ServiceProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Profile Photo
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(provider.photoUrl),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.honoluluBlue,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Add photo logic
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Name
          Text(
            provider.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.federalBlue,
            ),
          ),

          const SizedBox(height: 5),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 5),
              const Text(
                '4.8',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '(32 évaluations)',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Profile sections
          _buildProfileSection(
            title: 'Informations personnelles',
            children: [
              _buildProfileItem(Icons.phone, 'Téléphone', provider.phone),
              _buildProfileItem(Icons.location_city, 'Ville', provider.city),
              _buildProfileItem(Icons.badge, 'NNI', provider.nni),
            ],
          ),

          const SizedBox(height: 20),

          _buildProfileSection(
            title: 'Services proposés',
            children: [
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
              _buildProfileItem(
                  Icons.monetization_on,
                  'Tarif horaire',
                  '${provider.servicePrice} MRU/heure'
              ),
            ],
          ),

          const SizedBox(height: 20),

          _buildProfileSection(
            title: 'Langues parlées',
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: provider.spokenLanguages.map((language) {
                  return Chip(
                    backgroundColor: AppColors.nonPhotoBlue2,
                    label: Text(
                      language,
                      style: const TextStyle(color: AppColors.federalBlue),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to edit profile screen
                Navigator.of(context).pushNamed('/edit-profile');
              },
              icon: const Icon(Icons.edit),
              label: const Text('Modifier le profil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.honoluluBlue,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                // Logout logic
                await Provider.of<AuthProvider>(context, listen: false).logout();
                if (mounted) {
                  // Navigate to homepage instead of login
                  Navigator.of(context).pushReplacementNamed('/');
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Déconnexion'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProfileSection({required String title, required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.federalBlue,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.honoluluBlue,
            size: 20,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}