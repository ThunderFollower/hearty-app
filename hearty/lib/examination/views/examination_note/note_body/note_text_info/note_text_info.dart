import 'package:flutter/material.dart';
import '../../../../../core/views/theme/index.dart';
import '../disease_element/section/section_name.dart';

class NoteTextInfo extends StatelessWidget {
  const NoteTextInfo({
    super.key,
    required this.title,
    required this.mainText,
  });

  final String title;
  final String mainText;

  @override
  Widget build(BuildContext context) {
    final titleText = SectionName(name: title);

    const indent = SizedBox(height: belowLowIndent);

    final mainInfo = Padding(
      padding: const EdgeInsets.only(left: lowestIndent),
      child: Text(mainText),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText,
        indent,
        mainInfo,
      ],
    );
  }
}
