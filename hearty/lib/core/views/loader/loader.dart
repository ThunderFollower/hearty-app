import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Loader extends ConsumerWidget {
  const Loader({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(color: Colors.pink),
        SizedBox(height: text != null ? 20 : 0, width: double.infinity),
        if (text != null)
          Text(
            text!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.pink,
            ),
          ),
      ],
    );
  }
}
