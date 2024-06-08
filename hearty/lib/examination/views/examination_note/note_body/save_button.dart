part of 'notes_body.dart';

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.onTap,
    this.shouldAddHorizontalPaddings = false,
  });

  final VoidCallback? onTap;
  final bool shouldAddHorizontalPaddings;

  @override
  Widget build(BuildContext context) {
    final button = RoundCornersButton(
      onTap: _save,
      enabled: onTap != null,
      title: LocaleKeys.NotesBody_Save.tr(),
    );
    final edgeInsets = EdgeInsets.fromLTRB(
      shouldAddHorizontalPaddings ? middleIndent : 0.0,
      middleIndent,
      shouldAddHorizontalPaddings ? middleIndent : 0.0,
      highIndent,
    );
    return Padding(padding: edgeInsets, child: button);
  }

  void _save() {
    if (notesBodyFormKey.currentState!.validate()) {
      notesBodyFormKey.currentState!.save();
      onTap?.call();
    }
  }
}
