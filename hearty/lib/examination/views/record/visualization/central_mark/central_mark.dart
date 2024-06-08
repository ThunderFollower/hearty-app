import 'package:flutter/material.dart';

class CentralMark extends StatelessWidget {
  const CentralMark({super.key});

  @override
  Widget build(BuildContext context) =>
      const Align(child: _CentralMarkDivider());
}

class _CentralMarkDivider extends StatelessWidget {
  const _CentralMarkDivider();

  @override
  Widget build(BuildContext context) => VerticalDivider(
        width: 1,
        thickness: 1,
        color: Theme.of(context).colorScheme.secondary,
      );
}
