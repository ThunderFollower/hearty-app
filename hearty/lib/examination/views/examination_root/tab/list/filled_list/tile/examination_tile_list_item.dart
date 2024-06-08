part of 'examination_tile.dart';

class _ListItem extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? subtitle;
  final Color? tileColor;
  final EdgeInsetsGeometry? contentPadding;
  final GestureTapCallback? onTap;
  final bool? enableFeedback;

  const _ListItem({
    super.key,
    this.leading,
    this.trailing,
    this.title,
    this.subtitle,
    this.tileColor,
    this.contentPadding,
    this.onTap,
    this.enableFeedback,
  });

  @override
  Widget build(BuildContext context) {
    final header = __ItemHeader(title: title, trailing: trailing);
    final body = __ItemContent(header: header, body: subtitle);

    final tile = Row(
      children: [
        if (leading != null) leading!,
        const SizedBox(width: belowLowIndent),
        Expanded(child: body),
      ],
    );
    return _wrapTile(tile);
  }

  Widget _wrapTile(Widget tile) {
    final padding = contentPadding;
    final decoratedBox = DecoratedBox(
      decoration: BoxDecoration(color: tileColor),
      child: padding != null ? Padding(padding: padding, child: tile) : tile,
    );
    return InkWell(
      onTap: onTap,
      enableFeedback: enableFeedback,
      child: decoratedBox,
    );
  }
}

class __ItemContent extends StatelessWidget {
  const __ItemContent({
    required this.header,
    required this.body,
  });

  final __ItemHeader header;
  final Widget? body;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          if (body != null) body!,
        ],
      );
}

class __ItemHeader extends StatelessWidget {
  const __ItemHeader({
    required this.title,
    required this.trailing,
  });

  final Widget? title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null) title!,
          if (trailing != null) trailing!,
        ],
      );
}
