import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth.dart';
import 'account_list_state.dart';
import 'choose_account_controller.dart';
import 'choose_account_controller_provider.dart';
import 'choose_account_list_view_item.dart';

/// A dialog that allows the user to select an account.
class ChooseAccountDialog extends ConsumerStatefulWidget {
  /// Create a modal dialog that allows the user to select an account.
  ///
  /// Returns a [Future] that resolves to the selected account or null
  ///  if the user canceled the dialog.
  static Future<Credentials?> showModal(BuildContext context) {
    return showModalDialog(
      context: context,
      child: ChooseAccountDialog(),
    );
  }

  @override
  ConsumerState createState() => _ChooseAccountDialogState();
}

/// A state of a [ChooseAccountDialog].
class _ChooseAccountDialogState extends ConsumerState<ChooseAccountDialog> {
  final Logger logger = Logger();
  late final StreamSubscription? subscription;

  late AccountListState accountList;
  late ChooseAccountController controller;

  @override
  void initState() {
    super.initState();

    // Load the account list. If it is empty, dismiss the dialog.
    accountList = const AsyncValue.loading();
    controller = ref.read(chooseAccountControllerProvider);

    subscription = controller.allAccounts().takeWhile((_) => mounted).listen(
      (accounts) {
        setState(() => accountList = AsyncValue.data(accounts));
        if (accounts.isEmpty) controller.dismiss();
      },
      onError: (Object error) {
        setState(
          () => accountList = AsyncValue.error(
            error,
            StackTrace.current,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(chooseAccountControllerProvider);
    return accountList.when(
      data: (value) => root(value),
      error: error,
      loading: loading,
    );
  }

  /// Returns a widget that displays an error message.
  Widget error(dynamic error, StackTrace? stack) {
    logger.e('Oops', error, stack);
    return const Center(
      child: Text('Oops, something unexpected happened'),
    );
  }

  /// Returns a widget that displays a loading indicator.
  Widget loading() => const CircularProgressIndicator();

  /// Returns the root widget of the dialog.
  Widget root(List<Credentials> value) => Column(
        children: [
          title(),
          const SizedBox(height: aboveLowIndent),
          listView(value),
          const SizedBox(height: belowMediumIndent),
        ],
      );

  /// Returns a widget that displays a title.
  Text title() =>
      Text(LocaleKeys.Select_Account.tr(), style: textStyleOfPageTitle);

  /// Returns a widget that displays a list of accounts.
  ListView listView(List<Credentials> value) => ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: value.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => listViewItem(value[index]),
        separatorBuilder: (_, __) => const SizedBox(height: belowLowIndent),
      );

  /// Returns a list view item.
  ChooseAccountListViewItem listViewItem(Credentials account) =>
      ChooseAccountListViewItem(
        title: account.login,
        onTap: () => controller.dismiss(account),
        onDeleteTap: () => controller.removeAccount(account),
      );
}
