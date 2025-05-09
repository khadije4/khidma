import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final Color color;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                color.withOpacity(0.7),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Try to load the image, if it fails, use a fallback icon
                _buildIcon(),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    // Choose a fallback icon based on category name
    IconData fallbackIcon = Icons.home_repair_service;

    if (title.toLowerCase().contains('ménage')) {
      fallbackIcon = Icons.cleaning_services;
    } else if (title.toLowerCase().contains('plomberie')) {
      fallbackIcon = Icons.plumbing;
    } else if (title.toLowerCase().contains('chauffeur')) {
      fallbackIcon = Icons.drive_eta;
    } else if (title.toLowerCase().contains('garde')) {
      fallbackIcon = Icons.child_care;
    }

    return Image.asset(
      iconPath,
      width: 40,
      height: 40,
      color: Colors.white,
      errorBuilder: (context, error, stackTrace) {
        // If image fails to load, use a fallback icon
        return Icon(
          fallbackIcon,
          size: 40,
          color: Colors.white,
        );
      },
    );
  }
}