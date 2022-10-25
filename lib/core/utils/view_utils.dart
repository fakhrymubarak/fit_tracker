import 'package:flutter/material.dart';

import '../values/styles.dart';

void showSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: textRegularWhite_14pt),
    ));


void buildBottomSheet({
  required BuildContext context,
  required Widget bottomSheetWidget,
}) {
  final screenSize = MediaQuery.of(context).size;
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(maxHeight: screenSize.height - 50),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        topLeft: Radius.circular(16),
      ),
    ),
    builder: (BuildContext context) => bottomSheetWidget,
  );
}
