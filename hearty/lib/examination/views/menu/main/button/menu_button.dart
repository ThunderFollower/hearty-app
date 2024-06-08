import 'package:flutter/material.dart';


class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  const MenuButton({
    super.key,
    required this.text,
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 140,
      child: ElevatedButton(
        onPressed: handler,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(5.0),
          backgroundColor: Colors.pink,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
