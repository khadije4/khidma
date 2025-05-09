import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class JobRequestCard extends StatelessWidget {
  final String clientName;
  final String service;
  final String date;
  final String time;
  final String address;
  final String price;
  final String status;
  final Function()? onAccept;
  final Function()? onReject;
  final Function()? onComplete;
  final int? rating;

  const JobRequestCard({
    Key? key,
    required this.clientName,
    required this.service,
    required this.date,
    required this.time,
    required this.address,
    required this.price,
    required this.status,
    this.onAccept,
    this.onReject,
    this.onComplete,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clientName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.federalBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.marianBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(status),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today, date),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.access_time, time),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_on, address),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.monetization_on, price),

            if (rating != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Évaluation: $rating/5',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],

            if (onAccept != null || onReject != null || onComplete != null) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onReject != null)
                    OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: const Text('Refuser'),
                    ),
                  if (onReject != null && (onAccept != null || onComplete != null))
                    const SizedBox(width: 10),
                  if (onAccept != null)
                    ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: const Text('Accepter'),
                    ),
                  if (onComplete != null)
                    ElevatedButton(
                      onPressed: onComplete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueGreen,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: const Text('Terminer'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.honoluluBlue,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'en attente':
        backgroundColor = Colors.amber.shade100;
        textColor = Colors.amber.shade800;
        break;
      case 'acceptée':
        backgroundColor = AppColors.lightCyan;
        textColor = AppColors.blueGreen;
        break;
      case 'complétée':
        backgroundColor = Colors.green.shade100;
        textColor = AppColors.success;
        break;
      case 'annulée':
        backgroundColor = Colors.red.shade100;
        textColor = AppColors.error;
        break;
      default:
        backgroundColor = AppColors.lightGrey;
        textColor = AppColors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}