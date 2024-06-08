import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../state/landing_state_provider.dart';

/// A custom button that, when clicked, opens the legal documents.
class LegalDocumentsButtonWidget extends ConsumerWidget {
  const LegalDocumentsButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(landingStateProvider.notifier);

    return AppTextButton(
      onPressed: controller.openLegalDocuments,
      key: _legalDocBtnKey,
      child: Text(LocaleKeys.Landing_LegalDocuments.tr()),
    );
  }
}

const _legalDocBtnKey = Key('legal_docs_btn');
