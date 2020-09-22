import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputField extends StatelessWidget {
  final String labelText, errorText;
  final Icon prefixIcon;
  final void Function(String value) onChanged, onFieldSubmitted;
  final TextInputAction textInputAction;
  final bool obscureText;
  final TextInputType keyboardType;

  const InputField({
    Key key,
    this.labelText,
    this.errorText,
    this.prefixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.obscureText = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: prefixIcon,
          labelText: labelText,
          errorText: errorText,
        ),
        textInputAction: textInputAction,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }
}
