import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget(
      {this.obscureText = false,
      this.textCapitalization = TextCapitalization.none,
      required this.hintText,
      required this.onSaved,
      required this.validator,
      this.icons,
      this.textinput = TextInputType.text,
      super.key});
  final bool obscureText;
  final String hintText;
  final IconButton? icons;
  final TextInputType textinput;
  final TextCapitalization textCapitalization;
  final FormFieldSetter<String>? onSaved;  
  final FormFieldValidator<String> validator; 
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textinput,
      obscureText: obscureText,
      autocorrect: false,
      textCapitalization: textCapitalization,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        hintText: hintText,
        suffixIcon: icons,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
