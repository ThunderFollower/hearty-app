import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/views.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../providers.dart';

class NotesButton extends ConsumerWidget {
  final VoidCallback onButtonPressed;

  const NotesButton({super.key, required this.onButtonPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
            .watch(examinationStateProvider)
            .examination
            .value!
            .hasAdditionalInfo
        ? Stack(
            alignment: Alignment.center,
            children: [
              _buildButton(),
              Positioned(
                top: 0,
                right: 7,
                child: _buildNotification(),
              ),
            ],
          )
        : _buildButton();
  }

  Widget _buildButton() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            alignment: Alignment.center,
            fixedSize: const Size(0, 40),
          ),
          onPressed: onButtonPressed,
          child: const Stack(
            children: [
              Icon(AppIcons.edit, size: 20),
              Text(
                'notes_btn',
                style: TextStyle(fontSize: 0),
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
        Text(
          LocaleKeys.Info.tr(),
          style: TextStyle(
            fontSize: 14,
            color: AppColors.grey[900],
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildNotification() {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        border: Border.all(
          color: Colors.pink.shade100,
          width: 2.0,
        ),
      ),
      child: const Text(
        'notes_not_empty',
        style: TextStyle(fontSize: 0),
        overflow: TextOverflow.clip,
      ),
    );
  }
}
