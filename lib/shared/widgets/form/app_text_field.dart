import 'package:flutter/material.dart';
import 'package:myplaces/shared/widgets/form/generic_form_field.dart';

class TextInputFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextInputFormField({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return GenericFormField(
      label: label,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
