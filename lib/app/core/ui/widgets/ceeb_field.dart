import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CeebField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? enabled;
  final Function(String)? onChanged;
  final bool? capitalize;

  CeebField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.enabled = true,
    this.suffixIconButton,
    this.controller,
    this.validator,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.capitalize,
  })  : assert(
          obscureText == true ? suffixIconButton == null : true,
          'obscureText não pode ser enviado em conjunto com suffixIcon',
        ),
        obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          enabled: enabled,
          onChanged: onChanged,
          textCapitalization: capitalize == true
              ? TextCapitalization.characters
              : TextCapitalization.none,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue)),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        icon: Icon(!obscureTextValue
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
