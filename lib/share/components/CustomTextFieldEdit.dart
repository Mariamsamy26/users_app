import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldEdit extends StatelessWidget {
  final TextInputType keyboardType;
  final void Function(String)? onPressed;
  final bool obscureText;
  final String labelText;
  final String initialValue;
  final String oldData;
  final TextInputFormatter lengthLimitFormatter;
  final TextInputFormatter numericFilterFormatter;
  final String? Function(String?) validator;
  final bool enabled;

  CustomTextFieldEdit({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.labelText,
    required this.initialValue,
    required this.onPressed,
    String? oldData,
    required this.lengthLimitFormatter,
    required this.numericFilterFormatter,
    required this.validator,
    this.enabled = true,
  })  : oldData = oldData ?? initialValue,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      initialValue: initialValue,
      onChanged: enabled ? onPressed : null,
      inputFormatters:
          enabled ? [lengthLimitFormatter, numericFilterFormatter] : [],
      validator: enabled ? validator : null,
      style: TextStyle(
        fontWeight: enabled ? FontWeight.normal : FontWeight.bold,
        color: enabled ? Colors.black : Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
            TextStyle(fontFamily: "font1", fontSize: 35, color: Colors.blueGrey),
      ),
      enabled: enabled,
    );
  }
}
