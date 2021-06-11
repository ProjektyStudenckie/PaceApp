import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final bool obscureText;
  final Function(String) onChanged;
  final int maxLength;

  const DefaultTextFormField(
      {Key? key,
      this.initialValue = "",
      this.labelText = "",
      this.obscureText = false,
      required this.onChanged,
      this.maxLength = 300})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(8.0)))),
    );
  }
}
