import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldEdit extends StatelessWidget {
  final TextInputType keyboardType;
  final void Function(String)? onPressed;
  final bool obscureText;
  final String labelText;
  final String initialValue;
  final TextInputFormatter lengthLimitFormatter;
  final TextInputFormatter numericFilterFormatter;
  final String? Function(String?)? validator;
  final bool enabled;

  CustomTextFieldEdit({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.labelText,
    required this.initialValue,
    required this.onPressed,
    required this.lengthLimitFormatter,
    required this.numericFilterFormatter,
    this.validator,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      initialValue: initialValue,
      onChanged: enabled ? onPressed : null,
      inputFormatters:
      enabled ? [lengthLimitFormatter, numericFilterFormatter] : [],
      validator: validator,
      style: TextStyle(
        fontWeight: enabled ? FontWeight.normal : FontWeight.bold,
        color: enabled ? Colors.black : Colors.grey,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
        TextStyle(fontFamily: "font1", fontSize: 35, color: Colors.blueGrey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      enabled: enabled,
    );
  }
}
