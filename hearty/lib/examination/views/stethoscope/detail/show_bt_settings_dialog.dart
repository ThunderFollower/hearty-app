import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/views.dart';

Future<bool?> showBtSettingsDialog({
  required BuildContext context,
  required String title,
  required String body,
  String buttonText = 'Open Settings',
  required VoidCallback onTap,
}) =>
    showModalBottomSheet<bool>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: context.router.pop,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const TopStripe(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 10.0,
                    top: 7.0,
                  ),
                  padding: const EdgeInsets.only(
                    top: 51,
                    bottom: 24,
                    left: 24,
                    right: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                  ),
                  child: AppBottomSheet(
                    imagePath: 'assets/images/bt_headphones.svg',
                    title: title,
                    body: body,
                    buttonText: buttonText,
                    onTap: onTap,
                    imagePadding: 26,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
