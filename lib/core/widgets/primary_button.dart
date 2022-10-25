import 'package:flutter/material.dart';

import '../values/styles.dart';

/// If [isLoading] is true, than the button will be disabled
/// and shown circular progress bar to proceed the [onPressed]
/// actions.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (!isLoading && isEnabled) ? onPressed : null,
      style: primaryButtonStyle((!isLoading && isEnabled)),
      child: SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: isLoading
              ? _loadingWidget()
              : Text(text, style: textSemiBoldWhite_14pt),
        ),
      ),
    );
  }

  Widget _loadingWidget() => const Center(
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 3.0),
        ),
      );
}
