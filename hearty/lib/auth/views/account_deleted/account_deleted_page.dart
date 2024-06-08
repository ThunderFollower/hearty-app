import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import 'config/post_account_delete_controller_provider.dart';

@RoutePage()
class AccountDeletedPage extends ConsumerWidget {
  const AccountDeletedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(postAccountDeleteControllerProvider);
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LocalImage(assetPath: _successAssetPath),
              const SizedBox(height: 16),
              Text(
                LocaleKeys.Account_has_been_deleted.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.pink,
                ),
              ),
              RoundCornersButton(
                title: LocaleKeys.Done.tr(),
                onTap: controller.onDoneTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _successAssetPath = 'assets/images/success.svg';
