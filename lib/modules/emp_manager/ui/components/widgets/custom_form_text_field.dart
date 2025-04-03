import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yd8/core/common/types.dart';

class CustomFormTextField extends StatelessWidget {
  final String labelText;
  final FormValidator? validator;
  final bool isOptional;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  const CustomFormTextField({
    super.key,
    required this.labelText,
    this.isOptional = false,
    this.inputFormatters,
    this.controller,
    this.validator,
  });

  RichText _buildLabelWithAsterisk(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return RichText(
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(text: labelText),
          if (!isOptional)
            TextSpan(text: ' *', style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  static String? requiredValidator(String? input) {
    if (input == null || input.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: isOptional ? validator : validator ?? requiredValidator,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: _buildLabelWithAsterisk(context),
      ),
    );
  }
}
