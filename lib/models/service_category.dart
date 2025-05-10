class ServiceCategory {
  final String id;
  final String name;
  final String description;
  final String type;
  final String iconPath;

  ServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.iconPath,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      iconPath: json['icon_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'icon_path': iconPath,
    };
  }
}