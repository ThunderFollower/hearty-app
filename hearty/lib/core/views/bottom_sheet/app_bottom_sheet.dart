import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../button/index.dart';
import '../theme/index.dart';

class AppBottomSheet extends StatelessWidget {
  final String imagePath;
  final String title;
  final String body;
  final String buttonText;
  final VoidCallback onTap;
  final double imagePadding;

  const AppBottomSheet({
    super.key,
    required this.imagePath,
    required this.title,
    required this.body,
    required this.buttonText,
    required this.onTap,
    this.imagePadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            imagePath,
            color: Colors.pink,
          ),
          SizedBox(height: imagePadding),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey[900],
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey[500],
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          RoundCornersButton(
            title: buttonText,
            onTap: () {
              context.router.pop();
              onTap();
            },
          ),
        ],
      ),
    );
  }
}
