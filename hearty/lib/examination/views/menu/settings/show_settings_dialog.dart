import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';

Future<bool?> showSettingsDialog({
  required BuildContext context,
  required String title,
  required String body,
  required String iconPath,
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
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                  ),
                  child: AppBottomSheet(
                    imagePath: iconPath,
                    title: title,
                    body: body,
                    buttonText: LocaleKeys.Open_Settings.tr(),
                    onTap: onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
