import 'package:flutter/material.dart';

import '../../../../../../../core/views/theme/index.dart';

class ValuePicker extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? handler;
  final double width;
  final double height;
  final Color? bgColor;
  final Function(String?)? onSaved;
  final String? initialValue;

  const ValuePicker({
    super.key,
    required this.handler,
    required this.width,
    required this.height,
    this.controller,
    this.initialValue,
    this.onSaved,
    this.bgColor,
    this.focusNode,
  }) : assert(controller != null || initialValue != null);

  @override
  State<ValuePicker> createState() => _ValuePickerState();
}

class _ValuePickerState extends State<ValuePicker> {
  FocusNode? _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode;
    _focusNode?.addListener(_onFocus);
    super.initState();
  }

  void _onFocus() {
    if (_focusNode!.hasFocus && widget.handler != null) {
      widget.handler!();
    }
  }

  @override
  void didUpdateWidget(covariant ValuePicker oldWidget) {
    _controller.text = widget.initialValue ?? _controller.text;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.controller ?? _controller.dispose();
    _focusNode?.removeListener(_onFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      width: widget.width,
      height: widget.height,
      child: InkWell(
        onTap: widget.handler,
        child: Stack(
          children: [
            TextFormField(
              focusNode: widget.focusNode,
              enabled: widget.focusNode != null,
              decoration: InputDecoration(
                filled: widget.bgColor != null,
                fillColor: widget.bgColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      AppIcons.collapse,
                      size: 16,
                      color: AppColors.grey[900],
                    ),
                  ),
                ),
              ),
              style: TextStyle(color: AppColors.grey[900], fontSize: 14),
              textInputAction: TextInputAction.next,
              onSaved: widget.onSaved,
              controller: _controller,
            ),
            const Text(
              'selector_patient_position',
              style: TextStyle(fontSize: 0),
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}
