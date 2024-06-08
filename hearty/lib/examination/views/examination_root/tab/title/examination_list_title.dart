import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app_router.gr.dart';
import '../../../../../core/views.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../examination_list_controller.dart';

class ExaminationListTitle extends ConsumerWidget {
  const ExaminationListTitle({super.key, required this.examinationId});

  final String examinationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasExaminations = ref.watch(
      examinationListController.select((state) => state.hasExaminations),
    );

    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              LocaleKeys.Examinations.tr(),
              style: TextStyle(
                fontSize: 18,
                color: AppColors.grey[900],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (hasExaminations)
            ElevatedButton(
              key: const Key('add_examination_btn'),
              onPressed: () {
                context.router.push(
                  ExaminationRoute(examinationId: examinationId),
                );
              },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: Colors.transparent,
                fixedSize: const Size.fromRadius(24),
                shape: const CircleBorder(),
                elevation: 0,
                padding: EdgeInsets.zero,
              ),
              child: Stack(
                children: [
                  Ink(
                    decoration: BoxDecoration(
                      gradient: AppGradients.blue1,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: AppLocator(
                        id: 'new_examination_btn',
                        child: Icon(
                          AppIcons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
