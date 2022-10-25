import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../values/styles.dart';

enum TextFieldType {
  text,
  digitsOnly,
  capsEachWord,
  password,
  email,
}

class PrimaryTextField extends StatefulWidget {
  final String label;
  final Key? formKey;
  final Function(String)? onChanged;
  final String? errorMessage;
  final List<TextFieldType> inputType;

  const PrimaryTextField({
    Key? key,
    required this.label,
    this.formKey,
    this.onChanged,
    this.errorMessage,
    this.inputType = const [TextFieldType.text],
  }) : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final isValid = widget.errorMessage != null;
    return Form(
      key: widget.formKey,
      child: TextFormField(
          maxLength: 100,
          onChanged: widget.onChanged,
          obscureText: widget.inputType.contains(TextFieldType.password) &&
              !_isPasswordVisible,
          enableSuggestions: !widget.inputType.contains(TextFieldType.password),
          autocorrect: !widget.inputType.contains(TextFieldType.password),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textCapitalization:
              widget.inputType.contains(TextFieldType.capsEachWord)
                  ? TextCapitalization.words
                  : TextCapitalization.none,
          keyboardType: widget.inputType.contains(TextFieldType.digitsOnly)
              ? const TextInputType.numberWithOptions()
              : TextInputType.text,
          decoration: _inputDecoration(
            context,
            !isValid ? colorGray1 : colorRed20,
            widget.label,
          ),
          inputFormatters: widget.inputType.contains(TextFieldType.digitsOnly)
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          validator: (_) {
            return widget.errorMessage;
          }),
    );
  }

  InputDecoration _inputDecoration(BuildContext context, Color color,
      [String? label]) {
    return InputDecoration(
      fillColor: color,
      counterText: '',
      filled: true,
      labelStyle: textRegularGray_14pt,
      labelText: label,
      contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      focusedBorder: _outlinedBorder(colorPrimary),
      focusedErrorBorder: _outlinedBorder(colorRedError),
      suffixIcon: widget.inputType.contains(TextFieldType.password)
          ? IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: colorGray4,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
          : null,
    );
  }

  OutlineInputBorder _outlinedBorder(Color c) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: c, width: 2),
    );
  }
}
