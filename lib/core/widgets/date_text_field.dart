import 'package:fit_tracker/core/core.dart';
import 'package:flutter/material.dart';

class DateTextField extends StatefulWidget {
  final String labelHint;
  final TextEditingController? controller;
  final VoidCallback? ontap;

  const DateTextField(
      {Key? key, required this.labelHint, this.controller, this.ontap})
      : super(key: key);

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        readOnly: true,
        onTap: widget.ontap,
        controller: widget.controller,
        decoration: _inputDecoration(widget.labelHint, widget.ontap),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelHint, VoidCallback? onTap) {
    return InputDecoration(
      fillColor: colorGray1,
      filled: true,
      labelStyle: textRegularGray_14pt,
      labelText: labelHint,
      suffixIcon: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.calendar_month_rounded),
      ),
      contentPadding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: colorPrimary, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    );
  }
}
