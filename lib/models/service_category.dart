class ServiceCategory {
  final String id;
  final String name;
  final String description;
  final String type; // 'Récurrent', 'Ponctuel', or 'Ponctuel/Régulier'
  final String iconPath;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.iconPath,
  });
}