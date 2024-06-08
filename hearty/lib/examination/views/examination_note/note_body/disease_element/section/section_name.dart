import 'package:flutter/cupertino.dart';

import '../../../../../../core/views.dart';

class SectionName extends StatelessWidget {
  const SectionName({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        name,
        style: TextStyle(
          color: AppColors.grey[900],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
