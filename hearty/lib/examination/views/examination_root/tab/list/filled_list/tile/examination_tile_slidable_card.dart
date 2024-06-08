part of 'examination_tile.dart';

class _SlidableCard extends StatelessWidget {
  final String examinationId;
  final bool? received;

  const _SlidableCard(
    this.examinationId, {
    this.received,
  });

  @override
  Widget build(BuildContext context) {
    final slidable = Slidable(
      key: ValueKey(examinationId),
      endActionPane: _buildActionPane(),
      child: _Card(examinationId, received: received),
    );

    return __SlidableCardLayout(child: slidable);
  }

  ActionPane _buildActionPane() {
    final editButton = EditButton(examinationId: examinationId);
    final shareButton = ShareButton(examinationId: examinationId);
    final deleteButton = DeleteButton(examinationId: examinationId);
    const behindMotion = BehindMotion();

    return ActionPane(
      motion: behindMotion,
      children: [editButton, shareButton, deleteButton],
    );
  }
}

class __SlidableCardLayout extends StatelessWidget {
  static final borderRadius = BorderRadius.circular(lowIndent);
  final Widget child;

  const __SlidableCardLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decoration = BoxDecoration(
      color: theme.colorScheme.secondary,
      borderRadius: borderRadius,
    );

    return Container(decoration: decoration, child: child);
  }
}
