import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Mock user data - in a real app, this would come from your API
  String name = 'Amin Mohammed';
  String phone = '+222 45678901';
  String city = 'Nouakchott';
  String nni = '1234567890';
  List<String> services = ['Ménage mensuel', 'Ménage ponctuel'];
  List<String> languages = ['Français', 'Soninke', 'Pulaar'];
  bool isAvailable = true;
  double servicePrice = 500.0;
  String? profileImagePath;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _nniController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = name;
    _phoneController.text = phone;
    _cityController.text = city;
    _nniController.text = nni;
    _priceController.text = servicePrice.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _nniController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profileImagePath = image.path;
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Save profile data to backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              GestureDetector(
                onTap: _pickImage,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: profileImagePath != null
                            ? FileImage(File(profileImagePath!))
                            : const AssetImage('images/default_profile.png') as ImageProvider,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Availability Switch
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Disponibilité',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Switch(
                        value: isAvailable,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          setState(() {
                            isAvailable = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Personal Information
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informations personnelles',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nom complet',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre nom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Téléphone',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre numéro de téléphone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(
                          labelText: 'Ville',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_city),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre ville';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _nniController,
                        decoration: const InputDecoration(
                          labelText: 'NNI (Identité nationale)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.badge),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre NNI';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Service Information
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informations de service',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // Services dropdown
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Services proposés',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.work),
                        ),
                        value: services.isNotEmpty ? services[0] : null,
                        items: [
                          'Ménage mensuel',
                          'Ménage ponctuel',
                          'Plomberie',
                          'Chauffeur',
                          'Garde d\'enfants'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              services = [newValue]; // For simplicity, only one service
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Price input
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: 'Prix du service (MRU)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.money),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le prix de votre service';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Languages multi-select
                      FormField<List<String>>(
                        initialValue: languages,
                        builder: (FormFieldState<List<String>> state) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Langues parlées',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.language),
                            ),
                            child: Wrap(
                              spacing: 8.0,
                              children: [
                                ChoiceChip(
                                  label: const Text('Français'),
                                  selected: languages.contains('Français'),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        languages.add('Français');
                                      } else {
                                        languages.remove('Français');
                                      }
                                      state.didChange(languages);
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  label: const Text('Arabe'),
                                  selected: languages.contains('Arabe'),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        languages.add('Arabe');
                                      } else {
                                        languages.remove('Arabe');
                                      }
                                      state.didChange(languages);
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  label: const Text('pulaar'),
                                  selected: languages.contains('pulaar'),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        languages.add('pulaar');
                                      } else {
                                        languages.remove('pulaar');
                                      }
                                      state.didChange(languages);
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  label: const Text('soninke'),
                                  selected: languages.contains('soninke'),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        languages.add('soninke');
                                      } else {
                                        languages.remove('soninke');
                                      }
                                      state.didChange(languages);
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  label: const Text('wolof'),
                                  selected: languages.contains('wolof'),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        languages.add('wolof');
                                      } else {
                                        languages.remove('wolof');
                                      }
                                      state.didChange(languages);
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  label: const Text('bambara'),
                                  selected: languages.contains('bambara'),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        languages.add('bambara');
                                      } else {
                                        languages.remove('bambara');
                                      }
                                      state.didChange(languages);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Enregistrer les modifications',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Subscription Status
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Statut d\'abonnement',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.check_circle, color: Colors.green),
                        title: const Text('Abonnement actif'),
                        subtitle: const Text('Expire le 04 juin 2025'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Navigate to subscription renewal
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Renouveler'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}