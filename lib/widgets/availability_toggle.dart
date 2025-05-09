import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class AvailabilityToggle extends StatelessWidget {
  final bool isAvailable;
  final Function(bool) onToggle;

  const AvailabilityToggle({
    Key? key,
    required this.isAvailable,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAvailable ? AppColors.lightCyan : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isAvailable ? 'Disponible' : 'Non disponible',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isAvailable ? AppColors.success : AppColors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isAvailable
                    ? 'Vous êtes visible pour les clients'
                    : 'Vous n\'êtes pas visible pour les clients',
                style: TextStyle(
                  fontSize: 13,
                  color: isAvailable ? AppColors.success : AppColors.grey,
                ),
              ),
            ],
          ),
          Switch(
            value: isAvailable,
            onChanged: onToggle,
            activeColor: AppColors.success,
            activeTrackColor: AppColors.vividSkyBlue,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.lightGrey,
          ),
        ],
      ),
    );
  }
}