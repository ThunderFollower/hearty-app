import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import 'examination_report_controller.dart';
import 'examination_report_state.dart';
import 'items/disclaimer/disclaimer.dart';
import 'items/empty_report.dart';
import 'items/record_tile/record_tile.dart';
import 'providers.dart';

@RoutePage()
class ExaminationReportPage extends ConsumerWidget {
  const ExaminationReportPage({
    @PathParam(examinationIdParam) this.examinationId,
  });

  final String? examinationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationReportStateProvider(examinationId);
    final state = ref.watch(provider);
    final controller = ref.watch(provider.notifier);

    return AppScaffold(
      appBar: _AppBar(closeReport: controller.dismiss),
      body: _Content(state: state, controller: controller),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.state,
    required this.controller,
  });

  final ExaminationReportState state;
  final ExaminationReportController controller;

  @override
  Widget build(BuildContext context) {
    final ids = state.recordIds;
    if (ids == null) return const Loader();

    return ids.isNotEmpty
        ? _Body(
            recordIds: ids,
            amountOfHeartSpots: state.amountOfHeartSpots ?? 0,
            controller: controller,
          )
        : const EmptyReport();
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.recordIds,
    required this.amountOfHeartSpots,
    required this.controller,
  });

  final Iterable<String> recordIds;
  final int amountOfHeartSpots;
  final ExaminationReportController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: _padding,
        child: _buildBody(recordIds, theme),
      ),
    );
  }

  Widget _buildBody(Iterable<String> recordIds, ThemeData theme) => Column(
        children: [
          Padding(
            padding: _heartRecordsAmountPadding,
            child: _buildAmountOfHeartRecords(
              recordIds.length,
              amountOfHeartSpots,
              theme,
            ),
          ),
          Expanded(child: _buildListView(recordIds)),
          Padding(padding: _buttonPadding, child: _buildButton()),
        ],
      );

  Widget _buildListView(Iterable<String> recordIds) => ListView(
        primary: true,
        children: [
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (_, index) => RecordTile(
              recordId: recordIds.elementAt(index),
            ),
            separatorBuilder: (_, __) => const SizedBox(height: lowestIndent),
            itemCount: recordIds.length,
          ),
          const SizedBox(height: _indentBetweenButtonAndDisclaimer),
          Disclaimer(onOpenGuide: controller.openGuide),
        ],
      );

  Widget _buildButton() => RoundCornersButton(
        onTap: controller.share,
        title: LocaleKeys.ExaminationReport_Send_Examination.tr(),
      );

  Widget _buildAmountOfHeartRecords(
    int recordsAmount,
    int heartSpotsAmount,
    ThemeData theme,
  ) {
    final iconColor = theme.colorScheme.onPrimary;
    final textColor = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.labelMedium?.copyWith(color: textColor);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(AppIcons.heart, size: lowIndent, color: iconColor),
        const SizedBox(width: _tinyIndent),
        Text('$recordsAmount/$heartSpotsAmount', style: textStyle),
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.closeReport});

  final void Function() closeReport;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primaryContainer;
    final textStyle = theme.textTheme.titleLarge;

    final padding = Padding(
      padding: _iconPadding,
      child: IconButton(
        onPressed: closeReport,
        icon: Icon(AppIcons.close, color: theme.colorScheme.onPrimary),
      ),
    );
    return TitleBar.withBackButton(
      LocaleKeys.ExaminationReport_title.tr(),
      appBarTheme: AppBarTheme(
        color: backgroundColor,
        titleTextStyle: textStyle,
      ),
      leading: padding,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

const _buttonPadding = EdgeInsets.only(top: lowIndent);
const _heartRecordsAmountPadding = EdgeInsets.only(
  left: lowestIndent,
  right: lowestIndent,
  top: lowestIndent,
  bottom: belowMediumIndent,
);
const _padding = EdgeInsets.symmetric(horizontal: middleIndent);
const _iconPadding = EdgeInsets.only(left: aboveLowestIndent);
const _tinyIndent = 4.0;
const _indentBetweenButtonAndDisclaimer = 54.0;
