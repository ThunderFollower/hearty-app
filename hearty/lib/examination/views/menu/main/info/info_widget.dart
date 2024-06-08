import 'package:flutter/material.dart';

import '../../../../../core/views.dart';

class InfoWidget extends StatelessWidget {
  final String title;

  const InfoWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.grey[900],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
